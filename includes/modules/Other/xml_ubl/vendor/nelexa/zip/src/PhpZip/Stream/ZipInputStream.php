<?php

namespace PhpZip\Stream;

use PhpZip\Crypto\TraditionalPkwareEncryptionEngine;
use PhpZip\Crypto\WinZipAesEngine;
use PhpZip\Exception\Crc32Exception;
use PhpZip\Exception\InvalidArgumentException;
use PhpZip\Exception\RuntimeException;
use PhpZip\Exception\ZipCryptoException;
use PhpZip\Exception\ZipException;
use PhpZip\Exception\ZipUnsupportMethod;
use PhpZip\Extra\Fields\WinZipAesEntryExtraField;
use PhpZip\Mapper\OffsetPositionMapper;
use PhpZip\Mapper\PositionMapper;
use PhpZip\Model\EndOfCentralDirectory;
use PhpZip\Model\Entry\ZipSourceEntry;
use PhpZip\Model\ZipEntry;
use PhpZip\Model\ZipModel;
use PhpZip\Util\PackUtil;
use PhpZip\ZipFileInterface;

/**
 * Read zip file
 *
 * @author Ne-Lexa alexey@nelexa.ru
 * @license MIT
 */
class ZipInputStream implements ZipInputStreamInterface
{
    /**
     * @var resource
     */
    protected $in;
    /**
     * @var PositionMapper
     */
    protected $mapper;
    /**
     * @var int The number of bytes in the preamble of this ZIP file.
     */
    protected $preamble = 0;
    /**
     * @var int The number of bytes in the postamble of this ZIP file.
     */
    protected $postamble = 0;
    /**
     * @var ZipModel
     */
    protected $zipModel;

    /**
     * ZipInputStream constructor.
     * @param resource $in
     * @throws RuntimeException
     */
    public function __construct($in)
    {
        if (!is_resource($in)) {
            throw new RuntimeException('$in must be resource');
        }
        $this->in = $in;
        $this->mapper = new PositionMapper();
    }

    /**
     * @return ZipModel
     */
    public function readZip()
    {
        $this->checkZipFileSignature();
        $endOfCentralDirectory = $this->readEndOfCentralDirectory();
        $entries = $this->mountCentralDirectory($endOfCentralDirectory);
        $this->zipModel = ZipModel::newSourceModel($entries, $endOfCentralDirectory);
        return $this->zipModel;
    }

    /**
     * Check zip file signature
     *
     * @throws ZipException if this not .ZIP file.
     */
    protected function checkZipFileSignature()
    {
        rewind($this->in);
        // Constraint: A ZIP file must start with a Local File Header
        // or a (ZIP64) End Of Central Directory Record if it's empty.
        $signatureBytes = fread($this->in, 4);
        if (strlen($signatureBytes) < 4) {
            throw new ZipException("Invalid zip file.");
        }
        $signature = unpack('V', $signatureBytes)[1];
        if (
            ZipEntry::LOCAL_FILE_HEADER_SIG !== $signature
            && EndOfCentralDirectory::ZIP64_END_OF_CENTRAL_DIRECTORY_RECORD_SIG !== $signature
            && EndOfCentralDirectory::END_OF_CENTRAL_DIRECTORY_RECORD_SIG !== $signature
        ) {
            throw new ZipException("Expected Local File Header or (ZIP64) End Of Central Directory Record! Signature: " . $signature);
        }
    }

    /**
     * @return EndOfCentralDirectory
     * @throws ZipException
     */
    protected function readEndOfCentralDirectory()
    {
        $comment = null;
        // Search for End of central directory record.
        $stats = fstat($this->in);
        $size = $stats['size'];
        $max = $size - EndOfCentralDirectory::END_OF_CENTRAL_DIRECTORY_RECORD_MIN_LEN;
        $min = $max >= 0xffff ? $max - 0xffff : 0;
        for ($endOfCentralDirRecordPos = $max; $endOfCentralDirRecordPos >= $min; $endOfCentralDirRecordPos--) {
            fseek($this->in, $endOfCentralDirRecordPos, SEEK_SET);
            // end of central dir signature    4 bytes  (0x06054b50)
            if (EndOfCentralDirectory::END_OF_CENTRAL_DIRECTORY_RECORD_SIG !== unpack('V', fread($this->in, 4))[1]) {
                continue;
            }

            // number of this disk                        - 2 bytes
            // number of the disk with the start of the
            //        central directory                   - 2 bytes
            // total number of entries in the central
            //        directory on this disk              - 2 bytes
            // total number of entries in the central
            //        directory                           - 2 bytes
            // size of the central directory              - 4 bytes
            // offset of start of central directory with
            //        respect to the starting disk number - 4 bytes
            // ZIP file comment length                    - 2 bytes
            $data = unpack(
                'vdiskNo/vcdDiskNo/vcdEntriesDisk/vcdEntries/VcdSize/VcdPos/vcommentLength',
                fread($this->in, 18)
            );

            if (0 !== $data['diskNo'] || 0 !== $data['cdDiskNo'] || $data['cdEntriesDisk'] !== $data['cdEntries']) {
                throw new ZipException(
                    "ZIP file spanning/splitting is not supported!"
                );
            }
            // .ZIP file comment       (variable size)
            if (0 < $data['commentLength']) {
                $comment = fread($this->in, $data['commentLength']);
            }
            $this->preamble = $endOfCentralDirRecordPos;
            $this->postamble = $size - ftell($this->in);

            // Check for ZIP64 End Of Central Directory Locator.
            $endOfCentralDirLocatorPos = $endOfCentralDirRecordPos - EndOfCentralDirectory::ZIP64_END_OF_CENTRAL_DIRECTORY_LOCATOR_LEN;

            fseek($this->in, $endOfCentralDirLocatorPos, SEEK_SET);
            // zip64 end of central dir locator
            // signature                       4 bytes  (0x07064b50)
            if (
                0 > $endOfCentralDirLocatorPos ||
                ftell($this->in) === $size ||
                EndOfCentralDirectory::ZIP64_END_OF_CENTRAL_DIRECTORY_LOCATOR_SIG !== unpack('V', fread($this->in, 4))[1]
            ) {
                // Seek and check first CFH, probably requiring an offset mapper.
                $offset = $endOfCentralDirRecordPos - $data['cdSize'];
                fseek($this->in, $offset, SEEK_SET);
                $offset -= $data['cdPos'];
                if (0 !== $offset) {
                    $this->mapper = new OffsetPositionMapper($offset);
                }
                $entryCount = $data['cdEntries'];
                return new EndOfCentralDirectory($entryCount, $comment);
            }

            // number of the disk with the
            // start of the zip64 end of
            // central directory               4 bytes
            $zip64EndOfCentralDirectoryRecordDisk = unpack('V', fread($this->in, 4))[1];
            // relative offset of the zip64
            // end of central directory record 8 bytes
            $zip64EndOfCentralDirectoryRecordPos = PackUtil::unpackLongLE(fread($this->in, 8));
            // total number of disks           4 bytes
            $totalDisks = unpack('V', fread($this->in, 4))[1];
            if (0 !== $zip64EndOfCentralDirectoryRecordDisk || 1 !== $totalDisks) {
                throw new ZipException("ZIP file spanning/splitting is not supported!");
            }
            fseek($this->in, $zip64EndOfCentralDirectoryRecordPos, SEEK_SET);
            // zip64 end of central dir
            // signature                       4 bytes  (0x06064b50)
            $zip64EndOfCentralDirSig = unpack('V', fread($this->in, 4))[1];
            if (EndOfCentralDirectory::ZIP64_END_OF_CENTRAL_DIRECTORY_RECORD_SIG !== $zip64EndOfCentralDirSig) {
                throw new ZipException("Expected ZIP64 End Of Central Directory Record!");
            }
            // size of zip64 end of central
            // directory record                8 bytes
            // version made by                 2 bytes
            // version needed to extract       2 bytes
            fseek($this->in, 12, SEEK_CUR);
            // number of this disk             4 bytes
            $diskNo = unpack('V', fread($this->in, 4))[1];
            // number of the disk with the
            // start of the central directory  4 bytes
            $cdDiskNo = unpack('V', fread($this->in, 4))[1];
            // total number of entries in the
            // central directory on this disk  8 bytes
            $cdEntriesDisk = PackUtil::unpackLongLE(fread($this->in, 8));
            // total number of entries in the
            // central directory               8 bytes
            $cdEntries = PackUtil::unpackLongLE(fread($this->in, 8));
            if (0 !== $diskNo || 0 !== $cdDiskNo || $cdEntriesDisk !== $cdEntries) {
                throw new ZipException("ZIP file spanning/splitting is not supported!");
            }
            if ($cdEntries < 0 || 0x7fffffff < $cdEntries) {
                throw new ZipException("Total Number Of Entries In The Central Directory out of range!");
            }
            // size of the central directory   8 bytes
            fseek($this->in, 8, SEEK_CUR);
            // offset of start of central
            // directory with respect to
            // the starting disk number        8 bytes
            $cdPos = PackUtil::unpackLongLE(fread($this->in, 8));
            // zip64 extensible data sector    (variable size)
            fseek($this->in, $cdPos, SEEK_SET);
            $this->preamble = $zip64EndOfCentralDirectoryRecordPos;
            $entryCount = $cdEntries;
            $zip64 = true;
            return new EndOfCentralDirectory($entryCount, $comment, $zip64);
        }
        // Start recovering file entries from min.
        $this->preamble = $min;
        $this->postamble = $size - $min;
        return new EndOfCentralDirectory(0, $comment);
    }

    /**
     * Reads the central directory from the given seekable byte channel
     * and populates the internal tables with ZipEntry instances.
     *
     * The ZipEntry's will know all data that can be obtained from the
     * central directory alone, but not the data that requires the local
     * file header or additional data to be read.
     *
     * @param EndOfCentralDirectory $endOfCentralDirectory
     * @return ZipEntry[]
     * @throws ZipException
     */
    protected function mountCentralDirectory(EndOfCentralDirectory $endOfCentralDirectory)
    {
        $numEntries = $endOfCentralDirectory->getEntryCount();
        $entries = [];

        for (; $numEntries > 0; $numEntries--) {
            $entry = $this->readEntry();
            // Re-load virtual offset after ZIP64 Extended Information
            // Extra Field may have been parsed, map it to the real
            // offset and conditionally update the preamble size from it.
            $lfhOff = $this->mapper->map($entry->getOffset());
            $lfhOff = PHP_INT_SIZE === 4 ? sprintf('%u', $lfhOff) : $lfhOff;
            if ($lfhOff < $this->preamble) {
                $this->preamble = $lfhOff;
            }
            $entries[$entry->getName()] = $entry;
        }

        if (0 !== $numEntries % 0x10000) {
            throw new ZipException("Expected " . abs($numEntries) .
                ($numEntries > 0 ? " more" : " less") .
                " entries in the Central Directory!");
        }

        if ($this->preamble + $this->postamble >= fstat($this->in)['size']) {
            assert(0 === $numEntries);
            $this->checkZipFileSignature();
        }

        return $entries;
    }

    /**
     * @return ZipEntry
     * @throws InvalidArgumentException
     */
    public function readEntry()
    {
        // central file header signature   4 bytes  (0x02014b50)
        $fileHeaderSig = unpack('V', fread($this->in, 4))[1];
        if (ZipOutputStreamInterface::CENTRAL_FILE_HEADER_SIG !== $fileHeaderSig) {
            throw new InvalidArgumentException("Corrupt zip file. Can not read zip entry.");
        }

        // version made by                 2 bytes
        // version needed to extract       2 bytes
        // general purpose bit flag        2 bytes
        // compression method              2 bytes
        // last mod file time              2 bytes
        // last mod file date              2 bytes
        // crc-32                          4 bytes
        // compressed size                 4 bytes
        // uncompressed size               4 bytes
        // file name length                2 bytes
        // extra field length              2 bytes
        // file comment length             2 bytes
        // disk number start               2 bytes
        // internal file attributes        2 bytes
        // external file attributes        4 bytes
        // relative offset of local header 4 bytes
        $data = unpack(
            'vversionMadeBy/vversionNeededToExtract/vgpbf/' .
            'vrawMethod/VrawTime/VrawCrc/VrawCompressedSize/' .
            'VrawSize/vfileLength/vextraLength/vcommentLength/' .
            'VrawInternalAttributes/VrawExternalAttributes/VlfhOff',
            fread($this->in, 42)
        );

//        $utf8 = 0 !== ($data['gpbf'] & self::GPBF_UTF8);

        // See appendix D of PKWARE's ZIP File Format Specification.
        $name = fread($this->in, $data['fileLength']);

        $entry = new ZipSourceEntry($this);
        $entry->setName($name);
        $entry->setVersionNeededToExtract($data['versionNeededToExtract']);
        $entry->setPlatform($data['versionMadeBy'] >> 8);
        $entry->setMethod($data['rawMethod']);
        $entry->setGeneralPurposeBitFlags($data['gpbf']);
        $entry->setDosTime($data['rawTime']);
        $entry->setCrc($data['rawCrc']);
        $entry->setCompressedSize($data['rawCompressedSize']);
        $entry->setSize($data['rawSize']);
        $entry->setExternalAttributes($data['rawExternalAttributes']);
        $entry->setOffset($data['lfhOff']); // must be unmapped!
        if (0 < $data['extraLength']) {
            $entry->setExtra(fread($this->in, $data['extraLength']));
        }
        if (0 < $data['commentLength']) {
            $entry->setComment(fread($this->in, $data['commentLength']));
        }
        return $entry;
    }

    /**
     * @param ZipEntry $entry
     * @return string
     * @throws ZipException
     */
    public function readEntryContent(ZipEntry $entry)
    {
        if ($entry->isDirectory()) {
            return null;
        }
        if (!($entry instanceof ZipSourceEntry)) {
            throw new InvalidArgumentException('entry must be ' . ZipSourceEntry::class);
        }
        $isEncrypted = $entry->isEncrypted();
        if ($isEncrypted && null === $entry->getPassword()) {
            throw new ZipException("Can not password from entry " . $entry->getName());
        }

        $pos = $entry->getOffset();
        assert(ZipEntry::UNKNOWN !== $pos);
        $pos = PHP_INT_SIZE === 4 ? sprintf('%u', $pos) : $pos;

        $startPos = $pos = $this->mapper->map($pos);
        fseek($this->in, $startPos);

        // local file header signature     4 bytes  (0x04034b50)
        if (ZipEntry::LOCAL_FILE_HEADER_SIG !== unpack('V', fread($this->in, 4))[1]) {
            throw new ZipException($entry->getName() . " (expected Local File Header)");
        }
        fseek($this->in, $pos + ZipEntry::LOCAL_FILE_HEADER_FILE_NAME_LENGTH_POS);
        // file name length                2 bytes
        // extra field length              2 bytes
        $data = unpack('vfileLength/vextraLength', fread($this->in, 4));
        $pos += ZipEntry::LOCAL_FILE_HEADER_MIN_LEN + $data['fileLength'] + $data['extraLength'];

        assert(ZipEntry::UNKNOWN !== $entry->getCrc());

        $method = $entry->getMethod();

        fseek($this->in, $pos);

        // Get raw entry content
        $compressedSize = $entry->getCompressedSize();
        $compressedSize = PHP_INT_SIZE === 4 ? sprintf('%u', $compressedSize) : $compressedSize;
        if ($compressedSize > 0) {
            $content = fread($this->in, $compressedSize);
        } else {
            $content = '';
        }

        $skipCheckCrc = false;
        if ($isEncrypted) {
            if (ZipEntry::METHOD_WINZIP_AES === $method) {
                // Strong Encryption Specification - WinZip AES
                $winZipAesEngine = new WinZipAesEngine($entry);
                $content = $winZipAesEngine->decrypt($content);
                /**
                 * @var WinZipAesEntryExtraField $field
                 */
                $field = $entry->getExtraFieldsCollection()->get(WinZipAesEntryExtraField::getHeaderId());
                $method = $field->getMethod();
                $entry->setEncryptionMethod($field->getEncryptionMethod());
                $skipCheckCrc = true;
            } else {
                // Traditional PKWARE Decryption
                $zipCryptoEngine = new TraditionalPkwareEncryptionEngine($entry);
                $content = $zipCryptoEngine->decrypt($content);
                $entry->setEncryptionMethod(ZipFileInterface::ENCRYPTION_METHOD_TRADITIONAL);
            }

            if (!$skipCheckCrc) {
                // Check CRC32 in the Local File Header or Data Descriptor.
                $localCrc = null;
                if ($entry->getGeneralPurposeBitFlag(ZipEntry::GPBF_DATA_DESCRIPTOR)) {
                    // The CRC32 is in the Data Descriptor after the compressed size.
                    // Note the Data Descriptor's Signature is optional:
                    // All newer apps should write it (and so does TrueVFS),
                    // but older apps might not.
                    fseek($this->in, $pos + $compressedSize);
                    $localCrc = unpack('V', fread($this->in, 4))[1];
                    if (ZipEntry::DATA_DESCRIPTOR_SIG === $localCrc) {
                        $localCrc = unpack('V', fread($this->in, 4))[1];
                    }
                } else {
                    fseek($this->in, $startPos + 14);
                    // The CRC32 in the Local File Header.
                    $localCrc = sprintf('%u', fread($this->in, 4)[1]);
                    $localCrc = PHP_INT_SIZE === 4 ? sprintf('%u', $localCrc) : $localCrc;
                }

                $crc = PHP_INT_SIZE === 4 ? sprintf('%u', $entry->getCrc()) : $entry->getCrc();

                if ($crc != $localCrc) {
                    throw new Crc32Exception($entry->getName(), $crc, $localCrc);
                }
            }
        }

        switch ($method) {
            case ZipFileInterface::METHOD_STORED:
                break;
            case ZipFileInterface::METHOD_DEFLATED:
                $content = gzinflate($content);
                break;
            case ZipFileInterface::METHOD_BZIP2:
                if (!extension_loaded('bz2')) {
                    throw new ZipException('Extension bzip2 not install');
                }
                $content = bzdecompress($content);
                break;
            default:
                throw new ZipUnsupportMethod($entry->getName() .
                    " (compression method " . $method . " is not supported)");
        }
        if (!$skipCheckCrc) {
            $localCrc = crc32($content);
            $localCrc = PHP_INT_SIZE === 4 ? sprintf('%u', $localCrc) : $localCrc;
            $crc = PHP_INT_SIZE === 4 ? sprintf('%u', $entry->getCrc()) : $entry->getCrc();
            if ($crc != $localCrc) {
                if ($isEncrypted) {
                    throw new ZipCryptoException("Wrong password");
                }
                throw new Crc32Exception($entry->getName(), $crc, $localCrc);
            }
        }
        return $content;
    }

    /**
     * @return resource
     */
    public function getStream()
    {
        return $this->in;
    }

    /**
     * @param ZipEntry $entry
     * @param ZipOutputStreamInterface $out
     */
    public function copyEntry(ZipEntry $entry, ZipOutputStreamInterface $out)
    {
        $pos = $entry->getOffset();
        assert(ZipEntry::UNKNOWN !== $pos);
        $pos = PHP_INT_SIZE === 4 ? sprintf('%u', $pos) : $pos;
        $pos = $this->mapper->map($pos);

        $nameLength = strlen($entry->getName());

        fseek($this->in, $pos + ZipEntry::LOCAL_FILE_HEADER_MIN_LEN - 2, SEEK_SET);
        $extraLength = unpack('v', fread($this->in, 2))[1];

        $length = ZipEntry::LOCAL_FILE_HEADER_MIN_LEN + $extraLength + $nameLength;

        $padding = 0;
        if ($this->zipModel->isZipAlign() && !$entry->isEncrypted() && $entry->getMethod() === ZipFileInterface::METHOD_STORED) {
            $padding =
                (
                    $this->zipModel->getZipAlign() -
                    (ftell($out->getStream()) + $length) % $this->zipModel->getZipAlign()
                ) % $this->zipModel->getZipAlign();
        }

        fseek($this->in, $pos, SEEK_SET);
        if ($padding > 0) {
            stream_copy_to_stream($this->in, $out->getStream(), ZipEntry::LOCAL_FILE_HEADER_MIN_LEN - 2);
            fwrite($out->getStream(), pack('v', $extraLength + $padding));
            fseek($this->in, 2, SEEK_CUR);
            stream_copy_to_stream($this->in, $out->getStream(), $nameLength + $extraLength);
            fwrite($out->getStream(), str_repeat(chr(0), $padding));
        } else {
            stream_copy_to_stream($this->in, $out->getStream(), $length);
        }
        stream_copy_to_stream($this->in, $out->getStream(), $entry->getCompressedSize());
        if ($entry->getGeneralPurposeBitFlag(ZipEntry::GPBF_DATA_DESCRIPTOR)) {
            $length = 12;
            if ($entry->isZip64ExtensionsRequired()) {
                $length += 8;
            }
            stream_copy_to_stream($this->in, $out->getStream(), $length);
        }
    }

    /**
     * @param ZipEntry $entry
     * @param ZipOutputStreamInterface $out
     */
    public function copyEntryData(ZipEntry $entry, ZipOutputStreamInterface $out)
    {
        $offset = $entry->getOffset();
        $offset = PHP_INT_SIZE === 4 ? sprintf('%u', $offset) : $offset;
        $offset = $this->mapper->map($offset);
        $nameLength = strlen($entry->getName());

        fseek($this->in, $offset + ZipEntry::LOCAL_FILE_HEADER_MIN_LEN - 2, SEEK_SET);
        $extraLength = unpack('v', fread($this->in, 2))[1];

        fseek($this->in, $offset + ZipEntry::LOCAL_FILE_HEADER_MIN_LEN + $nameLength + $extraLength, SEEK_SET);
        stream_copy_to_stream($this->in, $out->getStream(), $entry->getCompressedSize());
    }

    public function __destruct()
    {
        $this->close();
    }

    public function close()
    {
        if ($this->in != null) {
            fclose($this->in);
            $this->in = null;
        }
    }
}

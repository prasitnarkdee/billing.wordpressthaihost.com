<?php

namespace PhpZip\Stream;

use PhpZip\Model\ZipEntry;
use PhpZip\Model\ZipModel;

/**
 * Read zip file
 *
 * @author Ne-Lexa alexey@nelexa.ru
 * @license MIT
 */
interface ZipInputStreamInterface
{
    /**
     * @return ZipModel
     */
    public function readZip();

    /**
     * @return ZipEntry
     */
    public function readEntry();

    /**
     * @param ZipEntry $entry
     * @return string
     */
    public function readEntryContent(ZipEntry $entry);

    /**
     * @return resource
     */
    public function getStream();

    /**
     * @param ZipEntry $entry
     * @param ZipOutputStreamInterface $out
     */
    public function copyEntry(ZipEntry $entry, ZipOutputStreamInterface $out);

    /**
     * @param ZipEntry $entry
     * @param ZipOutputStreamInterface $out
     */
    public function copyEntryData(ZipEntry $entry, ZipOutputStreamInterface $out);

    public function close();
}

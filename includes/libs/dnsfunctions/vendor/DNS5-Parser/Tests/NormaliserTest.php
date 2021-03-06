<?php

namespace Badcow\DNS\Parser\Tests;

use Badcow\DNS\Parser\Normaliser;
use PHPUnit\Framework\TestCase;
class NormaliserTest extends TestCase
{
    /**
     * @var string
     */
    private $unbalancedBrackets = <<<TXT
example.com. IN SOA (
                     example.com.       ; MNAME
                     post.example.com.  ; RNAME
                     2014110501         ; SERIAL
                     3600               ; REFRESH
                     14400              ; RETRY
                     604800             ; EXPIRE
                     3600               ; MINIMUM
TXT;
    /**
     * @throws \Badcow\DNS\Parser\ParseException
     */
    public function testRemovesComments()
    {
        $zone = file_get_contents(__DIR__ . '/Resources/testClearComments_sample.txt');
        $expectation = str_replace("\r\n", "\n", file_get_contents(__DIR__ . '/Resources/testClearComments_expectation.txt'));
        $this->assertEquals($expectation, Normaliser::normalise($zone));
    }
    /**
     * Multi-line records collapse onto single line.
     *
     * @throws \Badcow\DNS\Parser\ParseException
     */
    public function testMultilineRecordsCollapseOntoSingleLine()
    {
        $zone = file_get_contents(__DIR__ . '/Resources/testCollapseMultilines_sample.txt');
        $expectation = str_replace("\r\n", "\n", file_get_contents(__DIR__ . '/Resources/testCollapseMultilines_expectation.txt'));
        $this->assertEquals($expectation, Normaliser::normalise($zone));
    }
    /**
     * Unbalanced brackets cause ParseException.
     *
     * @expectedException \Badcow\DNS\Parser\ParseException
     * @expectedExceptionMessage End of file reached. Unclosed bracket.
     *
     * @throws \Badcow\DNS\Parser\ParseException
     */
    public function testUnbalancedBracketsCauseParseException()
    {
        Normaliser::normalise($this->unbalancedBrackets);
    }
    /**
     * Unbalanced quotation marks cause ParseException.
     *
     * @expectedException \Badcow\DNS\Parser\ParseException
     * @expectedExceptionMessage Unbalanced double quotation marks. End of file reached.
     *
     * @throws \Badcow\DNS\Parser\ParseException
     */
    public function testUnbalancedQuotationMarksCauseParseException()
    {
        $string = 'mail IN TXT "Some string';
        Normaliser::normalise($string);
    }
    /**
     * Line feed inside quotation marks cause exception.
     *
     * @expectedException \Badcow\DNS\Parser\ParseException
     * @expectedExceptionMessage Line Feed found within double quotation marks context. [Line no: 2]
     *
     * @throws \Badcow\DNS\Parser\ParseException
     */
    public function testLineFeedInsideQuotationMarksCauseException()
    {
        $string = "www IN CNAME @\n     mail IN TXT \"Some \nstring\"";
        Normaliser::normalise($string);
    }
}
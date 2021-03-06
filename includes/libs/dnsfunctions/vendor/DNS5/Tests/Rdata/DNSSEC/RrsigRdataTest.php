<?php

/*
 * This file is part of Badcow-DNS.
 *
 * (c) Samuel Williams <sam@badcow.co>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
namespace Badcow\DNS\Tests\Rdata\DNSSEC;

use Badcow\DNS\Rdata\A;
use Badcow\DNS\Rdata\DNSSEC\Algorithms;
use Badcow\DNS\Rdata\DNSSEC\RRSIG;
use Badcow\DNS\Rdata\Factory;
class RrsigRdataTest extends \PHPUnit\Framework\TestCase
{
    private static $signature = 'oJB1W6WNGv+ldvQ3WDG0MQkg5IEhjRip8WTrPYGv07h108dUKGMeDPKijVCHX3DDKdfb+v6oB9wfuh3DTJXUA' . 'fI/M0zmO/zz8bW0Rznl8O3tGNazPwQKkRN20XPXV6nwwfoXmJQbsLNrLfkGJ5D6fwFm8nN+6pBzeDQfsS3Ap3o=';
    public function testOutput()
    {
        if (2147483647 === PHP_INT_MAX) {
            $this->markTestSkipped('RRSIG test does not work on 32-bit systems.');
        }
        $expectation = 'A 5 3 86400 20050322173103 20030220173103 2642 example.com. ' . self::$signature;
        $rrsig = new RRSIG();
        $rrsig->setTypeCovered('A');
        $rrsig->setAlgorithm(Algorithms::RSASHA1);
        $rrsig->setLabels(3);
        $rrsig->setOriginalTtl(86400);
        $rrsig->setSignatureExpiration(20050322173103);
        $rrsig->setSignatureInception(20030220173103);
        $rrsig->setKeyTag(2642);
        $rrsig->setSignersName('example.com.');
        $rrsig->setSignature(self::$signature);
        $this->assertEquals($expectation, $rrsig->output());
    }
    public function testFactory()
    {
        $rrsig = Factory::Rrsig(A::TYPE, Algorithms::RSASHA1, 3, 86400, 2020, 2015, 2642, 'example.com.', self::$signature);
        $this->assertEquals(A::TYPE, $rrsig->getTypeCovered());
        $this->assertEquals(Algorithms::RSASHA1, $rrsig->getAlgorithm());
        $this->assertEquals(3, $rrsig->getLabels());
        $this->assertEquals(86400, $rrsig->getOriginalTtl());
        $this->assertEquals(2020, $rrsig->getSignatureExpiration());
        $this->assertEquals(2015, $rrsig->getSignatureInception());
        $this->assertEquals(2642, $rrsig->getKeyTag());
        $this->assertEquals('example.com.', $rrsig->getSignersName());
        $this->assertEquals(self::$signature, $rrsig->getSignature());
    }
}
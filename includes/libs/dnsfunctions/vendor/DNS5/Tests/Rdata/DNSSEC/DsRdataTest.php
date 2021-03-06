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

use Badcow\DNS\Rdata\DNSSEC\Algorithms;
use Badcow\DNS\Rdata\DNSSEC\DS;
use Badcow\DNS\Rdata\Factory;
class DsRdataTest extends \PHPUnit\Framework\TestCase
{
    private static $digest = '2BB183AF5F22588179A53B0A98631FAD1A292118';
    public function testOutput()
    {
        $expectation = '60485 5 1 ' . self::$digest;
        $ds = new DS();
        $ds->setKeyTag(60485);
        $ds->setAlgorithm(Algorithms::RSASHA1);
        $ds->setDigestType(DS::DIGEST_SHA1);
        $ds->setDigest(self::$digest);
        $this->assertEquals($expectation, $ds->output());
    }
    public function testFactory()
    {
        $keyTag = 60485;
        $ds = Factory::Ds($keyTag, Algorithms::RSASHA1, self::$digest, DS::DIGEST_SHA1);
        $this->assertEquals($keyTag, $ds->getKeyTag());
        $this->assertEquals(Algorithms::RSASHA1, $ds->getAlgorithm());
        $this->assertEquals(self::$digest, $ds->getDigest());
        $this->assertEquals(DS::DIGEST_SHA1, $ds->getDigestType());
    }
}
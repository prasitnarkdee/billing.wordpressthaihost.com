<?php

/*
 * This file is part of Badcow DNS Library.
 *
 * (c) Samuel Williams <sam@badcow.co>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
namespace Badcow\DNS\Tests\Rdata;

use Badcow\DNS\Rdata\AAAA;
class AaaaRdataTest extends \PHPUnit\Framework\TestCase
{
    public function testSetAddress()
    {
        $address = '2003:dead:beef:4dad:23:46:bb:101';
        $aaaa = new AAAA();
        $aaaa->setAddress($address);
        $this->assertEquals($address, $aaaa->getAddress());
    }
}
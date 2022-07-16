<?php

/*
 * This file is part of Badcow DNS Library.
 *
 * (c) Samuel Williams <sam@badcow.co>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */
namespace Badcow\DNS\Rdata;

trait RdataTrait
{
    /**
     * {@inheritdoc}
     */
    public function getType()
    {
        /* @const TYPE */
        return static::TYPE;
    }
}
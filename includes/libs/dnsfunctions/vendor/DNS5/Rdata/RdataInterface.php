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

interface RdataInterface
{
    /**
     * @return string
     */
    public function output();
    /**
     * Get the R-Data type.
     *
     * @return string
     */
    public function getType();
}
<?php

namespace Kinikit\Core\Exception;

/**
 * Created by PhpStorm.
 * User: nathanalan
 * Date: 01/09/2014
 * Time: 10:14
 */
class NoneAssociativeArrayAccessException extends \Exception {

    public function __construct() {
        parent::__construct("None associative array items cannot be set as members to dynamic serialisable objects");
    }

} 
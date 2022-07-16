<?php

namespace Kinikit\Core\Exception;

/**
 * Generic validation exception which accepts an array of problems keyed in by a field key.
 *
 * @author oxil
 *
 */
class ValidationException extends \Exception {

    private $validationErrors;

    /**
     * Construct with an array of validation errors.
     * and a seperator which defaults to html new line.
     *
     * @param array $validationErrors
     */
    public function __construct($validationErrors) {
        $this->validationErrors = $validationErrors;
        parent::__construct("The following fields have validation errors: " . join(", ", array_keys($this->validationErrors)));
    }

    /**
     * @return the $exceptionArray
     */
    public function getValidationErrors() {
        return $this->validationErrors;
    }

}

?>
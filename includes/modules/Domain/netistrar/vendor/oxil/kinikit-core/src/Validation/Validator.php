<?php
/**
 * Created by PhpStorm.
 * User: mark
 * Date: 17/08/2018
 * Time: 11:26
 */

namespace Kinikit\Core\Validation;


use Kinikit\Core\Exception\ClassNotSerialisableException;
use Kinikit\Core\Exception\InvalidValidatorException;
use Kinikit\Core\Object\SerialisableObject;
use Kinikit\Core\Util\Annotation\ClassAnnotationParser;
use Kinikit\Core\Util\Serialisation\XML\XMLToObjectConverter;
use Kinikit\Core\Validation\FieldValidators\DateFieldValidator;
use Kinikit\Core\Validation\FieldValidators\EqualsFieldValidator;
use Kinikit\Core\Validation\FieldValidators\LengthFieldValidator;
use Kinikit\Core\Validation\FieldValidators\RangeFieldValidator;
use Kinikit\Core\Validation\FieldValidators\RegexpFieldValidator;
use Kinikit\Core\Validation\FieldValidators\RequiredFieldValidator;

class Validator {

    private static $instance;
    private $validators;

    public function __construct() {


        if (file_exists("Config/field-validators.xml")) {
            $converter = new XMLToObjectConverter(array("FieldValidators" => "Array"), false);
            $this->validators = $converter->convert(file_get_contents("Config/field-validators.xml"));
        }


        $this->validators["required"] = new RequiredFieldValidator("This field is required");
        $this->validators["regexp"] = new RegexpFieldValidator(null, "Value does not match the required format");
        $this->validators["equals"] = new EqualsFieldValidator("Value does not match the $1 field");
        $this->validators["minlength"] = new LengthFieldValidator(LengthFieldValidator::MODE_MIN, "Value must be at least $1 characters");
        $this->validators["maxlength"] = new LengthFieldValidator(LengthFieldValidator::MODE_MAX, "Value must be no greater than $1 characters");
        $this->validators["min"] = new RangeFieldValidator(RangeFieldValidator::MODE_MIN, "Value must be at least $1");
        $this->validators["max"] = new RangeFieldValidator(RangeFieldValidator::MODE_MAX, "Value must be no greater than $1");
        $this->validators["range"] = new RangeFieldValidator(RangeFieldValidator::MODE_RANGE, "Value must be between $1 and $2");

        $this->validators["numeric"] = new RegexpFieldValidator("[0-9]*", "Value must be numeric");
        $this->validators["alphanumeric"] = new RegexpFieldValidator("[a-zA-Z0-9]*", "Value must be alphanumeric");
        $this->validators["name"] = new RegexpFieldValidator("[a-zA-Z0-9 \-']*", "Value must be a valid name");
        $this->validators["email"] = new RegexpFieldValidator("(?:[a-z0-9!#$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+\/=?^_`{|}~-]+)*|\"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])", "Value must be a valid email");
        $this->validators["date"] = new DateFieldValidator("Value must be a date in $1 format");
    }


    /**
     * Validate a serialisable object
     *
     * @param SerialisableObject $object
     */
    public function validateObject($object) {
        if (!$object instanceof SerialisableObject) {
            throw new ClassNotSerialisableException(get_class($object));
        }

        $classAnnotations = ClassAnnotationParser::instance()->parse($object);

        $validationFields = $classAnnotations->getFieldAnnotationsForMatchingTag("validation");

        $validationErrors = array();

        foreach ($validationFields as $field => $annotation) {

            $value = $object->__getSerialisablePropertyValue($field);

            foreach ($annotation[0]->getValues() as $validatorString) {

                $explodedValidator = explode("(", $validatorString);
                $validatorKey = trim($explodedValidator[0]);

                // Gather validator args if supplied.
                $validatorArgs = array();
                if (sizeof($explodedValidator) > 1) {
                    $argsCSV = explode(")", $explodedValidator[1]);
                    $args = explode("|", $argsCSV[0]);

                    foreach ($args as $arg) {
                        $validatorArgs[] = trim($arg);
                    }
                }

                $validator = isset($this->validators[$validatorKey]) ? $this->validators[$validatorKey] : null;
                if (isset($validator)) {
                    $valid = $validator->validateObjectFieldValue($value, $field, $object, $validatorArgs, $validatorKey);

                    if ($valid !== true) {
                        if (!isset($validationErrors[$field])) $validationErrors[$field] = array();
                        $message = preg_replace_callback("/\\$([0-9])/", function ($matches) use ($validatorArgs) {
                            return $validatorArgs[$matches[1] - 1];
                        }, $validator->getValidationMessage());
                        $validationErrors[$field][$validatorKey] = new FieldValidationError($field, $validatorKey, $message);
                    }

                } else {
                    throw new InvalidValidatorException($validatorKey, $field, $object);
                }


            }

        }

        return $validationErrors;


    }

    /**
     * Return singleton instance
     */
    public static function instance() {

        if (!self::$instance) {
            self::$instance = new Validator();
        }

        return self::$instance;

    }

}
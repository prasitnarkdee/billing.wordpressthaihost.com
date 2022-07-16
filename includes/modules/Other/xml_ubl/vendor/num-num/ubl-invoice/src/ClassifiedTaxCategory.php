<?php

namespace NumNum\UBL;

use InvalidArgumentException;
use Sabre\Xml\Writer;
use Sabre\Xml\XmlSerializable;

class ClassifiedTaxCategory implements XmlSerializable
{
    private $id;
    private $name;
    private $percent;
    private $taxScheme;
    private $taxExemptionReason;
    private $taxExemptionReasonCode;
    private $schemeID;
    private $schemeName;

    public const UNCL5305 = 'UNCL5305';

    /**
     * @return mixed
     */
    public function getId()
    {
        if (!empty($this->id)) {
            return $this->id;
        }

        if ($this->getPercent() !== null) {
            if ($this->getPercent() >= 21) {
                return 'S';
            } elseif ($this->getPercent() <= 21 && $this->getPercent() >= 6) {
                return 'AA';
            } else {
                return 'Z';
            }
        }

        return null;
    }

    /**
     * @param mixed $id
     * @return ClassifiedTaxCategory
     */
    public function setId($id)
    {
        $this->id = $id;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     * @return ClassifiedTaxCategory
     */
    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getPercent()
    {
        return $this->percent;
    }

    /**
     * @param mixed $percent
     * @return ClassifiedTaxCategory
     */
    public function setPercent($percent)
    {
        $this->percent = $percent;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getTaxScheme()
    {
        return $this->taxScheme;
    }

    /**
     * @param mixed $taxScheme
     * @return ClassifiedTaxCategory
     */
    public function setTaxScheme($taxScheme)
    {
        $this->taxScheme = $taxScheme;
        return $this;
    }

    /**
     * @param mixed $id
     * @return ClassifiedTaxCategory
     */
    public function setSchemeID($id)
    {
        $this->schemeID = $id;
        return $this;
    }

    /**
     * @param mixed $name
     * @return ClassifiedTaxCategory
     */
    public function setSchemeName($name)
    {
        $this->schemeName = $name;
        return $this;
    }

    /**
     * The validate function that is called during xml writing to valid the data of the object.
     *
     * @throws InvalidArgumentException An error with information about required data that is missing to write the XML
     * @return void
     */
    public function validate()
    {
        if ($this->getId() === null) {
            throw new InvalidArgumentException('Missing taxcategory id');
        }

        if ($this->getPercent() === null) {
            throw new InvalidArgumentException('Missing taxcategory percent');
        }
    }

    /**
     * The xmlSerialize method is called during xml writing.
     *
     * @param Writer $writer
     * @return void
     */
    public function xmlSerialize(Writer $writer)
    {
        $this->validate();
        $schemeAttributes = array();
        if ($this->schemeID !== null) {
            $schemeAttributes['schemeID'] = $this->schemeID;
        }
        if ($this->schemeName !== null) {
            $schemeAttributes['schemeName'] = $this->schemeName;
        }
        $writer->write([
            [
                'name' => Schema::CBC . 'ID',
                'value' => $this->getId(),
                'attributes' => $schemeAttributes

            ],
            Schema::CBC . 'Percent' => number_format($this->percent, 2, '.', ''),
        ]);

        if ($this->name !== null) {
            $writer->write([
                Schema::CBC . 'Name' => $this->name,
            ]);
        }

        if ($this->taxExemptionReasonCode !== null) {
            $writer->write([
                Schema::CBC . 'TaxExemptionReasonCode' => $this->taxExemptionReasonCode,
                Schema::CBC . 'TaxExemptionReason' => $this->taxExemptionReason,
            ]);
        }

        if ($this->taxScheme !== null) {
            $writer->write([Schema::CAC . 'TaxScheme' => $this->taxScheme]);
        } else {
            $writer->write([
                Schema::CAC . 'TaxScheme' => null,
            ]);
        }
    }
}

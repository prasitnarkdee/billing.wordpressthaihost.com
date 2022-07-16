<?php

namespace NumNum\UBL;

use InvalidArgumentException;
use Sabre\Xml\Writer;
use Sabre\Xml\XmlSerializable;

class TaxTotal implements XmlSerializable
{
    private $taxAmount;
    private $taxSubTotals = [];

    /**
     * @return mixed
     */
    public function getTaxAmount()
    {
        return $this->taxAmount;
    }

    /**
     * @param mixed $taxAmount
     * @return TaxTotal
     */
    public function setTaxAmount($taxAmount)
    {
        $this->taxAmount = $taxAmount;
        return $this;
    }

    /**
     * @return array
     */
    public function getTaxSubTotals()
    {
        return $this->taxSubTotals;
    }

    /**
     * @param TaxSubTotal $taxSubTotal
     * @return TaxTotal
     */
    public function addTaxSubTotal(TaxSubTotal $taxSubTotal)
    {
        $this->taxSubTotals[] = $taxSubTotal;
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
        if ($this->taxAmount === null) {
            throw new InvalidArgumentException('Missing taxtotal taxamount');
        }
    }

    /**
     * The xmlSerialize method is called during xml writing.
     * @param Writer $writer
     * @return void
     */
    public function xmlSerialize(Writer $writer)
    {
        $this->validate();

        $writer->write([
            [
                'name' => Schema::CBC . 'TaxAmount',
                'value' => number_format($this->taxAmount, 2, '.', ''),
                'attributes' => [
                    'currencyID' => Generator::$currencyID
                ]
            ],
        ]);

        foreach ($this->taxSubTotals as $taxSubTotal) {
            $writer->write([Schema::CAC . 'TaxSubtotal' => $taxSubTotal]);
        }
    }
}

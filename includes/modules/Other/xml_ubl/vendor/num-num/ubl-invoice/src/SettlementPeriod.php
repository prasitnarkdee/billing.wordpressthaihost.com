<?php

namespace NumNum\UBL;

use DateTime;
use InvalidArgumentException;
use Sabre\Xml\Writer;
use Sabre\Xml\XmlSerializable;

class SettlementPeriod implements XmlSerializable
{
    private $startDate;
    private $endDate;

    /**
     * @return DateTime
     */
    public function getStartDate()
    {
        return $this->startDate;
    }

    /**
     * @param DateTime $startDate
     * @return SettlementPeriod
     */
    public function setStartDate(DateTime $startDate)
    {
        $this->startDate = $startDate;
        return $this;
    }

    /**
     * @return DateTime
     */
    public function getEndDate()
    {
        return $this->endDate;
    }

    /**
     * @param DateTime $endDate
     * @return SettlementPeriod
     */
    public function setEndDate(DateTime $endDate)
    {
        $this->endDate = $endDate;
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
        if ($this->startDate === null) {
            throw new InvalidArgumentException('Missing startDate');
        }
        if ($this->endDate === null) {
            throw new InvalidArgumentException('Missing endDate');
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

        $writer->write([
            Schema::CBC . 'StartDate' => $this->startDate->format('Y-m-d'),
            Schema::CBC . 'EndDate' => $this->endDate->format('Y-m-d'),
        ]);

        $writer->write([
            [
                'name' => Schema::CBC . 'DurationMeasure',
                'value' => $this->endDate->diff($this->startDate)->format('%d'),
                'attributes' => [
                    'unitCode' => 'DAY'
                ]
            ]
        ]);
    }
}

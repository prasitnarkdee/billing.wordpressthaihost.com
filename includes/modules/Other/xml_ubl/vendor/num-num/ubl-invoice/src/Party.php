<?php

namespace NumNum\UBL;

use Sabre\Xml\Writer;
use Sabre\Xml\XmlSerializable;

class Party implements XmlSerializable
{
    private $name;
    private $postalAddress;
    private $physicalLocation;
    private $contact;
    private $companyId;
    private $taxCompanyId;
    private $taxCompanyName;
    private $taxScheme;
    private $legalEntity;

    /**
     * @return mixed
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * @param mixed $name
     * @return Party
     */
    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }

    /**
     * @return Address
     */
    public function getPostalAddress()
    {
        return $this->postalAddress;
    }

    /**
     * @param Address $postalAddress
     * @return Party
     */
    public function setPostalAddress($postalAddress)
    {
        $this->postalAddress = $postalAddress;
        return $this;
    }

    /**
     * @return string
     */
    public function getCompanyId()
    {
        return $this->companyId;
    }

    /**
     * @param string $companyId
     * @return Party
     */
    public function setCompanyId($companyId)
    {
        $this->companyId = $companyId;
    }

    /**
     * @param string $taxCompanyId
     */
    public function setTaxCompanyId($companyId)
    {
        $this->taxCompanyId = $companyId;
        return $this;
    }

    /**
     * @param string $taxCompanyName
     * @return Party
     */
    public function setTaxCompanyName($companyName)
    {
        $this->taxCompanyName = $companyName;
        return $this;
    }

    /**
     * @param TaxScheme $taxScheme.
     * @return mixed
     */
    public function getTaxScheme()
    {
        return $this->taxScheme;
    }

    /**
     * @param TaxScheme $taxScheme
     * @return Party
     */
    public function setTaxScheme(TaxScheme $taxScheme)
    {
        $this->taxScheme = $taxScheme;
        return $this;
    }

    /**
     * @return LegalEntity
     */
    public function getLegalEntity()
    {
        return $this->legalEntity;
    }

    /**
     * @param LegalEntity $legalEntity
     * @return Party
     */
    public function setLegalEntity(LegalEntity $legalEntity)
    {
        $this->legalEntity = $legalEntity;
        return $this;
    }

    /**
     * @return string
     */
    public function getPartyIdentificationId()
    {
        return $this->partyIdentificationId;
    }

    /**
     * @param string $partyIdentificationId
     * @return Party
     */
    public function setPartyIdentificationId($partyIdentificationId)
    {
        $this->partyIdentificationId = $partyIdentificationId;
        return $this;
    }

    /**
     * @return Address
     */
    public function getPhysicalLocation()
    {
        return $this->physicalLocation;
    }

    /**
     * @param Address $physicalLocation
     * @return Party
     */
    public function setPhysicalLocation(Address $physicalLocation)
    {
        $this->physicalLocation = $physicalLocation;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getContact()
    {
        return $this->contact;
    }

    /**
     * @param mixed $contact
     * @return Party
     */
    public function setContact($contact)
    {
        $this->contact = $contact;
        return $this;
    }

    /**
     * The xmlSerialize method is called during xml writing.
     *
     * @param Writer $writer
     * @return void
     */
    public function xmlSerialize(Writer $writer)
    {
        if ($this->partyIdentificationId !== null) {
            $writer->write([
                Schema::CAC . 'PartyIdentification' => [
                    Schema::CBC . 'ID' => $this->partyIdentificationId
                ],
            ]);
        }

        $writer->write([
            Schema::CAC . 'PartyName' => [
                Schema::CBC . 'Name' => $this->name
            ],
            Schema::CAC . 'PostalAddress' => $this->postalAddress
        ]);

        if ($this->physicalLocation !== null) {
            $writer->write([
               Schema::CAC . 'PhysicalLocation' => [Schema::CAC . 'Address' => $this->physicalLocation]
            ]);
        }

        if ($this->taxScheme !== null) {
            $partyTaxScheme = [];

            if ($this->taxCompanyName !== null) {
                $partyTaxScheme[Schema::CBC . 'RegistrationName'] = $this->taxCompanyName;
            }

            if ($this->taxCompanyId !== null) {
                $partyTaxScheme[Schema::CBC . 'CompanyID'] = $this->taxCompanyId;
            }

            $partyTaxScheme[Schema::CAC . 'TaxScheme'] = $this->taxScheme;

            $writer->write([
                Schema::CAC . 'PartyTaxScheme' => $partyTaxScheme
            ]);
        }

        if ($this->contact !== null) {
            $writer->write([
                Schema::CAC . 'Contact' => $this->contact
            ]);
        }

        if ($this->legalEntity !== null) {
            $writer->write([
                Schema::CAC . 'PartyLegalEntity' => $this->legalEntity
            ]);
        }
    }
}

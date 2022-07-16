<?php


namespace GlobalPayments\Api\Entities\Enums;


use GlobalPayments\Api\Entities\Enum;

class MerchantInitiatedRequestType extends Enum
{
    const RECURRING_TRANSACTION = "RECURRING_TRANSACTION";
    const INSTALLMENT_TRANSACTION = "INSTALLMENT_TRANSACTION";
    const ADD_CARD = "ADD_CARD";
    const MAINTAIN_CARD_INFORMATION = "MAINTAIN_CARD_INFORMATION";
    const ACCOUNT_VERIFICATION = "ACCOUNT_VERIFICATION";
    const SPLIT_OR_DELAYED_SHIPMENT = "SPLIT_OR_DELAYED_SHIPMENT";
    const TOP_UP = "TOP_UP";
    const MAIL_ORDER = "MAIL_ORDER";
    const TELEPHONE_ORDER = "TELEPHONE_ORDER";
    const WHITELIST_STATUS_CHECK = "WHITELIST_STATUS_CHECK";
    const OTHER_PAYMENT = "OTHER_PAYMENT";
    const BILLING_AGREEMENT = "BILLING_AGREEMENT";

}
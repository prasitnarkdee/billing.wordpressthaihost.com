UPDATE `hb_language_locales` SET `section`='global' WHERE `keyword` IN ('contracts_desc', 'contracts_order_number', 'contracts_order_date', 'contracts_accepted_date', 'contracts_accepted_by', 'contracts_info', 'contracts_accept', 'contract_as_pdf', 'contract_attachments');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'thank_you_for_payment', 'Thank you for your payment!' FROM hb_language WHERE target = 'user';
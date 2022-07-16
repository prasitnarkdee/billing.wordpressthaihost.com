REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'DefaultBillingCycle', 'Default billing cycle' FROM hb_language
UNION SELECT id, 'global', 'cant_show_send_epp_1', 'One of invoices for this domain (%s) is unpaid, please settle it first to reveal Auth Info / EPP Key.' FROM hb_language
UNION SELECT id, 'global', 'cant_show_send_epp_2', 'To access/reveal Auth Info / EPP Key please ensure you have positive balance/no unpaid invoices with us first.' FROM hb_language;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('DefaultBillingCycle', 'm');

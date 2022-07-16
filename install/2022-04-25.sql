ALTER TABLE `hb_aff_widlog`
ADD COLUMN `currency_id` INT(11) NOT NULL DEFAULT '0' AFTER `amount`,
ADD COLUMN `transaction_id` INT(11) NULL DEFAULT NULL AFTER `currency_id`;
##########
UPDATE hb_aff_widlog l
LEFT JOIN hb_aff a ON a.id=l.aff_id
LEFT JOIN hb_client_billing b ON b.client_id=a.client_id
SET l.currency_id=b.currency_id;
##########
UPDATE `hb_widgets_config` SET `options`=153 WHERE widget='relatedinvoices';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clients', 'CCChargeAuto', 'Auto charge credit cards' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'clients', 'CCChargeAutoNo', 'No, Do not charge automatically' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'clients', 'CCChargeAutoYes', 'Yes, Charge automatically stored credit cards' FROM hb_language WHERE target = 'admin';
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('TranslateInvoiceLines', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'TranslateInvoiceLines','Translate invoice lines' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'TranslateInvoiceLinesOpt1','Do not translate invoice lines' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'TranslateInvoiceLinesOpt2','Translate invoice lines to selected language' FROM hb_language WHERE target='admin'
UNION SELECT id, 'invoices', 'translation','Translation' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_invoice_items` ADD `description2` TEXT NOT NULL DEFAULT '' AFTER `description`;
##########
UPDATE `hb_language_locales` SET `value`='List of all your domains. ' WHERE `value`= 'List of all yours domains. ';
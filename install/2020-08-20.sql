ALTER TABLE `hb_invoices` MODIFY COLUMN `status` ENUM('Paid','Unpaid','Cancelled','Draft','Recurring','Refunded','Credited','Creditnote','CreditnoteDraft','Collections','Receiptunpaid','Receiptpaid') NOT NULL DEFAULT 'Draft';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'invoices', 'CreditnoteDraft', 'Credit note Draft' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'creditnotedraft', 'Credit note Draft' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'accept', 'Accept' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'accept_creditnote_confirm', 'Do you really want to accept this credit note?' FROM hb_language WHERE target='admin';
##########
REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('CNoteDowngradeAsDraft', 'off');
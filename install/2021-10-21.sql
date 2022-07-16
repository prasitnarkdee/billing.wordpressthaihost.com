ALTER TABLE `hb_invoices` CHANGE `status` `status` ENUM('Paid','Unpaid','Cancelled','Draft','Recurring','Refunded','Credited','Creditnote','CreditnoteDraft','Collections','Receiptunpaid','Receiptpaid','Chargeback')    NOT NULL  DEFAULT 'Draft';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Chargeback','Chargeback' FROM hb_language
UNION SELECT id, 'invoices', 'Chargebackinvoices','Chargeback invoices' FROM hb_language WHERE target !='user'
UNION SELECT id, 'invoices', 'inv_markedchargeback','Invoice %s has been marked as Chargeback' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'invs_markedchargeback','Selected Invoices Marked Chargeback' FROM hb_language WHERE target!='user';

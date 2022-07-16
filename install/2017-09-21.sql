CREATE TABLE IF NOT EXISTS `hb_creditreceipts` (
  `invoice_id` int(11) NOT NULL,
  `credit_receipt_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_id`,`credit_receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;
##########
ALTER TABLE `hb_invoices` CHANGE `status` `status` ENUM('Paid','Unpaid','Cancelled','Draft','Recurring','Refunded','Credited','Creditnote','Collections','Receiptunpaid','Receiptpaid')  CHARACTER SET utf8  NOT NULL  DEFAULT 'Draft';
##########
ALTER TABLE `hb_templates` CHANGE `target` `target` ENUM('admin','user','invoice','estimate','creditnote','creditreceipt')  CHARACTER SET utf8   NOT NULL  DEFAULT 'invoice';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Receiptunpaid', 'Unpaid Receipt' FROM hb_language
UNION SELECT id, 'global', 'Receiptpaid', 'Paid Receipt'  FROM hb_language
UNION SELECT id, 'global', 'Receiptspaid', 'Paid Credit Receipts'  FROM hb_language
UNION SELECT id, 'global', 'Receiptsunpaid', 'Unpaid Credit Receipts'  FROM hb_language
UNION SELECT id, 'global', 'creditreceipt', 'Credit Receipt'  FROM hb_language;
##########
REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('ReceiptEnable', 'off'),('ReceiptNumeration', '1'),('ReceiptNumerationFormat', '{$number}/{$y}'),('ReceiptTemplate',0);
##########
INSERT INTO  `hb_templates` (  `id` ,  `parent_id` ,  `name` ,  `target` ,  `created` ,  `updated` )
VALUES (
NULL , 0,  'Default',  'creditreceipt', NOW( ) , NOW( )
);
##########
REPLACE INTO hb_configuration (`setting`, `value`) SELECT 'ReceiptTemplate', `id` FROM `hb_templates` WHERE `name`='Default' AND `target`='creditreceipt';
##########
INSERT INTO `hb_template_content` (`id`, `template_id`, `name`, `content`, `checksum`, `updated`)
SELECT NULL, `id`, 'Default',  '<style type=\"text/css\"><!--\r\n    body {\r\n        font-family: Arial;\r\n    }\r\n--></style>\r\n<div style=\"padding: 40px; font-family: Arial;\" id=\"invoice-table\">\r\n<table border=\"0\" cellspacing=\"0\" style=\"width: 100%;\">\r\n<tbody>\r\n<tr id=\"invoice-header\">\r\n<td width=\"66%\" valign=\"middle\" align=\"left\" colspan=\"2\" style=\"padding-left: 10px;\"><span style=\"font-size: 18px; font-weight: bold; color: #484740;\">{$companylogo}</span> <span style=\"font-size: 18px; font-weight: bold; color: #a4a4a4;\">{$invoice.number}</span></td>\r\n<td valign=\"middle\" align=\"right\">\r\n<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.creditreceipt}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.number}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_date}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.date}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_due}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.duedate}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr id=\"invoice-details\">\r\n<td valign=\"top\" style=\"padding-top: 40px;\" width=\"33%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_to}</span><br /> <span style=\"font-size: 11px;\">{$client.companyname}<br /> {$client.firstname} {$client.lastname}<br /> {$client.address1} <br /> {$client.address2}<br /> {$client.city}, {$client.state}{$client.postcode}<br /> {$client.country} </span></td>\r\n<td valign=\"top\" style=\"padding-top: 40px;\" width=\"33%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_from}</span><br /> <span style=\"font-size: 11px;\">HostBill Demo</span></td>\r\n<td valign=\"top\" style=\"padding-top: 40px;\" align=\"left\" width=\"33%\">\r\n<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.status}:</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px; font-weight: bold;\">{$invoice.status}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.balance}:</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px; font-weight: bold;\">{$transbalance}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table class=\"invoice-table\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_desc}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_tax}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.unitcost}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.qty}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.price}</span></td>\r\n</tr>\r\n<tr>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.description}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.taxed}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.amount}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.qty}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.linetotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.subtotal}</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.subtotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$invoice.taxrate}%)</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.tax}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$invoice.taxrate2}%)</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.tax2}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$lang.total}</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$invoice.total}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\" valign=\"middle\" style=\"width: 100%;\"><span style=\"font-size: 11px;\"><em>{$invoice.notes}</em></span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table class=\"invoice-table-transaction\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td colspan=\"4\" style=\"width: 100%;\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.related_trans}</span></td>\r\n</tr>\r\n<tr>\r\n<td bgcolor=\"#f0f0f0\" align=\"left\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_date}</span></td>\r\n<td align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_gtw}</span></td>\r\n<td align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_id}</span></td>\r\n<td align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_amount}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.date}</span></td>\r\n<td align=\"center\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.module}</span></td>\r\n<td align=\"center\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.trans_id}</span></td>\r\n<td align=\"right\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.amount}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td></td>\r\n<td align=\"right\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.balance}</span></td>\r\n<td align=\"right\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$transbalance}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\" style=\"border-top: 1px solid #F0F0F0; padding-top: 10px; width: 100%;\"><span style=\"font-size: 11px; color: #a4a4a4;\">Invoice footer text</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>', '552c31955d634b1557d63af42bf1b1c4', NOW() FROM `hb_templates` WHERE `name`='Default' AND `target`='creditreceipt';
##########
INSERT INTO hb_product_types (`type`) 
SELECT 'ssltype' FROM dual WHERE NOT EXISTS (
    SELECT id FROM hb_product_types WHERE `type` = 'ssltype'
);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ssltype_hosting','SSL Certificates' FROM hb_language WHERE target='admin';
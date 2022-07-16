INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES
	(NULL, 'Invoice:Chargeback', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Chargeback', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\n    We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n    Related invoice: {$invoice.id} will be marked as Unpaid.\r\n</p>\r\n\r\n<p>\r\n    Please note: Leaving invoice in Unpaid state may result in related service suspension!\r\n</p>\r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\n We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n Related invoice: {$invoice.id} will be marked as Unpaid.\r\n\r\n Please note: Leaving invoice in Unpaid state may result in related service suspension!', 1, 2, 1, 0),
	(NULL, 'Invoice:Chargeback', 'Invoice', 'Admin', 1, 'Invoice #{$invoice.id}: Chargeback', '<h1>Client: #{$client.id} {$client.firstname} {$client.lastname} - chargeback notice</h1>\r\n\r\n<p>\r\n    We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n    Related invoice: {$invoice.id} will be marked as Unpaid.\r\n</p>\r\n\r\n<p>\r\n    Please note: Leaving invoice in Unpaid state may result in related service suspension!\r\n</p>\r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\n We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n Related invoice: {$invoice.id} will be marked as Unpaid.\r\n\r\n Please note: Leaving invoice in Unpaid state may result in related service suspension!', 1, 2, 1, 0);
##########
ALTER TABLE `hb_gateway_log` CHANGE `result` `result` ENUM('Successfull','Failure','Pending','Chargeback')   NOT NULL  DEFAULT 'Pending';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Chargeback', 'Chargeback' FROM hb_language WHERE target='admin';
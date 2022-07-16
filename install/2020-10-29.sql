INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`)
VALUES
	(NULL, 'Mobile:Invoice:Paid', 'Mobile', 'Client', 1, 'Invoice Paid', 'Dear client, Your invoice #{$invoice.id} is now paid - thank you!', 'Dear client, Your invoice #{$invoice.id} is now paid - thank you!', 0, 1, 1, 0, 0, 1);

DELETE FROM hb_email_templates WHERE tplname='Clients:Credit Balance Updated';
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`)
VALUES
	(NULL, 'Clients:Credit Added', 'General', 'Admin', 1, 'Client #{$client.id} Added Credit', '<h1>Client #{$client.id} - {$client.firstname} {$client.lastname} just added credit to his profile</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Credit before</b> {$credit.old_credit|price:$currency}<br>\r\n    <b>Credit added</b> {$credit.total|price:$currency}<br>\r\n    <b>Credit after</b> {$credit.new_credit|price:$currency}<br>\r\n</p>\r\n', 'Client #{$client.id} - {$client.firstname} {$client.lastname} just added credit to his profile\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Credit before: {$credit.old_credit|price:$currency}\r\n# Credit added: {$credit.credit|price:$currency}\r\n# Credit after: {$credit.new_credit|price:$currency}\r\n', 1, 2, 1, 1);
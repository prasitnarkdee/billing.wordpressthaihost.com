REPLACE INTO `hb_admin_widgets` (`admin_id`, `widget`, `panel`, `collapsed`, `status`, `sort_order`, `autorefresh`)
SELECT
id,  'adminevents.allinpromo3', 'left', 0, 1, 0, 0  FROM hb_admin_access WHERE status = 'Active';
##########
REPLACE INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`) VALUES
('Mobile:Invoice:Overdue', 'Mobile', 'Client', 1, 'Overdue invoice', 'Dear client, your invoice is now Overdue. To avoid service interruption, please submit payment at your earliest convenience.', '', 1, 1, 1, 0, 0, 1);
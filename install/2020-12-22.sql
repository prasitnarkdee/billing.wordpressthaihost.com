ALTER TABLE `hb_email_log` ADD INDEX (`flag`),  ADD INDEX (`status`);
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'staff_replied_to_ticket', 'Staff replied to the ticket' FROM hb_language WHERE target='user';
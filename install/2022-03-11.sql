REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'BillAfterApprovalSupervisor','Bill after supervisor approval' FROM hb_language WHERE target = 'admin';
##########
ALTER TABLE `hb_email_log` ADD `rel_type` VARCHAR(255) NULL DEFAULT '' AFTER `loglevel`;
##########
ALTER TABLE `hb_email_log` ADD `rel_id` INT(11) NOT NULL DEFAULT '0' AFTER `rel_type`;
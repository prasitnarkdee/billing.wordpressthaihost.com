ALTER TABLE hb_reports_widget ADD COLUMN `cache` INT(3) NOT NULL DEFAULT 1;
##########
ALTER TABLE hb_reports_widget ADD COLUMN `cache_unit`  enum('minutes','hours','days') NOT NULL DEFAULT 'hours';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'predefinied', 'changedept', 'Change department' FROM hb_language WHERE target = 'admin';
##########
ALTER TABLE hb_tickets_predefinied ADD COLUMN `deptid` INT(11) AFTER `priority`;
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'ticketdepts', 'business_hours','Business hours' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'day_of_week','Day of the week' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'working_hour','Working hour' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'monday','Monday' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'tuesday','Tuesday' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'wednesday','Wednesday' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'thursday','Thursday' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'friday','Friday' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'saturday','Saturday' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'sunday','Sunday' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'anytime','Anytime' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'during_business_hours','During business hours' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'outside_business_hours','Outside business hours' FROM hb_language WHERE target='admin'
UNION SELECT id, 'ticketdepts', 'override_staff_notification','Override staff notification' FROM hb_language WHERE target='admin';
##########
CREATE TABLE IF NOT EXISTS `hb_ticket_business_hours` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL,
  `day` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL DEFAULT 'monday',
  `from` VARCHAR(10) NOT NULL DEFAULT '00:00',
  `to` VARCHAR(10) NOT NULL DEFAULT '00:00',
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_ticket_departments_sla` ADD `business_hours` TINYINT(1) DEFAULT 1 AFTER `de_escalate`;
##########
ALTER TABLE `hb_ticket_departments_sla` ADD `override_staff` TEXT NULL AFTER `business_hours`;
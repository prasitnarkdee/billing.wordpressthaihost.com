CREATE TABLE IF NOT EXISTS `hb_ticket_departments_sla` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `macro_id` int(11) DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `trigger` enum('time','replytime','adminreplytime','client_reply','admin_reply') NOT NULL DEFAULT 'time',
  `trigger_unit` enum('minutes','hours','days') NOT NULL DEFAULT 'minutes',
  `trigger_value` int(11) NOT NULL DEFAULT '0',
  `trigger_status` TEXT NULL DEFAULT '',
  `datecreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`),
  KEY `level` (`level`),
  KEY `trigger` (`trigger`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO hb_ticket_departments_sla(`id`,`dept_id`,`name`,`macro_id`,`level`,`trigger`,`trigger_unit`,`trigger_value`,`trigger_status`, `datecreated`)
SELECT
NULL, id, 'Ask to close',  macro_sla0_id, 1, 'time','hours',sla_level_zero,'Answered',NOW()
FROM hb_ticket_departments WHERE sla_level_zero > 0;
##########
INSERT INTO hb_ticket_departments_sla(`id`,`dept_id`,`name`,`macro_id`,`level`,`trigger`,`trigger_unit`,`trigger_value`,`trigger_status`, `datecreated`)
SELECT
NULL, id, 'Escalate', macro_sla1_id, 2, 'time','minutes',sla_level_one, 'Open',NOW()
FROM hb_ticket_departments WHERE sla_level_one > 0;
##########
INSERT INTO hb_ticket_departments_sla(`id`,`dept_id`,`name`,`macro_id`,`level`,`trigger`,`trigger_unit`,`trigger_value`,`trigger_status`, `datecreated`)
SELECT
NULL, id, 'Overdue', macro_sla2_id, 3, 'time','hours',sla_level_two, 'Open,Answered,In-Progress',NOW()
FROM hb_ticket_departments WHERE sla_level_two > 0;
##########
ALTER TABLE `hb_tickets` CHANGE `escalated` `escalated` INT(11)  NOT NULL DEFAULT 0;
##########
ALTER TABLE `hb_tickets` ADD INDEX (`escalated`);
##########
ALTER TABLE `hb_tickets` ADD `sla_id` INT(11)   NULL DEFAULT 0  AFTER `escalated`;
##########
UPDATE hb_tickets SET start_date = '0000-00-00 00:00:00';
##########
UPDATE hb_tickets t JOIN hb_ticket_departments_sla sla ON sla.dept_id = t.dept_id  AND t.escalated = sla.level SET t.sla_id = sla.id;
##########
ALTER TABLE `hb_domains` CHANGE `name` `name` TEXT  CHARACTER SET utf8  COLLATE utf8_bin  NOT NULL;
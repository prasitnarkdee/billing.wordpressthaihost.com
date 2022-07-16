CREATE TABLE IF NOT EXISTS `hb_file_access_log` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`date` datetime NOT NULL,
`person_type` ENUM ('admin', 'client') NOT NULL,
`person_id` INT(11) NOT NULL,
`file_type` ENUM ('attachment', 'download') NOT NULL,
`file_id` INT(11) NOT NULL,
`file_name` VARCHAR(255) NOT NULL DEFAULT '',
PRIMARY KEY (`id`),
KEY `person` (`person_type`,`person_id`),
KEY `file` (`file_type`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ServiceCancellation', 'Service cancellation' FROM hb_language;
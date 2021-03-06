CREATE TABLE IF NOT EXISTS `hb_cloud_flavors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(11) NOT NULL DEFAULT '0',
  `name` varchar(127) NOT NULL,
  `description` text NOT NULL,
  `limits` text NOT NULL,
  `price_off` decimal(20,10) NOT NULL,
  `price_on` decimal(20,10) NOT NULL,
  `line_off` VARCHAR(256) NOT NULL DEFAULT '',
  `line_on` VARCHAR(256) NOT NULL DEFAULT '',
  `hours_max` int(11) NOT NULL,
  `product_id` INT(11) NULL DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_cloud_flavors_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `parent_id` INT(11) NULL,
  `account_id` int(11) NOT NULL,
  `flavor_id` int(11) NOT NULL,
  `vm_id` varchar(127) NOT NULL,
  `hostname` varchar(127) NOT NULL,
  `hours` DECIMAL(15,5) NOT NULL DEFAULT '0',
  `hours_off` DECIMAL(15,5) NOT NULL DEFAULT '0',
  `qty` DECIMAL(15,5) NOT NULL DEFAULT '0',
  `last_update` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`,`flavor_id`,`vm_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT IGNORE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'global', 'select','Select' FROM hb_language WHERE target='user'
UNION SELECT `id`, 'global', 'selected','Selected' FROM hb_language WHERE target='user';

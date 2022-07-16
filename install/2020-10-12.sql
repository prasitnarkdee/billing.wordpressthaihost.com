INSERT IGNORE INTO hb_configuration (setting, value) VALUES
('plugin_dnsdomains_register', '2'),
('plugin_dnsdomains_match', '1'),
('plugin_dnsdomains_mismatch', 'a:1:{s:10:"nameserver";i:1;}'),
('plugin_dnsdomains_package', ''),
('plugin_dnsdomains_hosting_own', ''),
('plugin_dnsdomains_hosting_sub', ''),
('plugin_dnsdomains_hosting_sameorder2', '0');
##########
CREATE TABLE IF NOT EXISTS `hb_dns_automation_rules` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR (255) NOT NULL,
  `description` TEXT NULL,
  `products` TEXT NOT NULL,
  `dns_package_id` INT(11) NOT NULL,
  `default_ip` VARCHAR (120) DEFAULT '',
  `dns_template_id` INT(11) DEFAULT 0 NOT NULL,
  `options` INT(11) DEFAULT 0 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
UPDATE hb_modules_configuration SET active = 0 WHERE filename = 'class.domaindns.php';
##########
CREATE TABLE IF NOT EXISTS `hb_dns_templates2products` (
`template_id` INT (11) NOT NULL,
`product_id` INT (11) NOT NULL,
PRIMARY KEY (`template_id`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_dns_templates2products` (`template_id`, `product_id`)
SELECT `id`, `product_id` FROM `hb_dns_templates`;
##########
ALTER TABLE `hb_dns_templates` DROP COLUMN `product_id`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'domainsettings','Domain Settings' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'dnssettings','DNS Settings' FROM hb_language  WHERE target='admin';
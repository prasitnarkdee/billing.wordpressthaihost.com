ALTER TABLE `hb_dns_templates` ADD `flags` INT(11) NOT NULL DEFAULT 0;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'CCChargeAuto', 'Auto charge credit cards' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'CCChargeAutoNo', 'No, Do not charge automatically' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'CCChargeAutoYes', 'Yes, Charge automatically stored credit cards' FROM hb_language WHERE target = 'user';
##########
REPLACE INTO `hb_client_option_item` (`option_id`, `title`, `description`, `value`, `meta`, `sort`) VALUES
(4, '{$lang.CCChargeAutoNo}', '', 'off', '[]', 1),
(4, '{$lang.CCChargeAutoYes}', '', 'on', '[]', 1);
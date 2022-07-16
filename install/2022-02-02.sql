ALTER TABLE `hb_templates` ADD `metadata` TEXT  NULL  AFTER `target`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'set_ips_tag_title','Sets the IPS tag for a domain' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'set_ips_tag','Set IPS tag' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'set_ips_confirm','Are you sure you want to set the IPS tag?' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'ips_tag_empty','The IPS tag cannot be empty' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'new_ips_tag','New IPS tag' FROM hb_language WHERE target = 'user';

REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'servers', 'login_to_panel','Login to Panel' FROM hb_language WHERE target='admin'
UNION SELECT id, 'servers', 'unable_to_login','Unable to log into the panel' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'listAppsSettings','List Servers & Apps' FROM hb_language WHERE target!='user';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',listAppsSettings') WHERE access LIKE '%appsSettings%';
##########
ALTER TABLE `hb_module_admin_acl` ADD COLUMN `type` ENUM('module', 'server') NOT NULL DEFAULT 'module';
##########
ALTER TABLE hb_module_admin_acl CHANGE module_id type_id INT(11);
##########
REPLACE INTO hb_module_admin_acl(`code`, `description`, `type_id`, `type`)
SELECT 'sso_server', CONCAT('SSO to ', s.`name`), s.`id`, 'server'
FROM hb_servers s
LEFT JOIN hb_modules_configuration m ON (s.default_module = m.id)
WHERE m.filename IN ('class.cpanel2.php', 'class.directadmin2.php', 'class.plesk12.php');
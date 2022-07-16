UPDATE `hb_admin_access` SET access = CONCAT(access, ',editDomainConfiguration') WHERE access LIKE '%editConfiguration%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',editDomainConfiguration') WHERE access LIKE '%editConfiguration%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'editDomainConfiguration','Edit Domain Settings' FROM hb_language WHERE target = 'admin';
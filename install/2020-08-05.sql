DROP TABLE IF EXISTS hb_email_templates_lang;
##########
ALTER TABLE `hb_email_templates` ADD `loglevel` TINYINT(1)  NULL  DEFAULT '1'  AFTER `notify`;
##########
ALTER TABLE `hb_email_log` ADD `loglevel` TINYINT(1)  NULL  DEFAULT '1'  AFTER `metadata`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'viewConfidentialEmailLogs', 'Access Confidential Email Logs' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'apiManagement', 'API Management' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'apiManagement_Risk', 'Allow for trusted staff only, it can give administrator means to elevate his permissions' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'editConfiguration_Risk', 'Allow for trusted staff only, it can give administrator a way to elevate his permissions' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewConfidentialEmailLogs_Risk', 'Confidential emails may contain passwords or other sensitive data' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewEmailLogs_Risk', 'Some emails may contain passwords or other sensitive data' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'viewLogs_Risk', 'Some logs may contain passwords or other sensitive data' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReports_Risk', 'Allow for trusted staff only, it can give administrator means to elevate his permissions' FROM hb_language WHERE target='admin';
##########
UPDATE hb_admin_access SET `access` = CONCAT(access, ',viewConfidentialEmailLogs') WHERE `access` LIKE '%viewEmailLogs%';
##########
UPDATE `hb_admin_teams` SET `access` = CONCAT(access, ',viewConfidentialEmailLogs') WHERE `access` LIKE '%viewEmailLogs%';
##########
UPDATE `hb_email_templates` SET `loglevel`=2 WHERE tplname LIKE 'Details:Password%' OR tplname LIKE 'Account:Created:%'  OR  tplname LIKE 'Details:Signup%'
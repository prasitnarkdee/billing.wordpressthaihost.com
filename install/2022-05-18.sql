UPDATE hb_client_option SET `meta` = '{"tags":["billing","payment"],"default":false,"allow_client_edit":true}' WHERE `key`='DefaultPaymentModule';
##########
UPDATE hb_admin_access SET `access` = CONCAT(`access`,',editClientAutomation') WHERE `access` LIKE '%editClients%';
##########
UPDATE hb_admin_teams SET `access` = CONCAT(`access`,',editClientAutomation') WHERE `access` LIKE '%editClients%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'editClientAutomation','Edit Client Automation Settings' FROM hb_language WHERE target!='user'
UNION SELECT id, 'global', 'disableEditMode','Disable Edit Mode' FROM hb_language WHERE target!='user';
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'accessEditorHTMLtags', 'Access unrestricted tags in HTML editors'  FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'editadmins', 'accessEditorHTMLtags_Risk', 'Allow for trusted staff only, it can give administrator means to elevate his permissions' FROM hb_language WHERE target='admin';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',accessEditorHTMLtags') WHERE access LIKE '%editConfiguration%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',accessEditorHTMLtags') WHERE access LIKE '%editConfiguration%';
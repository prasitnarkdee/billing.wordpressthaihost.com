REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'accounts', 'ExtraDetails', 'Extra Details' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'gauth_rememberme','Remember this device for %s days' FROM hb_language;
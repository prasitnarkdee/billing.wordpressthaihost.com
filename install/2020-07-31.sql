REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Pages', 'Pages' FROM hb_language WHERE target = 'user';
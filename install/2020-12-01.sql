REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'info_page_url', 'Info page URL' FROM hb_language WHERE target = 'admin';
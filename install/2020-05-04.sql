REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'registered_only_error', 'You must be logged in to access this page' FROM hb_language WHERE target = 'user' ;
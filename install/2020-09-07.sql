REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'confirmnschange', 'Are you sure you want to confirm NS update?' FROM hb_language WHERE target!='admin'

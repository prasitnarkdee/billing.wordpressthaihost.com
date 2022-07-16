REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'continue_shopping','Continue shopping' FROM hb_language WHERE target='user';
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'domaintaken','Taken' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'contractaccepted','Thank you for accepting contract' FROM hb_language WHERE target = 'user'
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', '_activedomainscount', 'Stat: Active domains count' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', '_activeservicescount', 'Stat: Active services count' FROM hb_language WHERE  target = 'admin'
UNION SELECT id, 'global', '_totalincome', 'Stat: Total income' FROM hb_language WHERE  target = 'admin';
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'tasklist', 'DomainRegLockDisable','Registrar lock disabled' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'tasklist', 'DomainRegLockEnable','Registrar lock enabled' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'tasklist', 'DomainRequestEPP','Request EPP/Auth code' FROM hb_language WHERE target != 'user'
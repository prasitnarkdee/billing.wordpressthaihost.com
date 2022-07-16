REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('AffCookieDays', '60');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'affiliates', 'AffCookieDays', 'Affiliate cookie lifespan' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'affiliates', 'AffCookieDaysDescr', 'Number of days since referal for how long HostBill should admits referals' FROM hb_language WHERE target = 'admin'
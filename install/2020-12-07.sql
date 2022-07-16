REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('BillingCycleFormat', ''), ('DomainPeriodFormat', '');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'cycle_discount', '-%d%% discount' FROM hb_language WHERE target = 'user';
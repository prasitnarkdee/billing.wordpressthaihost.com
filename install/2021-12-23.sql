REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('AddOverpaymentToCretid', 'on');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'AddOverpaymentToCretid','Add overpayment to credit' FROM hb_language WHERE target='admin';
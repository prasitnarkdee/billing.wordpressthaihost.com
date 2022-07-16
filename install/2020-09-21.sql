REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('AccessOrderpages', 'allow');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'profiles', 'billing_serviceprices', 'View service prices' FROM hb_language
UNION SELECT id, 'clients', 'billing_serviceprices', 'View service prices' FROM hb_language
UNION SELECT id, 'profiles', 'misc_accesscart', 'Access cart/product portfolio' FROM hb_language
UNION SELECT id, 'clients', 'misc_accesscart', 'Access cart/product portfolio' FROM hb_language;
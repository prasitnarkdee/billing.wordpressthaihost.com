REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'dnserrtlsa_name', 'Invalid TLSA name' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnserrtlsa_usage', 'Invalid TLSA usage' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnserrtlsa_selector', 'Invalid TLSA selector' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnserrtlsa_matching', 'Invalid TLSA matching-type' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnserrtlsa_hash', 'Invalid TLSA hash' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnstlsausage', 'Usage' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnstlsaselector', 'Selector' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnstlsamatching', 'Matching-Type' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'dnstlsahash', 'Hash' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'configuration', 'ClientAutocharge', 'Allow client to enable/disable autocharge' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'clientarea', 'charge_credit_cards', 'Auto charge credit cards' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'charge_credit_cards_no', 'No, Do not charge automatically' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'charge_credit_cards_yes1', 'Yes, Charge automatically stored credit cards' FROM hb_language WHERE target = 'user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('ClientAutocharge', 'off');
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'field_minopt_error', 'Field "%s" requires at least %s selected options' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'field_maxopt_error', 'Field "%s" allows maximum %s selected option' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'field_minval_error', 'Field "%s" value needs to be above %s' FROM hb_language WHERE target='user'
UNION SELECT id, 'cart', 'field_maxval_error', 'Field "%s" value needs to be below %s' FROM hb_language WHERE target='user';
##########
UPDATE `hb_language_locales` SET `value`='Grouped Checkbox'
WHERE `keyword`='multicheckbox' AND `value`='Groupped Checkbox';
##########
UPDATE `hb_language_locales` SET `value`='Invalid TLSA name'
WHERE `keyword`='dnserrtlsa_name' AND `value`='Allow client to enable/disable autocharge';
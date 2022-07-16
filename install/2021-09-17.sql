REPLACE INTO hb_configuration (`setting`, `value`)
VALUES ('LateFeeInitialOrders', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'LateFeeInitialOrders','Late Fee initial orders' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'LateFeeInitialOrdersNO','do not add late fees on initial orders' FROM hb_language WHERE target!='user'
UNION SELECT id, 'configuration', 'LateFeeInitialOrdersYES','add late fee also on initial orders' FROM hb_language WHERE target!='user';

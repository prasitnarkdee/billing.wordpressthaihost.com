REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'ServiceStatusesLimitCalculation','Service statuses for limit calculation' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'configuration', 'ServiceStatusesLimitCalculationDesc','When product ordered by client have limitation per client set you can select which service statuses goes into usage calculation. Leave empty for all statuses' FROM hb_language WHERE target = 'admin'
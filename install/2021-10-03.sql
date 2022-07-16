REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'contracts', 'mycontractstoconfirm','My contracts to confirm' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'acceptallcontracts','Accept all contracts' FROM hb_language
UNION SELECT id, 'contracts', 'allcontracts','All contracts' FROM hb_language
UNION SELECT id, 'contracts', 'allagreements','All agreements' FROM hb_language;
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('AdjustAccountInitialPeriod', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'whoisservers', 'BlockHostingCreation', 'Block hosting creation' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'whoisservers', 'BlockHostingCreationDesc', 'if there is no related domain or the related domain is still Pending' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'dns_automation', 'autoaddifexists', 'Add existing zone if it was created during hosting provision' FROM hb_language WHERE target = 'admin';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('BlockHostingCreation', 'off');
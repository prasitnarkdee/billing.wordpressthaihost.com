ALTER TABLE `hb_banned_ip` CHANGE `ip` `ip` VARCHAR(128)  NOT NULL  DEFAULT '';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'dnssec_for_domain', 'DNSSEC for this domain is:' FROM hb_language
UNION SELECT id, 'clientarea', 'confirm_disable_dnssec', 'Are you sure want to disable DNSSEC?' FROM hb_language
UNION SELECT id, 'clientarea', 'advanced', 'Advanced' FROM hb_language;
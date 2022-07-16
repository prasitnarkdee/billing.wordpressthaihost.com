REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'accountdetails', 'Account details' FROM hb_language WHERE target='user';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'dnssec_enabled', 'Enabled' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_disabled', 'Disabled' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_for_zone_is', 'DNSSEC for this zone is' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_tools', 'Tools' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_rectify_zone', 'Rectify Zone' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_enable', 'Enable DNSSEC' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_disable', 'Disable DNSSEC' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_keys', 'DNSSEC keys' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_ds', 'DNSSEC DS' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_key_tag', 'Key tag' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_algorithm', 'Algorithm' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_public_key', 'Public key' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_digest', 'Digest' FROM hb_language WHERE target='user'
UNION SELECT id, 'clientarea', 'dnssec_digest_type', 'Digest type' FROM hb_language WHERE target='user';
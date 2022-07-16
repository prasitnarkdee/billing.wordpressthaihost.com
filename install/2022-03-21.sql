REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'dns_record_not_supported', '%s records are not supported' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'invoices', 'inv_markedcredited','Invoice %s has been marked as Credited' FROM hb_language WHERE target!='user'
UNION SELECT id, 'invoices', 'ins_markedcredited','Selected Invoices Marked Credited' FROM hb_language WHERE target!='user';
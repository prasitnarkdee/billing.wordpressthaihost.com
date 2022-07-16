REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'cart', 'san_desc', 'You can enter up to %s additional names' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'note_add_to_invoice','Auto-add to invoices' FROM hb_language WHERE target='admin';
##########
ALTER TABLE `hb_notes` ADD INDEX (`flags`);
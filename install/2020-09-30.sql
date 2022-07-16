ALTER TABLE `hb_client_fields` CHANGE COLUMN `field_type` `field_type` ENUM('Select','Check','Input','Password','File','Contact','Encrypted', 'Phonenumber') NULL DEFAULT 'Input' AFTER `name`;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'global', 'stock_when','When out of stock' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'global', 'stock_follow','Follow general settings for visibility' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'global', 'stock_hide_product','Hide product from orderpage' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'global', 'stock_show_product','Show product on orderpage without ability to order' FROM hb_language WHERE target='admin';

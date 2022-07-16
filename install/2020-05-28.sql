ALTER TABLE `hb_client_fields` CHANGE `field_type` `field_type` ENUM('Select','Check','Input','Password','File','Contact','Encrypted')   NULL  DEFAULT 'Input';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'Encrypted', 'Encrypted Input' FROM hb_language WHERE target='admin';

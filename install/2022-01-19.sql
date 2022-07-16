REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('ExtensionRule', 'allow');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'AllowedAttachmentExt','Attachment extensions' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'rejectedextensions','Not allowed extensions' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'rejectedext','Not allowed extensions: %s' FROM hb_language WHERE target='user'
UNION SELECT id, 'ticketdepts', 'DoNotAddSignature','Do not add a signature to the reply' FROM hb_language  WHERE target='admin';
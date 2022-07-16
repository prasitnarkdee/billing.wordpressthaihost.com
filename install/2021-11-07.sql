REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'replydelimiter','- - - please reply above this line - - -' FROM hb_language
UNION SELECT id, 'global', 'EmailReplyDelimiter','Email reply delimiter' FROM hb_language WHERE target!='user';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('EmailReplyDelimiter', '');
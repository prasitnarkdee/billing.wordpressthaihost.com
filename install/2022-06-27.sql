INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`) VALUES
    ('importOAUTH', 'Import Tickets using oAuth method', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'ticketdepts', 'oauthmethod', 'oAuth IMAP' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'default_mail_sender', 'Default mail sender' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'additional_mail_senders', 'Additional mail senders' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'send_using', 'Send using' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'smtp', 'SMTP' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'php_mailer', 'PHP Mailer' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailAuthentication', 'Authentication' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'oauth2', 'OAuth2' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailClientID', 'Client ID' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailClientSecret', 'Client Secret' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailConnectionToken', 'Connection Token' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailRedirectURL', 'Redirect URL' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailProvider', 'Provider' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailCustom', 'Custom' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailAuthorizeURL', 'Authorize URL' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailAccessTokenURL', 'Access Token URL' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'MailResourceOwnerDetailsURL', 'Resource Owner Details URL' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'google', 'Google' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'microsoft', 'Microsoft' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'Connect', 'Connect' FROM hb_language WHERE target='admin';
##########
CREATE TABLE IF NOT EXISTS `hb_email_senders` (
`id` int(11) NOT NULL AUTO_INCREMENT,
`email` varchar(255) NOT NULL DEFAULT '',
`mailer_type` enum('php_mailer','smtp','transactional') NOT NULL DEFAULT 'php_mailer',
`mailer_data` text,
`log_admin` int(1) NOT NULL DEFAULT 0,
`cron_limit` int(11) NOT NULL DEFAULT 200,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_email_templates` ADD `sender_id` INT(11) NOT NULL DEFAULT 0 AFTER `loglevel`;
##########
ALTER TABLE `hb_ticket_departments` ADD `sender_id` INT(11) NOT NULL DEFAULT 0 AFTER `smtppassword`;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
     ('MailAuthentication', 'password'),
     ('MailProvider', 'custom');
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'multifactorauthmodules','Multi-factor Auth Modules' FROM hb_language
UNION SELECT id, 'mfa', 'mfa_deactivate','Deactivate' FROM hb_language
UNION SELECT id, 'mfa', 'mfa_activate','Activate' FROM hb_language
UNION SELECT id, 'mfa', 'mfa_configured_yes','Multi-factor authentication is configured successfully.' FROM hb_language
UNION SELECT id, 'mfa', 'mfa_configured_no','Multi-factor authentication is not configured yet!' FROM hb_language
UNION SELECT id, 'mfa', 'mfa_configure_info','Select available 2FA module to configure Multi-factor authentication' FROM hb_language
UNION SELECT id, 'mfa', 'mfa_deactivate_info','Enter your account password before disabling Multi-factor authentication' FROM hb_language
UNION SELECT id, 'global', 'mfa','Multi-factor auth' FROM hb_language
UNION SELECT id, 'global', 'mfa_force_enable','Please enable Two-Factor Authentication' FROM hb_language;
##########
ALTER TABLE `hb_client_access` ADD `mfamodule` INT(11) NULL DEFAULT '0' AFTER `loginattempts`;
##########
ALTER TABLE `hb_admin_access` ADD `mfamodule` INT(11) NULL DEFAULT '0' AFTER `access`;
##########
CREATE TABLE IF NOT EXISTS `hb_mfa` (
    `id` INT(11) NOT NULL auto_increment,
    `user_type` ENUM ('admin', 'client') NOT NULL,
    `user_id` INT(11) NOT NULL,
    `module_id` INT(11) NOT NULL,
    `data` TEXT NOT NULL,
    `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL,
    PRIMARY KEY(`id`),
    KEY(`module_id`),
    INDEX(`user_type`, `user_id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`)
VALUES ('MFA:Enabled', 'General', 'Client', 1, 'Two-factor authentication is on', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>You turned on two-factor authentication for your account. </p>\r\n<p>You can turn two-factor authentication off anytime through the security settings menu.</p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYou turned on two-factor authentication for your account. \r\nYou can turn two-factor authentication off anytime through the security settings menu.', 1, 2, 0, 0, 1, 1);
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`)
VALUES ('MFA:Disabled', 'General', 'Client', 1, 'Two-factor authentication is off', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>You turned off two-factor authentication for your account.</p>\r\n<p>You can turn two-factor authentication on anytime through the security settings menu.</p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYou turned off two-factor authentication for your account. \r\nYou can turn two-factor authentication on anytime through the security settings menu.', 1, 2, 0, 0, 1, 1);
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`)
VALUES ('MFA:Enabled', 'General', 'Admin', 1, 'Two-factor authentication is on', '<h1>Dear Staff Member,</h1>\r\n\r\n<p>You turned on two-factor authentication for your account. </p>\r\n<p>You can turn two-factor authentication off anytime through My Account settings.</p>', 'Dear Staff Member,\r\n\r\nYou turned on two-factor authentication for your account. \r\nYou can turn two-factor authentication off anytime through My Account settings.', 1, 2, 0, 0, 0, 1);
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`)
VALUES ('MFA:Disabled', 'General', 'Admin', 1, 'Two-factor authentication is off', '<h1>Dear Staff Member,</h1>\r\n\r\n<p>You turned off two-factor authentication for your account.</p>\r\n<p>You can turn two-factor authentication on anytime through My Account settings.</p>', 'Dear Staff Member,\r\n\r\nYou turned off two-factor authentication for your account.\r\nYou can turn two-factor authentication on anytime through My Account settings.', 1, 2, 0, 0, 0, 1);

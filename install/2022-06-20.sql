ALTER TABLE `hb_client_privileges`
ADD COLUMN `id` INT(11) NOT NULL AUTO_INCREMENT FIRST,
ADD COLUMN `parent_id` INT(11) NOT NULL DEFAULT '0' AFTER `client_id`,
ADD COLUMN `email` TEXT NULL AFTER `parent_id`,
ADD COLUMN `name` TEXT NULL DEFAULT NULL,
ADD COLUMN `code` CHAR(36) NULL DEFAULT NULL  AFTER `email`,
ADD COLUMN `status` ENUM('Active','Pending','Rejected','Closed') NOT NULL DEFAULT 'Active' AFTER `parent_id`,
ADD COLUMN `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER `privileges`,
ADD COLUMN `updated_at` TIMESTAMP NOT NULL AFTER `created_at`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`id`),
ADD INDEX `client_id_parent_id` (`client_id`, `parent_id`),
ADD INDEX `parent_id` (`parent_id`),
ADD INDEX `code` (`code`);
##########
UPDATE hb_client_privileges p
JOIN hb_client_details d ON d.id=p.client_id
JOIN hb_client_access a ON a.id=p.client_id
SET p.parent_id=d.parent_id, p.created_at=d.datecreated, p.email=a.email,
    p.name=CONCAT(d.firstname, ' ', d.lastname), p.updated_at=CURRENT_TIMESTAMP
WHERE p.parent_id=0;
##########
UPDATE `hb_language_locales` SET `section`='global' where `keyword` in ('changemypass', 'changemainpass');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'profiles', 'user_invite','Invite User' FROM hb_language WHERE target='user'
UNION SELECT id, 'profiles', 'user_invite_name_dscr','Name used in invite emails' FROM hb_language WHERE target='user'
UNION SELECT id, 'profiles', 'user_invite_info','Sent new invite' FROM hb_language WHERE target='user'
UNION SELECT id, 'profiles', 'user_access_update_info','Updated user privileges' FROM hb_language WHERE target='user'
UNION SELECT id, 'profiles', 'user_privileges','User Privileges' FROM hb_language WHERE target='user'
UNION SELECT id, 'profiles', 'user_access_removed','User access removed' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'user_invite_accepted','Accepted invite' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'user_invite_not_found','Invite not found' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'user_invite_not_valid','Invite not valid' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'user_invite_text','User <strong>%s</strong> invites you to his account.' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'logged_as','Logged as' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'switch_user','Switch customer account' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'client_number','Customer number' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'switch_user_select','Select a customer account' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'user_already_added', 'User already added' FROM hb_language
UNION SELECT id, 'global', 'Rejected', 'Rejected' FROM hb_language
UNION SELECT id, 'global', 'AccessList', 'Access List' FROM hb_language
UNION SELECT id, 'global', 'guest', 'guest' FROM hb_language
UNION SELECT id, 'global', 'accountid', 'Account ID' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'User', 'User' FROM hb_language  WHERE target='user';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`)
VALUES ('Details:Invite', 'General', 'Client', 1, 'Invitation from {$parent|@client}', '<h1>Dear {$invite.name},</h1>\r\n\r\n<p>{$parent|@client} invites you to his account.</p>\r\n\r\n<table class="body-action" align="center" width="100%" cellpadding="0" cellspacing="0">\r\n  <tr>\r\n    <td align="center">\r\n      <div>\r\n        <!--[if mso]>\r\n        <v:roundrect xmlns:v="urn:schemas-microsoft-com:vml" xmlns:w="urn:schemas-microsoft-com:office:word" \r\n            href="{$invite.url}" style="height:45px;v-text-anchor:middle;width:200px;" arcsize="7%" stroke="f" fill="t">\r\n        <v:fill type="tile" color="#22BC66" />\r\n        <w:anchorlock/>\r\n        <center style="color:#ffffff;font-family:sans-serif;font-size:15px;">Review in Client Area</center>\r\n        </v:roundrect>\r\n        <![endif]-->\r\n        <a href="{$invite.url}" class="button button--green">Review in Client Area</a>\r\n      </div>\r\n    </td>\r\n  </tr>\r\n</table>\r\n\r\n<table class="body-sub">\r\n  <tbody><tr>\r\n    <td>\r\n      <p class="sub">If you’re having trouble clicking the Review button, copy and paste the URL below into your web browser.\r\n      </p>\r\n      <p class="sub"><a href="{$invite.url}">{$invite.url}</a></p>\r\n    </td>\r\n  </tr>\r\n</tbody>\r\n</table>\r\n       \r\n ', 'Dear {$invite.name},\r\n\r\n{$parent|@client} invites you to his account.\r\n\r\nNavigate to this URL to review the request\r\n{$invite.url}\r\n ', 1, 2, 1, 0, 0, 1),
       ('Ticket:BounceAmbiguous', 'Support', 'Client', 1, 'Your Ticket was not opened', '<h1>{$email_name},</h1>\r\n<br/>\r\nYour message to our support system could not be accepted as a ticket because your email address is linked to multiple client profiles. <br />\r\nTo open a ticket please login to our client area and submit your message through our support form at <a href="{$system_url}tickets/">{$system_url}tickets/</a>.', '{$email_name},\r\n\r\nYour message to our support system could not be accepted as a ticket because your email address is linked to multiple client profiles. \r\nTo open a ticket please login to our client area and submit your message through the support form at {$system_url}tickets/.', 1, 2, 1, 0, 0, 1);


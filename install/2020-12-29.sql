REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('LockTicketReply', 'off');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'removeTicketReplyLock', 'Remove ticket reply lock' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'replyToTicketsWithReplyLock', 'Reply to tickets with reply lock' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'storedreplyat', ' have stored draft reply for this ticket at ' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'remove_lock', 'Remove lock' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'reply_without_removing_lock', 'Reply without removing lock' FROM hb_language WHERE target='admin'
UNION SELECT id, 'tickets', 'reply_locked', 'Reply is locked' FROM hb_language WHERE target='admin';
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`) VALUES
('removeTicketReplyLock', 'Remove ticket reply lock', NOW(), 1, 0, '', '', 'Run', '1200');
##########
UPDATE hb_admin_access set `access` = CONCAT(`access`,',removeTicketReplyLock,replyToTicketsWithReplyLock') WHERE `access` LIKE '%editTicket%';
##########
UPDATE hb_admin_teams set `access` = CONCAT(`access`,',removeTicketReplyLock,replyToTicketsWithReplyLock') WHERE `access` LIKE '%editTicket%';
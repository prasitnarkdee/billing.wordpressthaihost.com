REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'root', 'recentdomainsfailed','Recent Domain failed actions' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'root', 'recentunsentemails','Recent emails failed to send' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'root', 'recenterrors','Recent error log entries' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'root', 'queuefails','Recent failed queue tasks' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'mergeTickets','Merge support tickets' FROM hb_language  WHERE target='admin';
##########
UPDATE hb_admin_access SET `access` = CONCAT(access, ',mergeTickets') WHERE `access` LIKE '%editTicket%';
##########
UPDATE `hb_admin_teams` SET `access` = CONCAT(access, ',mergeTickets') WHERE `access` LIKE '%editTicket%';
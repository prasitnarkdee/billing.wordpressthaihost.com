REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('CNoteNumeration', 'default');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'enabled_bulk_option', 'The bulk option has been enabled in the Domain Settings' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'bulkDomainsNotification', 'Send Bulk Domains Notifications' FROM hb_language WHERE target='admin';
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`) VALUES
('Domain:Registered:Bulk', 'Domain', 'Client', 1, 'Domains have been registered', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\n{$domains_count} domain(s) has been registered:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}<br>\r\n{/foreach}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\n{$domains_count} domain(s) has been registered:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}\r\n\{/foreach}', 1, 2, 1, 0),
('Domain:Transferred:Bulk', 'Domain', 'Client', 1, 'Domains for which the transfer was initiated', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\nTransfer has been initiated for {$domains_count} domain(s):\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}<br>\r\n{/foreach}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\nTransfer has been initiated for {$domains_count} domain(s):\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}\r\n\{/foreach}', 1, 2, 1, 0),
('Domain:Renewed:Bulk', 'Domain', 'Client', 1, 'Domains have been renewed', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\n{$domains_count} domain(s) has been renewed:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - renewal period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}<br>\r\n{/foreach}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\n{$domains_count} domain(s) has been renewed:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - renewal period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}\r\n\{/foreach}', 1, 2, 1, 0);
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`) VALUES
('bulkDomainsNotification', 'Send Bulk Domains Notifications', NOW(), 1, 0, '', '', 'Hour', '1200');
##########
CREATE TABLE IF NOT EXISTS `hb_bulk_domains` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `type` ENUM( 'Registration', 'Transfer', 'Renewal') NOT NULL ,
  `domain_id` INT(11) NOT NULL,
  `client_id` INT(11) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
##########
UPDATE hb_configuration
SET `value`='{if $cycle_rate_name != $cycle_name}{$cycle_name} / {$cycle_rate} {$cycle_rate_name}{else}{$price_line}{/if}'
WHERE `setting` = 'BillingCycleFormat' AND `value`='{$cyclename} / {$cycle_rate} {$cycle_rate_name}';
ALTER TABLE `hb_servers` CHANGE `password` `password` TEXT NOT NULL;
##########
ALTER TABLE `hb_products` ADD COLUMN `contract_id` INT(11) NULL DEFAULT 0 AFTER `code`;
##########
ALTER TABLE `hb_orders` ADD COLUMN `contract_accepted_date` datetime DEFAULT NULL AFTER `metadata`;
##########
ALTER TABLE `hb_orders` ADD COLUMN `contract_accepted_by` int(11) DEFAULT NULL AFTER `contract_accepted_date`;
##########
ALTER TABLE `hb_order_scenarios_steps` ADD COLUMN `sort` INT(2) NOT NULL AFTER `enabled`;
##########
REPLACE INTO `hb_order_scenarios_steps` (`scenario_id`,`name`,`auto`,`enabled`, `sort`)
SELECT id, 'AcceptContract', '1', '1', '2' FROM hb_order_scenarios;
##########
UPDATE `hb_order_scenarios_steps` SET `sort`='1' WHERE `name`='FraudCheck';
##########
UPDATE `hb_order_scenarios_steps` SET `sort`='2' WHERE `name`='AcceptContract';
##########
UPDATE `hb_order_scenarios_steps` SET `sort`='3' WHERE `name`='SendInvoice';
##########
UPDATE `hb_order_scenarios_steps` SET `sort`='4' WHERE `name`='Authorize';
##########
UPDATE `hb_order_scenarios_steps` SET `sort`='5' WHERE `name`='Capture';
##########
UPDATE `hb_order_scenarios_steps` SET `sort`='6' WHERE `name`='Provision';
##########
UPDATE `hb_order_scenarios_steps` SET `sort`='7' WHERE `name`='FinalReview';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'orders', 'AcceptContract', 'Accept Contract' FROM hb_language
UNION SELECT id, 'global', 'contracts', 'Contracts' FROM hb_language
UNION SELECT id, 'configuration', 'agreements_contracts', 'Agreements & Contracts' FROM hb_language
UNION SELECT id, 'configuration', 'general_agreements', 'General agreements' FROM hb_language
UNION SELECT id, 'contracts', 'contracts_desc', 'Before proceeding, you need to accept following contract(s)' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contracts_order_number', 'Order number' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contracts_order_date', 'Order date' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contracts_accepted_date', 'Contract accepted date' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contracts_accepted_by', 'Contract accepted by' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contracts_info', 'I acknowledge that I have read, and do hereby accept the terms and conditions contained in contract(s) presented above.' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contracts_accept', 'Accept' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contract_attachments', 'Attachments' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'contracts', 'contract_as_pdf', 'Download as PDF' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'profiles', 'billing_order_contracts', 'Accept order contracts' FROM hb_language
UNION SELECT id, 'clients', 'billing_order_contracts', 'Accept order contracts' FROM hb_language
UNION SELECT id, 'global', 'domain_unavaliable','Unavailable' FROM hb_language WHERE target='user'
UNION SELECT id, 'global', 'domain_added','Added' FROM hb_language WHERE target='user';
##########
CREATE TABLE IF NOT EXISTS `hb_contracts`
(
    `id`           int(11)      NOT NULL AUTO_INCREMENT,
    `name`         varchar(255) NOT NULL,
    `description` TEXT         NULL,
    `template_id`  INT(11)      NULL,
    `attachments`  TEXT         NULL,
    PRIMARY KEY (`id`),
    KEY `id` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = UTF8;
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`)
VALUES ('Order:Accept', 'General', 'Client', 1, 'New Order #{$order.number}', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Thank you for your recent order!</p>\r\n<p>To complete the order you must accept the contracts. Use the link below to accept the contracts.</p>\r\n\r\n<a href="{$accept_contract_link}" target="_blank">{$accept_contract_link}</a>\r\n\r\n<table class="invoice-wrapper" width="100%" cellpadding="0" cellspacing="0">\r\n                      <tr>\r\n                        <td><h2>Order  #{$order.number}</h2></td>\r\n                        <td></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td colspan="2">\r\n                          <table class="invoice-table" width="100%" cellpadding="0" cellspacing="0">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class="align-right">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                           {foreach from=$order_details item=item}\r\n                            <tr>\r\n                              <td width="80%">{$item.description}</td>\r\n                              <td class="align-right" width="20%">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width="80%" class="total-cell" valign="middle">\r\n                                <p class="total-cell_label">Total</p>\r\n                              </td>\r\n                              <td width="20%" class="total-cell" valign="middle">\r\n                                <p>{$order.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n       \r\n<p>\r\n    We will activate your order as soon as possible after acceptance of the contract and accounting payment (if applies) for this order.\r\n</p>             \r\n\r\n\r\n ', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\nThank you for your recent order!\r\nTo complete the order you must accept the contracts. Use the link below to accept the contract.\r\n\r\n{$accept_contract_link}\r\n\r\nORDER NUMBER: {$order.number}\r\n\r\n{foreach from=$order_details item=item}\r\n {$item.description} {$item.amount|price:$currency}\r\n{/foreach}\r\n\r\nWe will activate your order as soon as possible after acceptance of the contract and accounting payment (if applies) for this order.\r\n ', 1, 2, 1, 0, 0);
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`)
VALUES ('Invoice:Cancelled', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Cancelled', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br />\r\n<p>Your invoice #{$invoice.id} has been cancelled.</p>\r\n<br />\r\n<p><b>All invoices</b>: <a href="{$clientarea_url}">{$clientarea_url}</a></p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYour invoice #{$invoice.id} has been cancelled.\r\nAll invoices: {$clientarea_url}', 1, 2, 1, 0, 0);
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('CollectionInvoicesOnDays', 'off'),
('CollectionInvoicesOnDaysValue', '30'),
('RemoveCancelledInvoices', 'off'),
('RemoveCancelledInvoicesDelay', '30'),
('RemovePendingOrders', 'off'),
('RemovePendingOrdersDelay', '30'),
('RemoveCancelledOrders', 'off'),
('RemoveCancelledOrdersDelay', '30'),
('RemoveFraudOrders', 'off'),
('RemoveFraudOrdersDelay', '30'),
('RemoveDraftOrders', 'off'),
('RemoveDraftOrdersDelay', '30'),
('RemoveCancelledAccounts', 'off'),
('RemoveCancelledAccountsDelay', '30'),
('RemoveCancelledDomains', 'off'),
('RemoveCancelledDomainsDelay', '30'),
('RemoveExpiredDomains', 'off'),
('RemoveExpiredDomainsDelay', '30');
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`)
VALUES ('dataRetention', 'Remove data based on Data Retention settings', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1800', 1);
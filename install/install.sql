CREATE TABLE `hb_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `date_created` date NOT NULL,
  `domain` text NOT NULL,
  `server_id` int(11) NOT NULL,
  `payment_module` int(11) NOT NULL,
  `firstpayment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `billingcycle` enum('Free','One Time','Monthly','Quarterly','Semi-Annually','Annually','Biennially','Triennially','Quadrennially','Quinquennially','Daily','Weekly','Hourly') DEFAULT NULL,
  `billingtype` enum('PrePay','PostPay') NOT NULL DEFAULT 'PrePay',
  `next_due` date DEFAULT NULL,
  `due_day` tinyint(4) NOT NULL DEFAULT '0',
  `autorenew` tinyint(1) NOT NULL DEFAULT '1',
  `next_invoice` date NOT NULL,
  `status` enum('Pending','Active','Suspended','Terminated','Cancelled','Fraud') NOT NULL,
  `label` varchar(40) NOT NULL DEFAULT '',
  `username` varchar(128) NOT NULL DEFAULT '',
  `password` text NOT NULL,
  `autosuspend` tinyint(1) NOT NULL DEFAULT '0',
  `autosuspend_date` date DEFAULT NULL,
  `rootpassword` text NOT NULL,
  `date_changed` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `synch_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `synch_error` tinyint(1) NOT NULL DEFAULT '0',
  `user_error` tinyint(1) NOT NULL DEFAULT '0',
  `domain_error` tinyint(1) NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  `manual` tinyint(1) NOT NULL DEFAULT '0',
  `extra_details` text NOT NULL,
  `commitment_date` date DEFAULT '0000-00-00',
  `contract_id` int(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `server_id` (`server_id`),
  KEY `domain` (`domain`(64)),
  KEY `status` (`status`),
  KEY `username` (`username`),
  KEY `autorenew` (`autorenew`),
  KEY `status_autosuspend` (`status`,`autosuspend`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_accounts2servers` (
  `account_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `status` enum('Pending','Active','Suspended','Terminated') NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `rootpassword` text NOT NULL,
  `extra_details` text NOT NULL,
  PRIMARY KEY (`account_id`,`module_id`),
  KEY `server_id` (`server_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_accounts_addons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `addon_id` int(11) NOT NULL,
  `payment_module` int(11) NOT NULL,
  `name` text NOT NULL,
  `setup_fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `recurring_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `billingcycle` enum('Free','One Time','Monthly','Quarterly','Semi-Annually','Annually','Biennially','Triennially','Daily','Weekly','Hourly') DEFAULT NULL,
  `status` enum('Pending','Active','Suspended','Terminated','Cancelled') NOT NULL DEFAULT 'Pending',
  `regdate` date NOT NULL,
  `next_due` date DEFAULT NULL,
  `due_day` tinyint(4) NOT NULL DEFAULT '0',
  `next_invoice` date NOT NULL,
  `contract_id` int(11) UNSIGNED DEFAULT NULL,
  `extra_details` text,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `order_id` (`order_id`),
  KEY `status` (`status`),
  KEY `addon_id` (`addon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_accounts_relations` (
  `parent_type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `parent_id` int(11) NOT NULL,
  `child_type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `child_id` int(11) NOT NULL,
  PRIMARY KEY (`parent_type`,`parent_id`,`child_type`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_accounts_tags` (
  `account_id` int(11) NOT NULL,
  `target_id` varchar(200) NOT NULL DEFAULT '0',
  `tag` varchar(63) NOT NULL DEFAULT '',
  PRIMARY KEY (`account_id`,`target_id`,`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_account_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `account_id` int(11) NOT NULL,
  `admin_login` text NOT NULL,
  `module` text NOT NULL,
  `manual` tinyint(1) NOT NULL,
  `action` text NOT NULL,
  `change` text NOT NULL,
  `result` tinyint(1) NOT NULL,
  `error` text NOT NULL,
  `event` varchar(64) NOT NULL DEFAULT '',
  `ip` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `event` (`event`(12)),
  KEY `account_id` (`account_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_account_metrics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `metric_id` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `value` float DEFAULT '0',
  `success` tinyint(1) NOT NULL,
  `trigger` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `metric_id` (`metric_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_addons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `products` text NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `unique` tinyint(1) NOT NULL DEFAULT '0',
  `taxable` tinyint(1) NOT NULL,
  `tax_group_id` int(11) NOT NULL DEFAULT '1',
  `system` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `autosetup` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_addons_modules` (
  `addon_id` int(11) NOT NULL,
  `module` varchar(64) NOT NULL,
  `parentmod` varchar(64) NOT NULL,
  `options` text NOT NULL,
  `features` text NOT NULL,
  PRIMARY KEY (`addon_id`),
  KEY `module` (`module`(32)),
  KEY `parentmod` (`parentmod`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_access` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  `loginattempts` int(1) NOT NULL,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `emails` text NOT NULL,
  `access` text NOT NULL,
  `mfamodule` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `username` (`username`(32))
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_admin_access` (`id`, `username`, `password`, `loginattempts`, `status`, `emails`, `access`, `mfamodule`) VALUES
(1, 'admin', '$2a$08$qkgDjM4l017SaApqcgAM/OKLXP787WhnMxJLTcGiOgnptW0zmm5LK', 0, 'Active', 'a:15:{i:0;s:13:\"createAccount\";i:1;s:16:\"terminateAccount\";i:2;s:14:\"suspendAccount\";i:3;s:16:\"unsuspendAccount\";i:4;s:8:\"newOrder\";i:5;s:11:\"cancelOrder\";i:6;s:9:\"autoSetup\";i:7;s:11:\"cronResults\";i:8;s:11:\"failedLogin\";i:9;s:20:\"clientDetailsChanged\";i:10;s:16:\"mobileNewPayment\";i:11;s:14:\"mobileNewOrder\";i:12;s:22:\"mobileFailedAutomation\";i:13;s:18:\"editOrderOwnership\";i:14;s:22:\"editOrderOwnershipToMe\";}', 'viewInvoices,viewEstimates,viewTransactions,viewOrders,viewAccounts,listClients,viewCC,editCC,emailClient,viewTickets,viewLogs,editKBase,accessChat,loginAsClient,editConfiguration,editNews,viewDomains,editDownloads,registerClient,manageAffiliates,viewStats,deleteClients,deleteServices,deleteInvoices,deleteEstimates,deleteTransactions,deleteOrders,viewEmailLogs,editInvoices,refundInvoices,addInvoices,addTransactions,editTransactions,addOrders,editOrders,editAccounts,editClients,editClientsCredit,deleteDomains,editDomains,editOrderOwnership,editOrderTakeOwnership,affilateSettings,clientFieldsSettings,productsSettings,promotionSettings,emailTemplateSettings,languageSettings,appsSettings,departmentSettings,staffMembers,ipAccess,ipBanned,emailsBanned,loginNotifications,apiManagement,passwordSettings,editInfoPages,importAccounts,removeTicket,editTicket,editOwnMesg,manageMacros,clientBalance,editSupportRates,viewSupportRates,viewOrdersPrices,viewDomainsPrices,viewAccountsPrices,viewAccountsPasswords,manageClientGroups,accessReportsCustom,accessReportsClients,accessReportsStaff,accessReportsInvoices,accessReportsSupport,accessReportsOrders,customizeReports,billPendingItems,billPendingItems,reviewTickets,reviewOrders,editTicketMsg,viewArchivedClients,viewKBase,viewOthersOnline,accountCreate,accountSuspend,accountUnsuspend,accountRenewal,accountSynchronize,accountChangePackage,accountChangePassword,accountOrderUpgrade,accountTerminate,domainRegister,domainTransfer,domainRenew,domainSynchronize,domainOrderRenew,domainDNSmanagement,domainContactInfo,domainRegisterNameServers,domainEppCode,domainDomainForwarding,domainEmailForwarding,domainDelete,createTicketTags,createTicketTimers,editTicketTimers,viewTicketTimers,executeTicketTimers,cancelTicketTimers,removeTicketTimers,manageReportGroups,customizeReportsCustom,customizeReportsAffiliates,customizeReportsClients,customizeReportsHidden,customizeReportsInvoices,customizeReportsKnowledgebase,customizeReportsOrders,customizeReportsStaff,customizeReportsSupport,viewConfidentialEmailLogs,mergeTickets,removeTicketReplyLock,replyToTicketsWithReplyLock,accessEditorHTMLtags,createReportSnapshots,removeReportSnapshots,viewReportSnapshots,generateReportSnapshots,viewContracts,editContracts,deleteContracts,editTicketFilters,editAccountBilling,editAccountTechnical,editDomainBilling,editDomainTechnical,encryptTicketMsg,viewCCLog,editClientAutomation', 0);
##########
CREATE TABLE `hb_admin_details` (
  `id` int(10) NOT NULL,
  `firstname` text NOT NULL,
  `lastname` text NOT NULL,
  `email` text NOT NULL,
  `signature` text NOT NULL,
  `ui_config` text,
  PRIMARY KEY (`id`),
  KEY `email` (`email`(64)),
  KEY `firstname_lastname` (`firstname`(32),`lastname`(32))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_admin_details` (`id`, `firstname`, `lastname`, `email`, `signature`, `ui_config`) VALUES
(1, 'Default', 'User', 'change@me.com', '--my signature--', 'a:2:{s:18:\"clienttabs_visible\";a:11:{i:0;s:8:\"Contacts\";i:1;s:9:\"Contracts\";i:2;s:6:\"Orders\";i:3;s:8:\"Services\";i:4;s:7:\"Domains\";i:5;s:8:\"Invoices\";i:6;s:9:\"Estimates\";i:7;s:18:\"Recurring Invoices\";i:8;s:12:\"Transactions\";i:9;s:7:\"Tickets\";i:10;s:4:\"Logs\";}s:9:\"search_on\";a:11:{i:0;s:7:\"Clients\";i:1;s:8:\"Contacts\";i:2;s:6:\"Orders\";i:3;s:8:\"Accounts\";i:4;s:7:\"Domains\";i:5;s:3:\"DNS\";i:6;s:8:\"Invoices\";i:7;s:9:\"Estimates\";i:8;s:12:\"Transactions\";i:9;s:7:\"Tickets\";i:10;s:8:\"Products\";}}');
##########
CREATE TABLE `hb_admin_failed_login` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `login` varchar(255) NOT NULL,
  `ip` varbinary(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL,
  `variable` varchar(127) NOT NULL,
  `type` varchar(127) NOT NULL,
  `default` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `variable` (`variable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_fields_values` (
  `field_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`field_id`,`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_log` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) NOT NULL,
  `username` text NOT NULL,
  `login` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `logout` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ip` text NOT NULL,
  `token` text NOT NULL,
  `lastvisit` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `logout` (`logout`),
  KEY `admin` (`admin_id`),
  KEY `lastvisit` (`lastvisit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `access` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_team_assignment` (
  `admin_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL,
  UNIQUE KEY `admin_id_team_id` (`admin_id`,`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_admin_widgets` (
  `admin_id` int(11) NOT NULL,
  `widget` varchar(32) NOT NULL DEFAULT '',
  `panel` enum('left','right','bottom','top') NOT NULL DEFAULT 'left',
  `collapsed` int(1) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '1',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `autorefresh` int(11) UNSIGNED NOT NULL DEFAULT '0',
  PRIMARY KEY (`admin_id`,`widget`),
  KEY `panel` (`panel`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_admin_widgets` (`admin_id`, `widget`, `panel`, `collapsed`, `status`, `sort_order`, `autorefresh`) VALUES
(1, 'adminevents.allinpromo2', 'left', 0, 1, 0, 0),
(1, 'adminevents.mytickets', 'right', 0, 1, 0, 0),
(1, 'adminevents.noteattention', 'bottom', 0, 1, 0, 0),
(1, 'adminevents.recentaccfailures', 'right', 0, 1, 1, 0),
(1, 'adminevents.recentdomains', 'left', 0, 1, 2, 0),
(1, 'adminevents.recentorders', 'left', 0, 1, 1, 0),
(1, 'adminevents.systeminfo', 'bottom', 0, 1, 2, 0),
(1, 'domainwhois.0', 'right', 0, 1, 2, 0),
(1, 'hbextras.0', 'bottom', 0, 1, 1, 0),
(1, 'todolist.0', 'left', 0, 1, 0, 0),
(1, 'whoisonline.0', 'left', 0, 1, 3, 0);
##########
CREATE TABLE `hb_aff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `status` enum('Active','Disabled') NOT NULL DEFAULT 'Active',
  `date_created` datetime NOT NULL,
  `visits` int(11) NOT NULL,
  `total_commissions` decimal(10,2) NOT NULL,
  `total_withdrawn` decimal(10,2) NOT NULL,
  `withdraw_method` tinyint(4) NOT NULL DEFAULT '0',
  `sendreport` tinyint(4) NOT NULL DEFAULT '0',
  `commision_plans` text NOT NULL,
  `landing_url` text NOT NULL,
  `options` int(5) NOT NULL DEFAULT '0',
  `cookie_days` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `campid` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `redirect_url` varchar(255) DEFAULT NULL,
  `date_start` varchar(255) DEFAULT NULL,
  `date_end` varchar(255) DEFAULT NULL,
  `status` enum('Active','Draft','Inactive') DEFAULT NULL,
  `notes` text,
  `banners` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_clients` (
  `aff_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `by` varchar(50) NOT NULL,
  PRIMARY KEY (`aff_id`,`client_id`),
  KEY `aff_id` (`aff_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_commisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  `type` enum('Fixed','Percent') NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  `applicable_cycles` text NOT NULL,
  `applicable_products` text NOT NULL,
  `applicable_client_groups` varchar(255) NOT NULL DEFAULT 'all',
  `otrates` text,
  `recurring` tinyint(1) NOT NULL,
  `enable_voucher` tinyint(1) NOT NULL,
  `notes` text NOT NULL,
  `enable_overcommission` tinyint(1) NOT NULL DEFAULT '0',
  `autoassign` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_aff_commisions` (`id`, `name`, `type`, `rate`, `applicable_cycles`, `applicable_products`, `applicable_client_groups`, `otrates`, `recurring`, `enable_voucher`, `notes`, `enable_overcommission`, `autoassign`) VALUES
(1, 'Default', 'Percent', '10.00', 'all', '', 'all', NULL, 0, 1, 'Default commisions plan', 0, NULL);
##########
CREATE TABLE `hb_aff_coupons` (
  `aff_id` int(10) NOT NULL,
  `coupon_id` int(10) NOT NULL,
  `commision_plan` int(10) NOT NULL,
  PRIMARY KEY (`aff_id`,`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_logs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `aff_id` int(10) NOT NULL,
  `date` datetime NOT NULL,
  `type` enum('Visit','Singup') NOT NULL,
  `ref_url` varchar(255) DEFAULT NULL,
  `target` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `aff_id` (`aff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aff_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `type` enum('order','recurring','manual','sub-affiliate','unassigned') NOT NULL DEFAULT 'order',
  `commission` decimal(10,2) NOT NULL,
  `paid` tinyint(1) NOT NULL DEFAULT '0',
  `datepaid` datetime NOT NULL,
  `date_created` datetime NOT NULL,
  `description` text,
  PRIMARY KEY (`id`),
  KEY `aff_id` (`aff_id`),
  KEY `order_id` (`order_id`),
  KEY `paid` (`paid`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_orders_items` (
  `aff_order_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `plan_id` int(11) NOT NULL,
  `amount` decimal(12,2) DEFAULT NULL,
  `rateType` enum('Fixed','Percent') DEFAULT NULL,
  `rate` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`aff_order_id`,`type`,`item_id`),
  KEY `type_item_id` (`type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_type` varchar(50) NOT NULL,
  `rel_id` int(11) NOT NULL,
  `rate` decimal(12,2) NOT NULL,
  `type` enum('Fixed','Percent') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_type_ref_id` (`rel_type`,`rel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_aff_widlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `aff_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency_id` int(11) NOT NULL DEFAULT '0',
  `transaction_id` int(11) DEFAULT NULL,
  `note` text,
  `method` tinyint(4) NOT NULL DEFAULT '0',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `aff_id` (`aff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_annoucements` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` tinytext NOT NULL,
  `content` text NOT NULL,
  `enable` tinyint(1) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_api_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` varchar(20) NOT NULL,
  `api_key` text NOT NULL,
  `ip` varchar(64) NOT NULL,
  `acl` text,
  `name` varchar(128) DEFAULT 'None',
  `flags` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `api_id` (`api_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_api_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` varchar(20) NOT NULL,
  `date` datetime NOT NULL,
  `ip` varchar(45) NOT NULL,
  `action` text NOT NULL,
  `result` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_automation_settings` (
  `item_id` int(11) NOT NULL,
  `type` enum('Hosting','Addon','Domain','ClientGroup','Client') NOT NULL DEFAULT 'Hosting',
  `setting` varchar(32) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  PRIMARY KEY (`item_id`,`type`,`setting`(29))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_autoupgrade_notify` (
  `admin_id` int(11) NOT NULL,
  `seen` int(1) NOT NULL DEFAULT '0',
  `last_date` date NOT NULL DEFAULT '0000-00-00',
  PRIMARY KEY (`admin_id`),
  KEY `seen` (`seen`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_autoupgrade_notify` (`admin_id`, `seen`, `last_date`) VALUES
(1, 0, '0000-00-00');
##########
CREATE TABLE `hb_banned_emails` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `domain` varchar(128) NOT NULL,
  `reason` text NOT NULL,
  `expires` datetime NOT NULL,
  `count` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_banned_ip` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `ip` varchar(128) NOT NULL DEFAULT '',
  `reason` text NOT NULL,
  `expires` datetime NOT NULL,
  `count` int(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_bulk_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('Registration','Transfer','Renewal') NOT NULL,
  `domain_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_cancelation_reasons` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `reason` varchar(250) NOT NULL,
  `target` enum('all','service','domain') DEFAULT 'all',
  `counter` int(10) NOT NULL DEFAULT '0',
  `sort_order` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_cancel_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `reason` text NOT NULL,
  `type` enum('Immediate','End of billing period','Admin submitted','Other') NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_type` enum('Account','Domain') DEFAULT 'Account',
  `process_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `who` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `account_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `contains` enum('categories','products') NOT NULL DEFAULT 'products',
  `module` int(11) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `visible` tinyint(1) NOT NULL,
  `sort_order` int(1) NOT NULL DEFAULT '0',
  `template` text NOT NULL,
  `ctype` enum('wizard','onestep','quote','domain') NOT NULL DEFAULT 'wizard',
  `ptype` tinyint(2) NOT NULL,
  `slug` varchar(255) NOT NULL DEFAULT '',
  `opconfig` text NOT NULL,
  `scenario_id` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `visible` (`visible`),
  KEY `slug` (`slug`(32)),
  KEY `module` (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_canned_cat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_canned_fav` (
  `admin_id` int(11) NOT NULL,
  `response_id` int(11) NOT NULL,
  PRIMARY KEY (`admin_id`,`response_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_canned_resp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `title` varchar(127) NOT NULL,
  `body` text NOT NULL,
  `used` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_dept` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL,
  `description` text NOT NULL,
  `ticket_dept_id` int(11) NOT NULL DEFAULT '0',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `options` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ticket_dept` (`ticket_dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_discussions2` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `visitor_id` int(11) NOT NULL,
  `footprint_id` int(11) NOT NULL,
  `staff_id_1` int(11) NOT NULL,
  `staff_id_2` int(11) NOT NULL DEFAULT '0',
  `staff_rejects` varchar(127) NOT NULL DEFAULT '',
  `type` enum('CA','AC') NOT NULL DEFAULT 'CA',
  `status` enum('Invite','Invite Recv','Invite Decline','Active','Pending','Transfer','Timeout','Closed') NOT NULL DEFAULT 'Pending',
  `date_start` datetime NOT NULL,
  `date_answered` datetime NOT NULL,
  `date_last` datetime NOT NULL,
  `visitor_name` varchar(127) NOT NULL,
  `visitor_email` varchar(127) NOT NULL,
  `subject` text NOT NULL,
  `robin_count` int(11) NOT NULL DEFAULT '0',
  `staff_type` tinyint(4) NOT NULL DEFAULT '0',
  `visitor_type` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `visitor_id` (`visitor_id`),
  KEY `department_id` (`department_id`),
  KEY `staff_id_1` (`staff_id_1`),
  KEY `status` (`status`),
  KEY `footprint_id` (`footprint_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_footprints` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `visitor_id` int(11) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  `datecreated` datetime NOT NULL,
  `date` datetime NOT NULL,
  `page` text NOT NULL,
  `ref` text NOT NULL,
  `searchterm` text NOT NULL,
  `page_title` text NOT NULL,
  `hash` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `visitor_id` (`visitor_id`),
  KEY `hash` (`hash`),
  KEY `session_id` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('invitation','status') NOT NULL DEFAULT 'status',
  `name` varchar(127) NOT NULL DEFAULT '',
  `filename_off` varchar(255) NOT NULL DEFAULT '',
  `filename_on` varchar(255) NOT NULL DEFAULT '',
  `location` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_messages2` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `chat_id` int(11) NOT NULL,
  `staff_read` tinyint(1) NOT NULL DEFAULT '0',
  `visitor_read` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('Staff','Client','Status','System') NOT NULL DEFAULT 'Status',
  `date` datetime NOT NULL,
  `message` text NOT NULL,
  `submitter_id` int(11) NOT NULL DEFAULT '0',
  `submitter_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_id` (`chat_id`),
  KEY `submitter_id` (`submitter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_staff2` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` enum('Active','Away','Offline') NOT NULL DEFAULT 'Offline',
  `lastseen` datetime NOT NULL,
  `canned_welcome_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`admin_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_staff2dept` (
  `admin_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  PRIMARY KEY (`admin_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_visitor` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL DEFAULT '0',
  `session` varchar(32) NOT NULL DEFAULT '0',
  `last_visit` datetime NOT NULL,
  `first_visit` datetime NOT NULL,
  `ban_util` date NOT NULL DEFAULT '0000-00-00',
  `ip` varchar(45) NOT NULL,
  `hostname` varchar(127) NOT NULL,
  `name` varchar(127) NOT NULL,
  `email` varchar(127) NOT NULL,
  `os` varchar(45) NOT NULL,
  `browser` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `ip` (`ip`),
  KEY `session` (`session`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_chat_visitor_geodata` (
  `visitor_id` int(11) NOT NULL,
  `locId` int(11) NOT NULL,
  `country` varchar(5) NOT NULL,
  `region` varchar(100) NOT NULL,
  `city` varchar(255) NOT NULL,
  `postalCode` varchar(100) NOT NULL,
  `latitude` varchar(100) NOT NULL,
  `longitude` varchar(100) NOT NULL,
  PRIMARY KEY (`visitor_id`),
  KEY `locId` (`locId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_clientarea_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `filter` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_access` (
  `id` int(10) NOT NULL,
  `group_id` int(10) NOT NULL DEFAULT '0',
  `email` text NOT NULL,
  `password` varchar(255) NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `ip` text NOT NULL,
  `host` text NOT NULL,
  `status` enum('Active','Closed','Closing','PendingRemoval','Archived') NOT NULL DEFAULT 'Active',
  `loginattempts` tinyint(1) DEFAULT '0',
  `mfamodule` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `email` (`email`(64)),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_ach` (
  `client_id` int(11) NOT NULL,
  `type` enum('checkings','savings','business_checking') NOT NULL,
  `account` blob NOT NULL,
  `routing` blob NOT NULL,
  `token` blob NOT NULL,
  `token_gateway_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_activity_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `description` text NOT NULL,
  `client_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '0',
  `admin_name` varchar(50) NOT NULL DEFAULT '',
  `event` varchar(100) NOT NULL DEFAULT '',
  `ip` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `credit` decimal(10,2) NOT NULL,
  `taxexempt` tinyint(1) NOT NULL,
  `latefeeoveride` tinyint(1) NOT NULL,
  `overideduenotices` tinyint(1) NOT NULL,
  `overideautosusp` tinyint(1) NOT NULL,
  `cardtype` enum('Visa','MasterCard','Discover','American Express','Laser','Maestro') NOT NULL,
  `cardnum` blob NOT NULL,
  `expdate` blob NOT NULL,
  `currency_id` int(11) NOT NULL DEFAULT '0',
  `token` blob NOT NULL,
  `token_gateway_id` int(11) NOT NULL DEFAULT '0',
  `taxrateoverride` tinyint(1) NOT NULL DEFAULT '0',
  `taxrate` decimal(10,2) NOT NULL DEFAULT '0.00',
  `disableemails` tinyint(1) NOT NULL DEFAULT '0',
  `billing_contact_id` int(11) UNSIGNED DEFAULT '0',
  `cardcreated` datetime DEFAULT NULL,
  `cardupdated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `currency_id` (`currency_id`),
  KEY `overideautosusp` (`overideautosusp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_changes_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `who` varchar(127) NOT NULL DEFAULT '',
  `change` text NOT NULL,
  `date` datetime NOT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_contracts` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `number` varchar(32) NOT NULL,
  `client_id` int(11) UNSIGNED NOT NULL,
  `template_id` int(11) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepted_at` datetime DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `accepted_by` varchar(255) DEFAULT NULL,
  `status` enum('Draft','Pending','Active','Expired','Canceled') NOT NULL DEFAULT 'Draft',
  `flags` int(11) UNSIGNED DEFAULT '0',
  `public_notes` text,
  `metadata` text,
  `external_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `number` (`number`),
  KEY `client_id` (`client_id`),
  KEY `template_id` (`template_id`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_credit_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `client_id` int(11) NOT NULL,
  `in` decimal(10,2) NOT NULL DEFAULT '0.00',
  `out` decimal(10,2) NOT NULL DEFAULT '0.00',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00',
  `description` varchar(255) NOT NULL,
  `transaction_id` varchar(32) NOT NULL DEFAULT '',
  `invoice_id` int(11) NOT NULL DEFAULT '0',
  `admin_id` int(11) NOT NULL DEFAULT '0',
  `admin_name` varchar(70) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_details` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `firstname` text NOT NULL,
  `lastname` text NOT NULL,
  `companyname` text NOT NULL,
  `address1` text NOT NULL,
  `address2` text NOT NULL,
  `city` text NOT NULL,
  `state` text NOT NULL,
  `postcode` text NOT NULL,
  `country` text NOT NULL,
  `phonenumber` text NOT NULL,
  `datecreated` date NOT NULL,
  `notes` text NOT NULL,
  `language` text NOT NULL,
  `company` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `firstname_lastname` (`firstname`(32),`lastname`(32)),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_details_requests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `name` varchar(100) NOT NULL,
  `purpose` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(32) NOT NULL,
  `name` varchar(42) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `field_type` enum('Select','Check','Input','Password','File','Contact','Encrypted','Phonenumber') DEFAULT 'Input',
  `default_value` text NOT NULL,
  `type` enum('Company','Private','All') NOT NULL DEFAULT 'Private',
  `options` int(5) NOT NULL,
  `placeholder` varchar(150) DEFAULT NULL,
  `description` text NOT NULL,
  `sort_order` int(11) NOT NULL,
  `expression` text,
  `country` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `options` (`options`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_client_fields` (`id`, `code`, `name`, `group_id`, `field_type`, `default_value`, `type`, `options`, `placeholder`, `description`, `sort_order`, `expression`, `country`) VALUES
(1, 'firstname', 'First Name', 0, 'Input', '', 'All', 15, NULL, '', 1, NULL, NULL),
(2, 'lastname', 'Last Name', 0, 'Input', '', 'All', 15, NULL, '', 2, NULL, NULL),
(3, 'companyname', 'Organization', 0, 'Input', '', 'Company', 15, NULL, '', 3, NULL, NULL),
(4, 'address1', 'Address 1', 0, 'Input', '', 'All', 15, NULL, '', 4, NULL, NULL),
(5, 'address2', 'Address 2', 0, 'Input', '', 'All', 13, NULL, '', 5, NULL, NULL),
(6, 'city', 'City', 0, 'Input', '', 'All', 15, NULL, '', 6, NULL, NULL),
(7, 'state', 'State', 0, 'Input', '', 'All', 15, NULL, '', 7, NULL, NULL),
(8, 'postcode', 'Post code', 0, 'Input', '', 'All', 15, NULL, '', 8, NULL, NULL),
(9, 'country', 'Country', 0, 'Input', '', 'All', 15, NULL, '', 9, NULL, NULL),
(10, 'phonenumber', 'Phone', 0, 'Input', '', 'All', 15, NULL, '', 10, NULL, NULL),
(11, 'type', 'Account Type', 0, 'Select', '', 'All', 15, NULL, '', 11, NULL, NULL),
(12, 'email', 'Email Address', 0, 'Input', '', 'All', 331, NULL, '', 0, NULL, NULL),
(13, 'password', 'Password', 0, 'Password', '', 'All', 331, NULL, '', 0, NULL, NULL),
(14, 'password2', 'Repeat Password', 0, 'Password', '', 'All', 27, NULL, '', 0, NULL, NULL),
(15, 'language', '_none', 0, 'Input', '', 'All', 47, NULL, '', 0, NULL, NULL),
(16, 'notes', '_none', 0, 'Input', '', 'All', 47, NULL, '', 0, NULL, NULL),
(17, 'datecreated', '_none', 0, 'Input', '', 'All', 47, NULL, '', 0, NULL, NULL),
(18, 'comapny', '_none', 0, 'Input', '', 'All', 47, NULL, '', 0, NULL, NULL),
(19, 'captcha', 'Image Verification', 0, 'Input', '', 'All', 147, NULL, '', 100, NULL, NULL);
##########
CREATE TABLE `hb_client_fields_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_fields_values` (
  `client_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`client_id`,`field_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL,
  `description` text NOT NULL,
  `color` varchar(7) NOT NULL DEFAULT '#000000',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `scenario_id` int(10) NOT NULL DEFAULT '0',
  `default_priority` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_group_discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_id` int(11) NOT NULL,
  `rel_type` enum('ClientGroup','Client') NOT NULL,
  `item_id` int(11) NOT NULL,
  `item_type` enum('Product','Category') NOT NULL,
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `type` enum('fixed','percent') NOT NULL DEFAULT 'fixed',
  `domain_type` varchar(200) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `rel_id_rel_type` (`rel_id`,`rel_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_login_status` (
  `client_id` int(11) NOT NULL,
  `session_id` varchar(32) NOT NULL,
  `token` varchar(40) NOT NULL,
  `lastseen` datetime NOT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`client_id`,`session_id`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_client_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(32) DEFAULT NULL,
  `type` varchar(32) NOT NULL DEFAULT 'select',
  `title` text NOT NULL,
  `description` text,
  `meta` text NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_client_option` (`id`, `key`, `type`, `title`, `description`, `meta`, `sort`) VALUES
(1, 'TaxExempt', 'select', '{$lang.taxexempt}', NULL, '{\"tags\":[\"billing\",\"tax\",\"client_tax\"],\"default\":true}', 1),
(2, 'TaxOverrideRate', 'number', '{$lang.taxrateoverride}', 'Percent value [%] for L1 tax rate.', '{\"tags\":[\"billing\",\"tax\",\"client_tax\"]}', 1),
(3, 'EmailSwitch', 'select', '{$lang.sendeme}', NULL, '{\"tags\":[\"notification\",\"email\"]}', 1),
(4, 'CCChargeAuto', 'tpl', '{$lang.CCChargeAuto}', NULL, '{\"tags\":[\"billing\",\"payment\",\"creditcard\"],\"related\":[\"CCDaysBeforeCharge\",\"CCRetryForDays\",\"CCAttemptOnce\"]}', 1),
(5, 'CreditOnDowngradeOverride', 'select', 'Credit on Downgrade', NULL, '{\"tags\":[\"billing\",\"credit\"]}', 1),
(6, 'CreditAutoApply', 'select', '{$lang.autoapplycredit}', NULL, '{\"tags\":[\"billing\",\"credit\"],\"allow_client_edit\":true}', 1),
(7, 'CreditDelayAutoApply', 'number', 'Auto-apply Credit Delay', 'The number of days before invoice due date after which to apply credit automatically.', '{\"tags\":[\"billing\",\"credit\"]}', 1),
(8, 'AllowControlInvoiceDelivery', 'select', '{$lang.AllowControlInvoiceDelivery}', NULL, '{\"tags\":[\"billing\",\"invoice\"]}', 1),
(9, 'AttachPDFInvoicePaid', 'select', '{$lang.InvoiceDeliveryMethod}', NULL, '{\"tags\":[\"billing\",\"invoice\"],\"allow_client_edit\":true}', 1),
(10, 'AttachPDFInvoice', 'select', '{$lang.InvoiceDeliveryMethod}', NULL, '{\"tags\":[\"billing\",\"invoice\"]}', 1),
(11, 'AddToPrintQueue', 'select', '{$lang.AddToPrintQueue}', NULL, '{\"tags\":[\"billing\",\"invoice\"]}', 1),
(12, 'ContinueInvoices', 'radio', '{$lang.ContinueInvoices}', NULL, '{\"tags\":[\"billing\",\"invoice\"]}', 1),
(13, 'RenewInvoice', 'tpl', '{$lang.InvoiceGeneration}', NULL, '{\"tags\":[\"automation\",\"invoice\"],\"related\":[\"InvoiceGeneration\",\"InvoiceGenerationDay\"]}', 1),
(14, 'AdvancedDueDate', 'tpl', 'Advanced due date settings', NULL, '{\"tags\":[\"automation\",\"invoice\"],\"related\":[\"InvoiceExpectDays\",\"InitialDueDays\",\"MoveDueDays\"]}', 1),
(15, 'GenerateSeparateInvoices', 'radio', '{$lang.MergeInvoices}', NULL, '{\"tags\":[\"billing\",\"invoice\"],\"allow_client_edit\":true}', 1),
(16, 'MergeDomainRenewals', 'tpl', '{$lang.MergeInvoiceOptions}', NULL, '{\"tags\":[\"billing\",\"invoice\"],\"related\":[\"MergeMonthlyServiceRenewals\",\"MergeAnnualServiceRenewals\"]}', 1),
(17, 'FinalInvoiceOnPayment', 'radio', '{$lang.FinalInvoiceOnPayment}', NULL, '{\"tags\":[\"billing\",\"invoice\"]}', 20),
(18, 'CollectionInvoicesOnDays', 'tpl', 'Auto-Collections', NULL, '{\"tags\":[\"billing\",\"invoice\"],\"related\":[\"CollectionInvoicesOnDaysValue\"]}', 1),
(19, 'InvoiceTemplate', 'tpl', '{$lang.InvoiceTemplate}', NULL, '{\"tags\":[\"billing\",\"template\"]}', 1),
(20, 'EstimateTemplate', 'tpl', '{$lang.EstimateTemplate}', NULL, '{\"tags\":[\"billing\",\"template\"]}', 1),
(21, 'CNoteTemplate', 'tpl', '{$lang.CreditNoteTemplate}', NULL, '{\"tags\":[\"billing\",\"template\"]}', 1),
(22, 'ReceiptTemplate', 'tpl', '{$lang.CreditReceiptTemplate}', NULL, '{\"tags\":[\"billing\",\"template\"]}', 1),
(23, 'EnableAutoCreation', 'select', '{$lang.auto_create}', NULL, '{\"tags\":[\"automation\",\"hosting\"]}', 1),
(24, 'EnableAutoUpgrades', 'select', 'Automatic Upgrades', NULL, '{\"tags\":[\"automation\",\"hosting\"]}', 1),
(25, 'EnableAutoRenewService', 'select', 'Automatic Renew', NULL, '{\"tags\":[\"automation\",\"hosting\"]}', 1),
(26, 'EnableAutoSuspension', 'tpl', 'Account suspension', NULL, '{\"tags\":[\"automation\",\"hosting\"],\"related\":[\"AutoSuspensionPeriod\"]}', 1),
(27, 'EnableAutoTermination', 'tpl', '{$lang.new_EnableAutoTermination}', NULL, '{\"tags\":[\"automation\",\"hosting\"],\"related\":[\"AutoTerminationPeriod\"]}', 1),
(28, 'EnableAutoRegisterDomain', 'tpl', 'Auto-Register domains', NULL, '{\"tags\":[\"automation\",\"domain\"],\"related\":[\"AutoRegisterDomainType\"]}', 1),
(29, 'EnableAutoTransferDomain', 'tpl', 'Auto-Transfer domains', NULL, '{\"tags\":[\"automation\",\"domain\"],\"related\":[\"AutoTransferDomainType\"]}', 1),
(30, 'EnableAutoRenewDomain', 'tpl', 'Auto-Renew domains', NULL, '{\"tags\":[\"automation\",\"domain\"],\"related\":[\"RenewOnOrder\"]}', 1),
(31, 'SendPaymentReminderEmails', 'tpl', '{$lang.new_SendPaymentReminderEmails}', NULL, '{\"tags\":[\"automation\",\"overdue\"],\"related\":[\"InvoiceUnpaidReminder\",\"1OverdueReminder\",\"2OverdueReminder\",\"3OverdueReminder\"]}', 1),
(32, 'LateFeeType', 'tpl', '{$lang.latefees}', NULL, '{\"tags\":[\"automation\",\"overdue\",\"latefee\"],\"related\":[\"LateFeeValue\"]}', 1),
(33, 'AddLateFeeAfter', 'text', 'Late Fee Days', '{$lang.LateFeeType2x}', '{\"tags\":[\"automation\",\"overdue\",\"latefee\"]}', 1),
(34, 'OrderScenario', 'select', 'Order scenario', 'You can choose whether customer falls under default scenario, or are processed with custom one.', '{\"tags\":[\"orders\"]}', 1),
(35, 'EnableProRata', 'tpl', 'Pro-rata billing', 'With this option enabled client will have all new services billed on certain day of month.', '{\"tags\":[\"orders\",\"prorata\"],\"related\":[\"ProRataDay\",\"ProRataMonth\",\"ProRataNextMonth\"]}', 1),
(36, 'UpgradeProratePrecision', 'select', 'Upgrade pro-rata', NULL, '{\"tags\":[\"orders\",\"prorata\",\"upgrades\"]}', 1),
(37, 'ContractGeneration', 'select', 'Contract Generation', NULL, '{\"tags\":[\"orders\",\"contracts\"]}', 1),
(38, 'DiscountGlobal', 'tpl', 'Global Discount', NULL, '{\"tags\":[\"discount\"],\"default\":true}', 1),
(39, 'DiscountForms', 'tpl', 'Form component discount', NULL, '{\"tags\":[\"discount\"],\"default\":true}', 1),
(40, 'SupportDepartments', 'checkbox', 'Explicit ticket departments access', 'Departments with explicit access to which client has access', '{\"tags\":[\"support\"],\"default\":true}', 1),
(41, 'SupportPriority', 'select', 'Ticket priority', NULL, '{\"tags\":[\"support\"]}', 1),
(42, 'DefaultTicketRate', 'select', 'Default Ticket Rate', NULL, '{\"tags\":[\"support\",\"supportrates\"]}', 1),
(43, 'RecordsPerPage', 'select', '{$lang.RecordsPerPage}', NULL, '{\"tags\":[\"general\"],\"allow_client_edit\":true,\"allow_admin_edit\":false}', 100),
(44, 'DefaultTimezone', 'select', '{$lang.timezone}', NULL, '{\"tags\":[\"automation\",\"general\"],\"allow_client_edit\":true}', 100),
(45, 'DefaultPaymentModule', 'select', '{$lang.DefaultPaymentModule}', NULL, '{\"tags\":[\"billing\",\"payment\"],\"default\":false,\"allow_client_edit\":true}', 100),
(46, 'ClientNotifications', 'checkbox', '{$lang.notify_setting}', NULL, '{\"tags\":[\"notification\"],\"allow_client_edit\":true,\"allow_admin_edit\":false}', 1),
(47, 'DefaultNameservers', 'tpl', '{$lang.nameservers}', NULL, '{\"tags\":[\"order\"],\"allow_client_edit\":true,\"allow_admin_edit\":false}', 1);
##########
CREATE TABLE `hb_client_option_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `option_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text,
  `value` text,
  `meta` text NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `option_id` (`option_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_client_option_item` (`id`, `option_id`, `title`, `description`, `value`, `meta`, `sort`) VALUES
(1, 1, '{$lang.Disabled}', '', '0', '[]', 1),
(2, 1, '{$lang.Enabled}', '', '1', '[]', 1),
(3, 3, '{$lang.Yes}', '', NULL, '[]', 1),
(4, 3, '{$lang.Enabled}', '{$lang.EmailSwitchd1}', 'on', '[]', 1),
(5, 3, '{$lang.Disabled}', '{$lang.EmailSwitchd2}', 'off', '[]', 1),
(6, 5, 'Default', '', NULL, '[]', 1),
(7, 5, '{$lang.no}', 'do not credit customer pro-rated amount on package downgrade', 'off', '[]', 1),
(8, 5, '{$lang.yes}', 'credit customer pro-rated amount on package downgrade', 'on', '[]', 1),
(9, 6, '{$lang.yes}', '{$lang.autocredit_yes}', 'on', '[]', 1),
(10, 6, '{$lang.yes}', 'Apply available credit to new orders immediately, and few days before due date for recurring invoices', 'delay', '{\"enable\":[\"CreditDelayAutoApply\"],\"admin_only\":true}', 1),
(11, 6, '{$lang.no}', '{$lang.autocredit_no}', 'off', '[]', 1),
(12, 8, '{$lang.yes}', '', 'on', '[]', 1),
(13, 8, '{$lang.no}', '', 'off', '[]', 1),
(14, 9, '{$lang.InvoiceDeliveryMethod_descr1}', '', 'on', '[]', 1),
(15, 9, '{$lang.InvoiceDeliveryMethod_descr2}', '', 'off', '{\"admin_only\":true}', 1),
(16, 9, '{$lang.InvoiceDeliveryMethod_descr3}', '', 'paper', '{\"disable_email\":true,\"enable\":[\"AddToPrintQueue\"]}', 1),
(17, 9, '{$lang.InvoiceDeliveryMethod_descr4}', '', 'paperpdf', '{\"enable\":[\"AddToPrintQueue\"]}', 1),
(18, 10, '{$lang.InvoiceDeliveryMethod_descr1}', '', 'on', '[]', 1),
(19, 10, '{$lang.InvoiceDeliveryMethod_descr2}', '', 'off', '{\"admin_only\":true}', 1),
(20, 10, '{$lang.InvoiceDeliveryMethod_descr3}', '', 'paper', '{\"disable_email\":true,\"enable\":[\"AddToPrintQueue\"]}', 1),
(21, 10, '{$lang.InvoiceDeliveryMethod_descr4}', '', 'paperpdf', '{\"enable\":[\"AddToPrintQueue\"]}', 1),
(22, 11, '{$lang.ProForma}', '', 'proforma', '[]', 1),
(23, 11, '{$lang.FinalInvoice}', '', 'final', '[]', 1),
(24, 12, '{$lang.yes}', '{$lang.ContinueInvoices_descr}', 'on', '[]', 1),
(25, 12, '{$lang.no}', '{$lang.ContinueInvoices_descr1}', 'off', '[]', 1),
(26, 15, 'Default', '', NULL, '[]', 1),
(27, 15, '{$lang.yes}', '{$lang.MergeInvoicesCron}', 'off', '[]', 1),
(28, 15, '{$lang.yes}', '{$lang.MergeInvoicesDue}', 'due', '[]', 1),
(29, 15, '{$lang.no}', '{$lang.MergeInvoiceNone}', 'on', '[]', 1),
(30, 17, '{$lang.yes}', '{$lang.FinalInvoiceOnPayment_on}', 'on', '[]', 1),
(31, 17, '{$lang.no}', '{$lang.FinalInvoiceOnPayment_off}', 'off', '[]', 1),
(32, 17, 'Never', 'do not generate final invoice numbers', 'never', '[]', 1),
(33, 23, '{$lang.no}', '', '0', '[]', 1),
(34, 23, '{$lang.Yes}', '{$lang.whenmanualaccept}', '1', '[]', 3),
(35, 23, '{$lang.Yes}', '{$lang.whenpaymentreceived}', '2', '[]', 2),
(36, 23, '{$lang.Yes}', '{$lang.whenorderplaced}', '3', '[]', 1),
(37, 23, '{$lang.Yes}', '{$lang.procesbycron}', '4', '[]', 4),
(38, 24, '{$lang.no}', '', 'off', '[]', 1),
(39, 24, '{$lang.Yes}', '{$lang.whenorderplaced}', 'order', '[]', 1),
(40, 24, '{$lang.Yes}', 'After receiving payment', 'on', '[]', 1),
(41, 25, '{$lang.no}', '', 'off', '[]', 1),
(42, 25, '{$lang.Yes}', 'Renew account automatically after receiving payment', 'on', '[]', 1),
(43, 36, 'Seconds - calculate charge based on time left to due date', '', 'seconds', '[]', 1),
(44, 36, 'Hours - calculate charge based on hours left to due date', '', 'hours', '[]', 1),
(45, 36, 'Days - calculate charge based on days left to due date', '', 'days', '[]', 1),
(46, 37, '{$lang.GenerateContractForEachNewClient}', '', 'generate', '[]', 1),
(47, 37, '{$lang.AttemptToReuseDefaultContract}', '', 'default', '[]', 1),
(48, 41, 'Low', '', '0', '[]', 1),
(49, 41, 'Medium', '', '1', '[]', 1),
(50, 41, 'High', '', '2', '[]', 1),
(51, 43, '25', '', '25', '[]', 1),
(52, 43, '50', '', '50', '[]', 1),
(53, 43, '100', '', '100', '[]', 1),
(54, 43, '200', '', '200', '[]', 1),
(55, 4, '{$lang.CCChargeAutoNo}', '', 'off', '[]', 1),
(56, 4, '{$lang.CCChargeAutoYes}', '', 'on', '[]', 1);
##########
CREATE TABLE `hb_client_privileges` (
  `client_id` int(11) NOT NULL,
  `privileges` mediumtext NOT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_common` (
  `id` int(11) NOT NULL,
  `rel` enum('Product','Addon','Config','Bundled','FResource') NOT NULL,
  `paytype` varchar(20) NOT NULL DEFAULT 'Free',
  `m_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `q_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `s_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `a_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `b_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `t_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `p4_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `p5_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `d_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `w_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `h_setup` decimal(10,2) NOT NULL DEFAULT '0.00',
  `m` decimal(10,2) NOT NULL DEFAULT '0.00',
  `q` decimal(10,2) NOT NULL DEFAULT '0.00',
  `s` decimal(10,2) NOT NULL DEFAULT '0.00',
  `a` decimal(10,2) NOT NULL DEFAULT '0.00',
  `b` decimal(10,2) NOT NULL DEFAULT '0.00',
  `t` decimal(10,2) NOT NULL DEFAULT '0.00',
  `p4` decimal(10,2) NOT NULL DEFAULT '0.00',
  `p5` decimal(10,2) NOT NULL DEFAULT '0.00',
  `d` decimal(10,2) NOT NULL DEFAULT '0.00',
  `w` decimal(10,2) NOT NULL DEFAULT '0.00',
  `h` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`,`rel`),
  KEY `paytype` (`paytype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_config2accounts` (
  `rel_type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `account_id` int(11) NOT NULL,
  `config_cat` int(11) NOT NULL,
  `config_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL DEFAULT '1',
  `data` text NOT NULL,
  PRIMARY KEY (`rel_type`,`account_id`,`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_configuration` (
  `setting` varchar(128) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_configuration` (`setting`, `value`) VALUES
('1DomainReminder', '50'),
('1OverdueReminder', '1'),
('1ServiceReminder', '0'),
('2DomainReminder', '40'),
('2OverdueReminder', '2'),
('2ServiceReminder', '0'),
('3DomainReminder', '30'),
('3OverdueReminder', '3'),
('3ServiceReminder', '0'),
('4DomainReminder', '10'),
('4ServiceReminder', '0'),
('5DomainReminder', '5'),
('5ServiceReminder', '0'),
('AccessOrderpages', 'allow'),
('AccountStatementTemplate', '106'),
('ACHAllowRemove', 'off'),
('ACHAllowStorage', 'on'),
('ACHChargeAuto', 'on'),
('ACHChargeAutoDays', '7'),
('ACHReChargeAuto', 'on'),
('ACHRetryForDays', '3'),
('AddFundsDontCheckOrders', 'off'),
('AddLateFeeAfter', '6'),
('AddOverpaymentToCretid', 'on'),
('AddToPrintQueue', 'final'),
('AdjustAccountInitialPeriod', 'off'),
('AdjustDomainPeriod', 'off'),
('AdminCustomTitle', ''),
('AdminFavicon', ''),
('AdminLogoPath', 'templates/default/img/hostbill-logo.png'),
('AdminTemplate', 'default'),
('AdsjustDatesOnCreation', 'on'),
('AdvancedDueDate', 'off'),
('AffBonus', '5'),
('AffCookieDays', '60'),
('AffDefaultPlan', ''),
('AffDelay', '2'),
('AffIntegration', ''),
('AffLandingPage', 'default'),
('AffMinWid', '30'),
('AffMultiplePlans', '1'),
('AffRecItems', ''),
('AffRecurring', 'off'),
('AffType', 'Percent'),
('AffValue', '10'),
('AfterOrderRedirect', '1'),
('AllowAccountStatement', 'off'),
('AllowBulkPayment', 'on'),
('AllowClientViewCreditLog', 'on'),
('AllowControlInvoiceDelivery', 'off'),
('AllowedAttachmentExt', '.jpg;.gif;.zip'),
('AllowSeeCanceledServices', 'on'),
('AllowSignupWithoutPurchase', 'on'),
('ApplyTermsURL', ''),
('ApprovingEstimateByClient', 'generate'),
('AttachPDFCopy', 'off'),
('AttachPDFInvoice', 'off'),
('AttachPDFInvoicePaid', 'off'),
('AttachXMLInvoicePaid', 'off'),
('AutoCancelUnpaidInvoices', 'off'),
('AutoCancelUnpaidOrdersPeriod', '30'),
('AutoDeleteDomainDays', '20'),
('AutoDeleteDomainType', 'after'),
('AutologoutTime', '30'),
('AutoProcessCancellations', 'off'),
('AutoRegDomains', 'on'),
('AutoRegisterDomainType', '0'),
('AutoSuspensionPeriod', '10'),
('AutoTerminationPeriod', '30'),
('AutoTransferDomainType', '0'),
('AutoUpgradeExcludes', ''),
('BanClientIPLogin', '0'),
('BanClientIPLoginTime', '300'),
('BCCInvoiceEmails', ''),
('BCCInvoiceEmailsPaid', 'off'),
('BillFullMonth', '0'),
('BillingCycleFormat', ''),
('BlockFinalInvoiceEdits', '0'),
('BlockHostingCreation', 'off'),
('BusinessName', 'Your Business Name'),
('CanCancelUnpaidService', 'off'),
('CancelCustomInvoicesOnDays', 'off'),
('CancelCustomInvoicesOnDaysValue', '0'),
('CancelInvoicesOnDays', 'off'),
('CancelInvoicesOnDaysValue', '0'),
('CancelInvoicesOnExpire', 'off'),
('CancelInvoicesOnTerminate', 'off'),
('CancellationPostPaidProrata', 'off'),
('CancellationTypeEndPeriod', 'on'),
('CancellationTypeImmediate', 'on'),
('CanRemoveUnpaidInvoices', 'off'),
('CanSetCreditAuto', 'off'),
('CanSetMergeInvoice', 'off'),
('CanUpgradeUnpaidService', 'off'),
('CaptchaUnregTickets', 'off'),
('CCAllowRemove', 'on'),
('CCAllowStorage', 'on'),
('CCAttemptOnce', 'off'),
('CCBanDeclined', 'off'),
('CCBanDeclinedTimes', '3'),
('CCChargeAuto', 'on'),
('CCDaysBeforeCharge', '5'),
('CCForceAttempt', 'off'),
('CCRetryForDays', '4'),
('CCUpdateLimit', 'off'),
('CCUpdateLimitPariod', '1'),
('CCUpdateLimitTimes', '3'),
('ChargebackHandle', 'on'),
('ChatAllowedHosts', ''),
('ChatGeoIPEnabled', 'off'),
('ChatInvitationTimeout', '120'),
('ChatNonClients', 'off'),
('ChatPreFillGuest', 'on'),
('ChatRoundRobinEnable', 'off'),
('ChatRoundRobinInterval', '45'),
('ChatRoundRobinMiss', '2'),
('ChatTrackHostBill', 'on'),
('ClientAutocharge', 'off'),
('ClientDeleteDelay', '30'),
('ClientLogoutAfter', '30'),
('ClientNotifications', '[\"notify_login\", \"notify_billing\", \"notify_support\", \"notify_services\", \"notify_domains\"]'),
('CNoteDowngrade', 'off'),
('CNoteDowngradeAsDraft', 'off'),
('CNoteDowngradeOverride', ''),
('CnoteEnable', 'off'),
('CNoteForUnpaidAutoCloseOrder', 'off'),
('CNoteIssueForUnpaidAuto', 'off'),
('CNoteIssueForUnpaidAutoValue', '30'),
('CNoteNumeration', 'default'),
('CNoteNumerationFormat', '{$number}/{$y}'),
('CNoteNumerationPaid', '1'),
('CNoteTemplate', '102'),
('CollectionInvoicesOnDays', 'off'),
('CollectionInvoicesOnDaysValue', '30'),
('CompoundL2', 'off'),
('ContinueInvoices', 'on'),
('ContractGeneration', 'default'),
('CreditAutoApply', 'on'),
('CreditDelayAutoApply', '0'),
('CreditFailedRenewals', 'off'),
('CreditOnDowngrade', 'on'),
('CreditOnDowngradeOverride', ''),
('CSRF_Enable', ''),
('CSRF_Hash', ''),
('CSRF_Stamp', 'cfcd208495d565ef66e7dff9f98764da'),
('CurrencyCode', 'USD'),
('CurrencyFormat', '1,234.56'),
('CurrencyName', 'US Dollars'),
('CurrencySign', '$'),
('DateFormat', 'YYYY-MM-DD'),
('DaysBeforeExpirationSync', '90'),
('DecimalPlaces', '2'),
('DefaultBillingCycle', 'm'),
('DefaultContractTemplate', '0'),
('DefaultPassComplex', 'off'),
('DefaultPassLength', '8'),
('DefaultPassOptions', '1;1;1;0;8'),
('DefaultPaymentModule', '0'),
('DefaultPaymentSubject', '{$business_name} - Invoice #{$invoice_id}'),
('DefaultResultsQty', '30'),
('DefaultTimezone', 'America/Los_Angeles'),
('DiscountOnInvoice', 'on'),
('DisplayBanInfo', 'off'),
('DisplayDecimalPlaces', '2'),
('dnsmanagement', 'off'),
('DocumentEditor', 'code'),
('DocumentFilename', ''),
('DomainAllowOwn', 'on'),
('DomainAllowRegister', 'off'),
('DomainAllowSubdomain', 'on'),
('DomainAllowTransfer', 'off'),
('DomainCancellationRequest', 'off'),
('DomainClientareaLayout', 'left'),
('DomainDNSCharge', '0.00'),
('DomainEmailCharge', '0.00'),
('DomainGracePeriod', '20'),
('DomainIDCharge', '0.00'),
('DomainModulesSync', ''),
('DomainPeriodDates', 'off'),
('DomainPeriodFormat', ''),
('DomainRedemptionPeriod', '0'),
('DomainRenewalNotifications', 'single'),
('DomainStatusesSync', 'Active'),
('DomainSyncInterval', '1'),
('DomainSyncIntervalUnit', 'day'),
('DomainSyncLimit', '10'),
('DontSendSubscrInvNotify', 'on'),
('DueDateFlow', 'continue'),
('EmailHTMLWrapper', '<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n<head>\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\r\n  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n  <title>{$email_subject}</title>\r\n  <style type=\"text/css\" rel=\"stylesheet\" media=\"all\">\r\n    /* Base ------------------------------ */\r\n    *:not(br):not(tr):not(html) {\r\n      font-family: Arial, \'Helvetica Neue\', Helvetica, sans-serif;\r\n      -webkit-box-sizing: border-box;\r\n      box-sizing: border-box;\r\n    }\r\n    body {\r\n      font-family: Arial, \'Helvetica Neue\', Helvetica, sans-serif;\r\n      width: 100% !important;\r\n      height: 100%;\r\n      margin: 0;\r\n      line-height: 1.4;\r\n      background-color: #F2F4F6;\r\n      color: #74787E;\r\n      -webkit-text-size-adjust: none;\r\n    }\r\n    a {\r\n      color: #3869D4;\r\n    }\r\n\r\n    /* Layout ------------------------------ */\r\n    .email-wrapper {\r\n      width: 100%;\r\n      margin: 0;\r\n      padding: 0;\r\n      background-color: #F2F4F6;\r\n    }\r\n    .email-content {\r\n      width: 100%;\r\n      margin: 0;\r\n      padding: 0;\r\n    }\r\n\r\n    /* Masthead ----------------------- */\r\n    .email-masthead {\r\n      padding: 25px 0;\r\n      text-align: center;\r\n    }\r\n    .email-masthead_logo {\r\n      max-width: 400px;\r\n      border: 0;\r\n    }\r\n    .email-masthead_name {\r\n      font-size: 16px;\r\n      font-weight: bold;\r\n      color: #bbbfc3;\r\n      text-decoration: none;\r\n      text-shadow: 0 1px 0 white;\r\n    }\r\n\r\n    /* Body ------------------------------ */\r\n    .email-body {\r\n      width: 100%;\r\n      margin: 0;\r\n      padding: 0;\r\n      border-top: 1px solid #EDEFF2;\r\n      border-bottom: 1px solid #EDEFF2;\r\n      background-color: #FFF;\r\n    }\r\n    .email-body_inner {\r\n      width: 570px;\r\n      margin: 0 auto;\r\n      padding: 0;\r\n    }\r\n    .email-footer {\r\n      width: 570px;\r\n      margin: 0 auto;\r\n      padding: 0;\r\n      text-align: center;\r\n    }\r\n    .email-footer p {\r\n      color: #AEAEAE;\r\n    }\r\n    .body-action {\r\n      width: 100%;\r\n      margin: 30px auto;\r\n      padding: 0;\r\n      text-align: center;\r\n    }\r\n    .body-sub {\r\n      margin-top: 25px;\r\n      padding-top: 25px;\r\n      border-top: 1px solid #EDEFF2;\r\n    }\r\n    .content-cell {\r\n      padding: 35px;\r\n    }\r\n    .align-right {\r\n      text-align: right;\r\n    }\r\n\r\n    /* Type ------------------------------ */\r\n    h1 {\r\n      margin-top: 0;\r\n      color: #2F3133;\r\n      font-size: 19px;\r\n      font-weight: bold;\r\n      text-align: left;\r\n    }\r\n    h2 {\r\n      margin-top: 0;\r\n      color: #2F3133;\r\n      font-size: 16px;\r\n      font-weight: bold;\r\n      text-align: left;\r\n    }\r\n    h3 {\r\n      margin-top: 0;\r\n      color: #2F3133;\r\n      font-size: 14px;\r\n      font-weight: bold;\r\n      text-align: left;\r\n    }\r\n    p {\r\n      margin-top: 0;\r\n      color: #74787E;\r\n      font-size: 16px;\r\n      line-height: 1.5em;\r\n      text-align: left;\r\n    }\r\n    p.sub {\r\n      font-size: 12px;\r\n    }\r\n    p.center {\r\n      text-align: center;\r\n    }\r\n\r\n    /* Buttons ------------------------------ */\r\n    .button {\r\n      display: inline-block;\r\n      width: 200px;\r\n      background-color: #3869D4;\r\n      border-radius: 3px;\r\n      color: #ffffff;\r\n      font-size: 15px;\r\n      line-height: 45px;\r\n      text-align: center;\r\n      text-decoration: none;\r\n      -webkit-text-size-adjust: none;\r\n      mso-hide: all;\r\n    }\r\n    .button--green {\r\n      background-color: #22BC66;\r\n    }\r\n    .button--red {\r\n      background-color: #dc4d2f;\r\n    }\r\n    .button--blue {\r\n      background-color: #3869D4;\r\n    }\r\n\r\n    /*Media Queries ------------------------------ */\r\n    @media only screen and (max-width: 600px) {\r\n      .email-body_inner,\r\n      .email-footer {\r\n        width: 100% !important;\r\n      }\r\n    }\r\n    @media only screen and (max-width: 500px) {\r\n      .button {\r\n        width: 100% !important;\r\n      }\r\n    }\r\n  </style>\r\n</head>\r\n<body>\r\n  <table class=\"email-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n    <tr>\r\n      <td align=\"center\">\r\n        <table class=\"email-content\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <!-- Logo -->\r\n          <tr>\r\n            <td class=\"email-masthead\">\r\n              <a class=\"email-masthead_name\">{$business_name}</a>\r\n            </td>\r\n          </tr>\r\n          <!-- Email Body -->\r\n          <tr>\r\n            <td class=\"email-body\" width=\"100%\">\r\n              <table class=\"email-body_inner\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <!-- Body content -->\r\n                <tr>\r\n                  <td class=\"content-cell\">\r\n                    {$message}\r\n                  </td>\r\n                </tr>\r\n              </table>\r\n            </td>\r\n          </tr>\r\n          <tr>\r\n            <td>\r\n              <table class=\"email-footer\" align=\"center\" width=\"570\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <tr>\r\n                  <td class=\"content-cell\">\r\n                    <p class=\"sub center\">© 2016 {$business_name}. All rights reserved.</p>\r\n                    <p class=\"sub center\">\r\n                      {$business_name}\r\n                    </p>\r\n                  </td>\r\n                </tr>\r\n              </table>\r\n            </td>\r\n          </tr>\r\n        </table>\r\n      </td>\r\n    </tr>\r\n  </table>\r\n</body>\r\n</html>'),
('EmailInlineCSS', 'on'),
('EmailReplyDelimiter', ''),
('EmailSignature', ''),
('EmailsPerCronRun', '200'),
('EmailSwitch', 'on'),
('EnableAddonRelatedTermination', 'off'),
('EnableAffiliates', 'off'),
('EnableAfteractions', 'on'),
('EnableAutoCancelUnpaidOrders', 'off'),
('EnableAutoCreation', '0'),
('EnableAutoDeleteDomain', 'off'),
('EnableAutoRegisterDomain', 'on'),
('EnableAutoRenewDomain', 'on'),
('EnableAutoRenewService', 'on'),
('EnableAutoSuspension', 'off'),
('EnableAutoTermination', 'off'),
('EnableAutoTransferDomain', 'on'),
('EnableAutoUnSuspension', 'on'),
('EnableAutoUpgrades', 'on'),
('EnableChat', 'off'),
('EnableClientCaptchaLogin', 'off'),
('EnableClientScurity', 'on'),
('EnableClientScuritySSHKey', 'on'),
('EnableClientSelfDelete', 'off'),
('EnableDomainSync', 'on'),
('EnablePortalNotifications', 'on'),
('EnablePremiumDomains', 'off'),
('EnableProfiles', 'on'),
('EnableProRata', 'off'),
('EnableQueue', 'on'),
('EnableTax', 'off'),
('EstimateTemplate', '101'),
('ExtensionRule', 'allow'),
('FinalInvoiceOnPayment', 'on'),
('FinalNumberForCreditedInvoices', 'on'),
('ForceHTTPS', 'off'),
('ForceSSL', 'off'),
('ForceWraperOnPlaintext', 'off'),
('GDPRExport', '[\"contacts\",\"services\",\"domains\",\"log\",\"transactions\",\"invoices\",\"tickets\"]'),
('GenerateSeparateInvoices', 'off'),
('GenerateSeparateTax', 'off'),
('GrantDomainAccessToContacts', '1'),
('ImmediateServiceOwnerChange', 'on'),
('IncomeForecastSuspended', 'on'),
('InitialDueDays', '0'),
('InstallURL', 'http://tinst.hostbill.com/'),
('InvCompanyLogo', ''),
('InvoiceDelay', 'off'),
('InvoiceDelayDays', '0'),
('InvoiceExpectDays', '0'),
('InvoiceFooter', ''),
('InvoiceGeneration', '7'),
('InvoiceModel', 'default'),
('InvoiceNumerationFormat', '{$number}/{$m}/{$y}'),
('InvoiceNumerationFrom', '1'),
('InvoiceNumerationPaid', '1'),
('InvoicePaidAutoReset', '0'),
('InvoicePrefix', ''),
('InvoiceStoreClient', 'off'),
('InvoiceTemplate', '1'),
('InvoiceUnpaidReminder', '0'),
('ISOCurrency', 'USD'),
('KeySizeToCSR', '2048'),
('LateFeeAsSeparateInvoice', 'off'),
('LateFeeInitialOrders', 'off'),
('LateFeeType', '0'),
('LateFeeValue', '0'),
('License', ''),
('LiveChatGeoIPDBPath', 'includes/libs/geoip'),
('LockTicketReply', 'off'),
('LogAdminEmails', 'on'),
('LoggerLevel', '200'),
('MailSMTPEmail', ''),
('MailSMTPHost', 'localhost'),
('MailSMTPPassword', ''),
('MailSMTPPort', '25'),
('MailSMTPUsername', ''),
('MailUseSMTP', 'off'),
('MaintenanceMode', 'off'),
('MatchFreeDomainPeriod', 'off'),
('MaxAttachmentSize', '1'),
('MaxDeposit', '500'),
('MergeAnnualServiceRenewals', 'off'),
('MergeDomainRenewals', 'off'),
('MergeMonthlyServiceRenewals', 'off'),
('MinDeposit', '50'),
('MobileNotificationsAdmin', 'off'),
('MobileNotificationsAPriority', ''),
('MobileNotificationsClient', 'off'),
('MobileNotificationsDepts', ''),
('MobileNotificationsModAdmin', 'all'),
('MobileNotificationsModClient', 'all'),
('MoveDueDays', '0'),
('Netstat', 'off'),
('NetstatFTP', 'on'),
('NetstatHTTP', 'on'),
('NetstatIMAP', 'on'),
('NetstatLOAD', 'on'),
('NetstatMYSQL', 'on'),
('NetstatPOP3', 'on'),
('NetstatSSH', 'on'),
('NetstatUPTIME', 'on'),
('NotifyDomainContacts', '1'),
('OfferDeposit', 'on'),
('OfferDomains', 'off'),
('OfferDownloads', 'off'),
('OfferEstimates', 'off'),
('OfferKB', 'off'),
('OfferNews', 'off'),
('OfferSupport', 'off'),
('OrderAutoAccept', 'on'),
('OrderOfReplies', 'oldest'),
('OutOfStockProducts', 'hide'),
('PartialInvoicePayment', 'off'),
('PartialInvoicePaymentMinimal', '0'),
('PassDisabledChars', ''),
('PasswordRestoreMethod', 'email'),
('PayBeforeVoucher', 'off'),
('PayToText', 'HostBill Demo'),
('PDFPrefix', 'on'),
('PeriodOnEstimates', 'on'),
('PluginUpdates', ''),
('plugin_dnsdomains_hosting_own', ''),
('plugin_dnsdomains_hosting_sameorder2', '0'),
('plugin_dnsdomains_hosting_sub', ''),
('plugin_dnsdomains_match', '1'),
('plugin_dnsdomains_mismatch', 'a:1:{s:10:\"nameserver\";i:1;}'),
('plugin_dnsdomains_package', ''),
('plugin_dnsdomains_register', '2'),
('ProcessCancellationInvoice', 'on'),
('ProRataDay', '1'),
('ProRataMonth', 'disabled'),
('ProRataNextMonth', '0'),
('quickconfig', 'admin_pass|payment'),
('RecalculateCurrencyChange', 'off'),
('ReceiptEnable', 'off'),
('ReceiptNumeration', '1'),
('ReceiptNumerationAfterPayment', 'off'),
('ReceiptNumerationFormat', '{$number}/{$y}'),
('ReceiptTemplate', '103'),
('RecordsPerPage', '25'),
('RecurringAddPeriod', 'off'),
('RecurringBillingType', 'PrePaid'),
('RejectEmailsWithCC', 'on'),
('RemindersForCancelations', 'on'),
('RemoveCancelledAccounts', 'off'),
('RemoveCancelledAccountsDelay', '30'),
('RemoveCancelledDomains', 'off'),
('RemoveCancelledDomainsDelay', '30'),
('RemoveCancelledInvoices', 'off'),
('RemoveCancelledInvoicesDelay', '30'),
('RemoveCancelledOrders', 'off'),
('RemoveCancelledOrdersDelay', '30'),
('RemoveDraftOrders', 'off'),
('RemoveDraftOrdersDelay', '30'),
('RemoveEmptyClients', 'off'),
('RemoveEmptyClientsDelay', '6'),
('RemoveExpiredDomains', 'off'),
('RemoveExpiredDomainsDelay', '30'),
('RemoveFraudOrders', 'off'),
('RemoveFraudOrdersDelay', '30'),
('RemoveInactiveClients', 'off'),
('RemovePendingOrders', 'off'),
('RemovePendingOrdersDelay', '30'),
('RemoveTerminatedAccounts', 'off'),
('RemoveTerminatedAccountsDelay', '30'),
('RenewInvoice', '1'),
('RenewOnOrder', ''),
('ReplyToPublicTicket', 'reject'),
('RetainBillingMonths', '120'),
('ReturnToStockOnTerminate', '0'),
('SearchResults', '5'),
('SearchTicketReplies', 'off'),
('SendPaymentReminderEmails', 'off'),
('SEOUrlMode', 'index.php?/'),
('ServiceTerms', '[]'),
('SetupFeeSeparateLine', 'off'),
('ShopingCartMode', '1'),
('SSLPeriodYears', 'off'),
('StaffFailedDomainNotifications', 'off'),
('StorePDFInvoice', 'off'),
('StorePDFPath', ''),
('StoreXMLInvoice', 'off'),
('StoreXMLPath', ''),
('SupportedCC', 'Visa,MasterCard,Discover,American Express'),
('SyncTransferredOut', '0'),
('SystemMail', ''),
('TaxClientFunds', 'off'),
('TaxDomains', 'off'),
('TaxLateFee', 'off'),
('TaxOnDiscounts', 'off'),
('TaxRounding', 'item'),
('TaxTimetracking', 'on'),
('TaxType', 'exclusive'),
('TemplateEditor', 'code'),
('TicketAutoClose', '0'),
('TicketContactVisibility', 'on'),
('TicketHTMLTags', 'off'),
('TicketImportFromHeaders', 'reply-to,x-original-from,from'),
('TicketImportTimeLimit', '5'),
('TicketImportToHeaders', 'x-original-to,x-delivered-to,delivered-to,x-rcpt-to,rcpt-to,to'),
('TicketNotifyContacts', 'on'),
('TicketPollInterval', '15'),
('TransferOrderPeriod', 'on'),
('TranslateInvoiceLines', 'off'),
('TrustedProxies', ''),
('UpgradeProratePrecision', 'seconds'),
('UpgradesAddPeriod', 'off'),
('UserCountry', 'US'),
('UserLanguage', 'english'),
('UserTemplate', 'nextgen_clean'),
('VerifySessionIP', 'on'),
('Version', '2022-06-06'),
('VersionLastCheck', '1654783317'),
('VersionLatest', '2022-06-06'),
('VoteKnowledgebaseArticles', 'on'),
('WhichDomainSync', 'expiring'),
('WholeDigits', '10');
##########
CREATE TABLE `hb_configuration_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `admin_login` varchar(32) NOT NULL,
  `setting` varchar(128) NOT NULL,
  `from` text NOT NULL,
  `to` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `setting` (`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_config_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `variable_id` varchar(255) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `options` int(11) DEFAULT '0',
  `group_id` int(11) DEFAULT '0',
  `copy_of` int(11) DEFAULT '0',
  `description` text,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `options` (`options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_config_items_cat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL DEFAULT '1',
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `key` varchar(32) NOT NULL,
  `variable` varchar(64) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `category` varchar(64) NOT NULL DEFAULT '',
  `product_id` int(11) NOT NULL,
  `copy_of` int(11) NOT NULL DEFAULT '0',
  `options` int(11) NOT NULL DEFAULT '0',
  `config` text,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `group_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category` (`category`(16)),
  KEY `type` (`type`),
  KEY `options` (`options`),
  KEY `copy_of` (`copy_of`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_config_items_cat_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text,
  `options` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type_id` (`type_id`),
  KEY `options` (`options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_config_items_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `options` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `options` (`options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_config_items_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_config_items_types` (`id`, `type`) VALUES
(1, 'select'),
(2, 'qty'),
(3, 'checkbox'),
(4, 'input'),
(5, 'radio'),
(6, 'textarea'),
(7, 'slider'),
(8, 'idprotection');
##########
CREATE TABLE `hb_config_resources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `qty_max` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_config_upgrades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `account_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `config_cat` int(11) NOT NULL,
  `old_config_id` int(11) NOT NULL,
  `new_config_id` int(11) NOT NULL,
  `old_qty` int(11) NOT NULL,
  `new_qty` int(11) NOT NULL,
  `status` enum('Pending','Upgraded') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `config_cat` (`config_cat`),
  KEY `rel_type` (`rel_type`,`account_id`),
  KEY `new_config_id` (`new_config_id`),
  KEY `old_config_id` (`old_config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_contracts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `template_id` int(11) DEFAULT NULL,
  `attachments` text,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` int(11) NOT NULL DEFAULT '0',
  `code` varchar(32) NOT NULL,
  `status` enum('Active','Archived') NOT NULL DEFAULT 'Active',
  `coupon_type` enum('cart','invoice') DEFAULT 'cart',
  `type` enum('fixed','percent') NOT NULL,
  `applyto` enum('price','setupfee','both') NOT NULL DEFAULT 'price',
  `cycle` enum('once','recurring') NOT NULL,
  `options` int(11) NOT NULL DEFAULT '7',
  `value` decimal(10,2) NOT NULL,
  `cycles` text NOT NULL,
  `products` text NOT NULL,
  `categories` text NOT NULL,
  `upgrades` text NOT NULL,
  `addons` text NOT NULL,
  `domains` text NOT NULL,
  `forms` text NOT NULL,
  `expires` date NOT NULL,
  `max_usage` int(5) NOT NULL,
  `num_usage` int(5) NOT NULL DEFAULT '0',
  `clients` enum('all','new','existing') NOT NULL,
  `client_id` int(11) NOT NULL DEFAULT '0',
  `notes` text NOT NULL,
  `max_client_usage` int(5) NOT NULL DEFAULT '0',
  `increase_in_days` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_coupons_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT '0',
  `date` date NOT NULL,
  `discount` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `coupon_id` (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_coupon_batches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` enum('Active','Archived') NOT NULL DEFAULT 'Active',
  `prefix` varchar(32) NOT NULL,
  `coupon_type` enum('cart','invoice') DEFAULT 'cart',
  `type` enum('fixed','percent') NOT NULL,
  `value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `complexity` int(11) NOT NULL,
  `notes` text NOT NULL,
  `coupon_config` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_creditcard_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT '0',
  `admin_login` varchar(255) DEFAULT '',
  `client_id` int(11) NOT NULL,
  `ip` varchar(64) NOT NULL,
  `last4` varchar(10) NOT NULL DEFAULT '',
  `tokenized` tinyint(1) NOT NULL DEFAULT '0',
  `gateway_id` int(11) NOT NULL DEFAULT '0',
  `change` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_creditnotes` (
  `invoice_id` int(11) NOT NULL,
  `credit_note_id` int(11) NOT NULL,
  `invoice_item_id` int(11) NOT NULL DEFAULT '0',
  `credit_item_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`invoice_id`,`credit_note_id`,`invoice_item_id`),
  KEY `credit_item_id` (`credit_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
##########
CREATE TABLE `hb_creditreceipts` (
  `invoice_id` int(11) NOT NULL,
  `credit_receipt_id` int(11) NOT NULL,
  PRIMARY KEY (`invoice_id`,`credit_receipt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_creditvouchers_batches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `prefix` varchar(32) NOT NULL,
  `code_layout` int(2) NOT NULL,
  `complexity` int(2) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  `active` int(2) DEFAULT '0',
  `currency_id` int(11) DEFAULT '0',
  `value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `one_per_account` int(2) DEFAULT '0',
  `only_new_clients` int(2) DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_creditvouchers_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` int(11) NOT NULL,
  `code` varchar(32) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_cron_tasks` (
  `task` varchar(40) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `lastrun` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `count` tinyint(4) NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `output` text NOT NULL,
  `run_every` enum('Run','Time','Week','Month','Hour') NOT NULL,
  `run_every_time` varchar(5) NOT NULL,
  `profile_id` int(11) DEFAULT '1',
  PRIMARY KEY (`task`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_cron_tasks` (`task`, `name`, `lastrun`, `status`, `count`, `metadata`, `output`, `run_every`, `run_every_time`, `profile_id`) VALUES
('addDomainRedemptionFee', 'Add a redemption fee for a domain', '0000-00-00 00:00:00', 1, 0, '', '', 'Hour', '1200', 1),
('affiliateAutoPayout', 'Automatic pay-out for affiliates', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('affiliateMonthlyReport', 'Send affiliate monthly referral report', '0000-00-00 00:00:00', -1, 0, '', '', 'Month', '1', 1),
('archiveClients', 'Archive Inactive client profiles', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1800', 1),
('autoCancelOrders', 'Auto-cancel unpaid orders', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1300', 1),
('automaticDeleteDomains', 'Auto-Delete expired domains', '0000-00-00 00:00:00', -1, 0, '', '', 'Time', '1200', 1),
('automaticDomainExpire', 'Change status of expired domains', '0000-00-00 00:00:00', -1, 0, '', '', 'Time', '1200', 1),
('automaticExportReports', 'Auto-export report snapshots', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('automaticRegisterDomains', 'Auto-Register Domains', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('automaticRenewDomains', 'Auto-Renew Domains', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('automaticSynchronizePendingDomains', 'Synchronize Pending Action Domains', '0000-00-00 00:00:00', -1, 0, '', '', 'Run', '1200', 1),
('automaticTransferDomains', 'Auto-Transfer Domains', '0000-00-00 00:00:00', -1, 0, '', '', 'Run', '1200', 1),
('bulkDomainsNotification', 'Send Bulk Domains Notifications', '0000-00-00 00:00:00', 1, 0, '', '', 'Hour', '1200', 1),
('cancelExpiredContracts', 'Cancel Expired Contracts', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('cancellationRequests', 'Automatic Cancellation Requests Processing ', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('chargeACH', 'Process ACH/eChecks Charges', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1100', 1),
('chargeCC', 'Charge credit cards', '0000-00-00 00:00:00', -1, 0, '', '', 'Time', '1200', 1),
('creditAutoApply', 'Apply Credit to due invoices', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '0100', 1),
('custom:2:call_Daily', 'Module - AutoUpgrade, daily cron call', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('customModules', 'customModules', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('dataRetention', 'Remove data based on Data Retention settings', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1800', 1),
('domainNotification', 'Send Expiring Domain Notifications ', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('domainSync', 'Synchronize domain expiration dates with registrars ', '0000-00-00 00:00:00', 1, 0, '', '', 'Hour', '1', 1),
('escalateTickets', 'Escalate overdue tickets', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('executeTicketTimers', 'Execute ticket timers', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('generateInvoices', 'Generate Invoices', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('importPOP', 'Import Tickets using POP method', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('importTickets', 'Import Tickets', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('InvoiceReminder', 'Send Invoice Reminders', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('lateFeeInvoices', 'Add Late Fee to overdue invoices', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('meteredBillingCleanup', 'Cleanup old Metered Billing data', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '0100', 1),
('meteredBillingUpdate', 'Update Metered Billing Values', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('moduleAutomation', 'Perform auto provisioning tasks like suspend/terminate', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('outdateEstimates', 'Mark outdated estimates Dead', '0000-00-00 00:00:00', -1, 0, '', '', 'Time', '1200', 1),
('processAccountProvisioning', 'Auto provision paid accounts', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('productsPriceAutoUpdate', 'Products Price auto-update', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('removeClients', 'Remove Inactive / Empty client profiles', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1800', 1),
('removeTicketReplyLock', 'Remove ticket reply lock', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('sendCronResults', 'Send daily Cron-Runs results email', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('sendScheduledTickets', 'Send-Out scheduled support tickets / ticket replies', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('serviceNotification', 'Send Expiring Service Notifications', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('sslSync', 'Synchronize SSL certificates status and expiry date', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('subscriptionItemsCleanup', 'Remove unused subscription items', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('TaskScheduler', 'Automation queue scheduler', '0000-00-00 00:00:00', 1, 0, '', '', 'Hour', '1100', 1),
('TaskScheduler_Execute', 'Execute custom automation tasks', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1100', 1),
('ticketAutoClose', 'Auto-Close tickets non-answered by client', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('tldPriceAutoUpdate', 'TLD Price auto-update', '0000-00-00 00:00:00', 1, 0, '', '', 'Time', '1200', 1),
('updateAccountsMetrics', 'Update accounts metrics', '0000-00-00 00:00:00', 1, 0, '', '', 'Run', '1200', 1),
('updateConversionRates', 'Update Conversion Rates', '0000-00-00 00:00:00', -1, 0, '', '', 'Time', '1200', 1);
##########
CREATE TABLE `hb_cron_tasks_profiles` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL DEFAULT '',
  `description` text,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_cron_tasks_profiles` (`id`, `name`, `description`) VALUES
(1, 'default', 'Default cron profile for HostBill, run every 5 minutes');
##########
CREATE TABLE `hb_currencies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(4) NOT NULL,
  `sign` varchar(4) NOT NULL,
  `iso` varchar(4) NOT NULL,
  `rate` decimal(15,10) NOT NULL DEFAULT '1.0000000000',
  `last_changes` datetime NOT NULL,
  `update` tinyint(1) NOT NULL DEFAULT '1',
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `format` varchar(16) NOT NULL,
  `decimal` tinyint(4) DEFAULT NULL,
  `rounding` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_currency2country` (
  `country` varchar(2) NOT NULL,
  `currency_id` int(11) NOT NULL,
  PRIMARY KEY (`country`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
##########
CREATE TABLE `hb_currency_background_cache` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) UNSIGNED NOT NULL,
  `amount_out` decimal(10,2) NOT NULL,
  `amount_in` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `currency_in` int(11) NOT NULL DEFAULT '0',
  `currency_out` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_currency_cache` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency_id` int(11) NOT NULL,
  `base_currency_id` int(11) NOT NULL DEFAULT '0',
  `rate` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `comment` varchar(127) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`,`currency_id`,`date`),
  KEY `base_currency_id` (`base_currency_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_declined_cards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_hash` char(40) NOT NULL,
  `client_id` int(11) NOT NULL,
  `card` char(16) NOT NULL,
  `date` datetime NOT NULL,
  `reason` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `card_hash` (`card_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dnsconfig` (
  `setting` varchar(128) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`setting`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_dnsconfig` (`setting`, `value`) VALUES
('hash', ''),
('ip', ''),
('ns1', ''),
('ns1ip', ''),
('ns2', ''),
('ns2ip', ''),
('ns3', ''),
('ns3ip', ''),
('password', ''),
('ssl', '0'),
('username', '');
##########
CREATE TABLE `hb_dnsdomains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `domain` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dnslogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `action` text NOT NULL,
  `fields` text NOT NULL,
  `errors` text NOT NULL,
  `result` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dns_automation_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `products` text NOT NULL,
  `dns_package_id` int(11) NOT NULL,
  `default_ip` varchar(120) DEFAULT '',
  `dns_template_id` int(11) NOT NULL DEFAULT '0',
  `options` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dns_dnssec_ds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `key_tag` smallint(5) UNSIGNED NOT NULL,
  `algorithm` smallint(5) UNSIGNED NOT NULL,
  `digest_type` tinyint(3) UNSIGNED NOT NULL,
  `digest` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dns_dnssec_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `id_tag` int(11) NOT NULL,
  `flag` enum('KSK','ZSK') NOT NULL,
  `algorithm` smallint(5) UNSIGNED NOT NULL,
  `key_tag` smallint(5) UNSIGNED NOT NULL,
  `public_key` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dns_domains` (
  `account_id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`domain_id`,`account_id`),
  KEY `account` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dns_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` varchar(30) NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dns_templates2products` (
  `template_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`template_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_dns_templates_records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(6) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `ttl` int(11) DEFAULT NULL,
  `prio` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_domains` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `tld_id` int(11) NOT NULL,
  `name` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `server_id` int(11) NOT NULL DEFAULT '0',
  `reg_module` int(11) NOT NULL,
  `payment_module` int(11) NOT NULL,
  `date_created` date NOT NULL,
  `firstpayment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `recurring_amount` decimal(10,2) NOT NULL,
  `period` int(1) NOT NULL DEFAULT '1',
  `expires` date DEFAULT NULL,
  `type` enum('Register','Transfer','Renew') NOT NULL,
  `status` varchar(32) NOT NULL DEFAULT 'Pending',
  `next_due` date NOT NULL,
  `next_invoice` date NOT NULL,
  `idprotection` tinyint(1) NOT NULL DEFAULT '0',
  `nameservers` text NOT NULL,
  `autorenew` tinyint(1) NOT NULL,
  `reglock` tinyint(1) NOT NULL,
  `manual` tinyint(1) NOT NULL DEFAULT '0',
  `premium` tinyint(1) DEFAULT '0',
  `epp_code` text NOT NULL,
  `notes` text NOT NULL,
  `extended` text NOT NULL,
  `synch_date` datetime DEFAULT '0000-00-00 00:00:00',
  `nsips` text NOT NULL,
  `failed_syncs` int(11) NOT NULL DEFAULT '0',
  `contract_id` int(11) UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `order_id` (`order_id`),
  KEY `name` (`name`(64)),
  KEY `status` (`status`),
  KEY `tld_id` (`tld_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_domain_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain_id` int(11) NOT NULL,
  `admin_login` text NOT NULL,
  `date` datetime NOT NULL,
  `module` varchar(32) NOT NULL,
  `action` text NOT NULL,
  `result` tinyint(1) NOT NULL,
  `change` text NOT NULL,
  `error` text NOT NULL,
  `event` varchar(64) NOT NULL DEFAULT '',
  `ip` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `domain_id` (`domain_id`),
  KEY `event` (`event`(12)),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_domain_periods` (
  `product_id` int(11) NOT NULL,
  `period` tinyint(3) NOT NULL DEFAULT '1',
  `register` decimal(10,2) NOT NULL DEFAULT '0.00',
  `transfer` decimal(10,2) NOT NULL DEFAULT '0.00',
  `renew` decimal(10,2) NOT NULL DEFAULT '0.00',
  `redemption` decimal(12,2) DEFAULT '-1.00',
  `before` decimal(10,2) DEFAULT '-1.00',
  PRIMARY KEY (`product_id`,`period`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_domain_prices` (
  `product_id` int(11) NOT NULL,
  `module` int(11) NOT NULL,
  `not_renew` tinyint(1) NOT NULL,
  `epp` tinyint(4) NOT NULL DEFAULT '1',
  `options` tinyint(4) NOT NULL DEFAULT '1',
  `ns` text NOT NULL,
  `nsips` text NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_downloads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `filename` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `size` int(11) NOT NULL,
  `uploaded` date NOT NULL,
  `product_id` int(11) NOT NULL DEFAULT '0',
  `downloads` int(11) NOT NULL DEFAULT '0',
  `rel_type` tinyint(11) NOT NULL DEFAULT '0',
  `rel_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `clients` (`rel_type`),
  KEY `client_id` (`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_downloads_cats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `visible` (`visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_email_assign` (
  `id` int(11) NOT NULL,
  `rel` enum('Product','Addon','Department') NOT NULL DEFAULT 'Product',
  `event` varchar(255) NOT NULL,
  `email_id` int(11) NOT NULL,
  `options` text,
  PRIMARY KEY (`id`,`rel`,`event`),
  KEY `email_id` (`email_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_email_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `email` text NOT NULL,
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `date` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  `error` text,
  `flag` enum('email','notification') NOT NULL DEFAULT 'email',
  `metadata` text,
  `loglevel` tinyint(1) DEFAULT '1',
  `rel_type` varchar(255) DEFAULT '',
  `rel_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `flag` (`flag`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_email_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tplname` varchar(128) NOT NULL,
  `group` enum('Domain','Product','Invoice','General','Support','Custom','Mobile','Notification') DEFAULT NULL,
  `for` enum('Client','Admin') NOT NULL DEFAULT 'Client',
  `language_id` int(11) NOT NULL DEFAULT '1',
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `altmessage` text NOT NULL,
  `send` tinyint(1) DEFAULT '1',
  `plain` tinyint(1) DEFAULT '0',
  `system` tinyint(1) DEFAULT '1',
  `hidden` tinyint(1) DEFAULT '0',
  `notify` tinyint(1) DEFAULT '0',
  `loglevel` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`,`language_id`),
  KEY `tplname` (`tplname`(32)),
  KEY `group` (`group`),
  KEY `for` (`for`)
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`) VALUES
(1, 'Details:Signup', 'General', 'Client', 1, 'Client:Welcome to Portal', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Welcome to {$business_name}!.</p>\r\n\r\n<h2>Your access details:</h2>\r\n<p>\r\n    <b>Email Address:</b> {$client.email}<br/>\r\n    <b>Password:</b> {$client.password}\r\n</p>\r\n\r\n\r\n<table class=\"body-action\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td align=\"center\">\r\n                          <div>\r\n                            <!--[if mso]><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"{$system_url}?cmd=clientarea\" style=\"height:45px;v-text-anchor:middle;width:200px;\" arcsize=\"7%\" stroke=\"f\" fill=\"t\">\r\n                            <v:fill type=\"tile\" color=\"#22BC66\" />\r\n                            <w:anchorlock/>\r\n                            <center style=\"color:#ffffff;font-family:sans-serif;font-size:15px;\">Access Client Area</center>\r\n                          </v:roundrect><![endif]-->\r\n                            <a href=\"{$system_url}?cmd=clientarea\" class=\"button button--green\">Access Client Area</a>\r\n                          </div>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n                    \r\n                    <table class=\"body-sub\">\r\n                      <tbody><tr>\r\n                        <td>\r\n                          <p class=\"sub\">If you’re having trouble clicking the Access client area button, copy and paste the URL below into your web browser.\r\n                          </p>\r\n                          <p class=\"sub\"><a href=\"{$system_url}?cmd=clientarea\">{$system_url}?cmd=clientarea</a></p>\r\n                        </td>\r\n                      </tr>\r\n                    </tbody></table>\r\n       \r\n ', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\nLOGIN DETAILS:\r\nEmail Address: {$client.email}\r\nPassword: {$client.password}\r\n{$system_url}?cmd=clientarea\r\n ', 1, 2, 1, 0, 0, 2),
(2, 'Invoice:New', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>New invoice has just been created in your account</p>\r\n\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td><h2>Invoice  #{$invoice.id}</h2></td>\r\n                        <td><h2 class=\"align-right\">{$invoice.date|dateformat:$date_format}</h2></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td><h3>Status:  {$invoice.status}</h3></td>\r\n                        <td><h3 class=\"align-right\">Due: {$invoice.duedate|dateformat:$date_format}</h3></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                            {foreach from=$invoiceitems item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description} {if $item.qty}{$item.qty} x {/if}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$invoice.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n       \r\n       <p>\r\n           <b>Payment method:</b> {$invoice.gateway}<br>\r\n           <b><a href=\"{$invoices_url}\">Browse all invoices</a></b>\r\n       </p>             \r\n', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\nINVOICE  #{$invoice.id} \r\nSTATUS: {$invoice.status}\r\nAMOUNT DUE: {$invoice.total|price:$currency}\r\nDUE DATE: {$invoice.duedate|dateformat:$date_format}\r\nGENERATE ON: {$invoice.date|dateformat:$date_format}.\r\n\r\nPAYMENT METHOD:\r\n {$invoice.gateway}\r\n\r\nInvoice Items\r\n{foreach from=$invoiceitems item=item}\r\n {$item.description}  {if $item.qty}{$item.qty} x {/if}{$item.amount|price:$currency}\r\n{/foreach}\r\n------------------------------------------------------\r\n\r\nPAY LINK:\r\n {$invoices_url}\r\n\r\n', 1, 2, 1, 0, 0, 1),
(3, 'Invoice:Paid', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Paid', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br />\r\n<p>Thank you for payment!</p>\r\n\r\n<p><b>Related Invoice:</b>  #{$invoice.id}</p>\r\n<p><b>Status</b>: {$invoice.status}</p>\r\n<p><b>Total paid</b>: {$invoice.total|price:$currency}</p>\r\n<p><b>Sent on</b>: {$invoice.date|dateformat:$date_format}</p>\r\n<br />\r\n<p><b>All invoices</b> <a href=\"{$clientarea_url}\">{$clientarea_url}</a></p>', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\nTHANK YOU FOR PAYMENT!\r\n\r\nINVOICE  #{$invoice.id} \r\nSTATUS: {$invoice.status}\r\nTOTAL PAID: {$invoice.total|price:$currency}\r\nSENT ON: {$invoice.date|dateformat:$date_format}\r\n\r\n\r\n\r\n\r\nINVOICE HISTORY: {$clientarea_url}\r\n', 1, 2, 1, 0, 0, 1),
(4, 'Order:New', 'General', 'Client', 1, 'New Order #{$order.number}', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Thank you for your recent order!</p>\r\n\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td><h2>Order  #{$order.number}</h2></td>\r\n                        <td></td>\r\n                      </tr>\r\n                      \r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                           {foreach from=$order_details item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$order.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n       \r\n<p>\r\n    We will activate your order as soon as possible after accounting payment (if applies) for this order\r\n</p>             \r\n\r\n\r\n ', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\nThank you for your recent order!\r\n\r\nORDER NUMBER: {$order.number}\r\n\r\n{foreach from=$order_details item=item}\r\n {$item.description} {$item.amount|price:$currency}\r\n{/foreach}\r\n\r\n\r\nWe will activate your order as soon as possible after accounting payment (if applies) for this order\r\n ', 1, 2, 1, 0, 0, 1),
(5, 'Ticket:New', 'Support', 'Client', 1, 'Ticket:New', '<h1>{$ticket.name},</h1>\r\n<br/>\r\nThank you for request. we will be in touch shortly.<br />\r\n<br/>\r\n<b>Subject</b>: {$ticket.subject}<br />\r\n<b>Status</b>: {$ticket.status}<br />\r\n<a href=\"{$ticket_url}\">{$ticket_url}</a><br />\r\n<br/>\r\n{if $ticket_attachments}<br />\r\n<b>Following files have been attached</b>:<br />\r\n{foreach from=$ticket_attachments item=attachment}<br />\r\n{$attachment.org_filename},<br />\r\n{/foreach}<br />\r\n{/if}<br />\r\n<br/>\r\n{if $ticket_attachments_errors}<br />\r\n<b>Following files</b>: {foreach from=$ticket_attachments_errors item=attachment}{$attachment.org_filename},{/foreach} have been rejected.<br />\r\n<b>Supported attachments extensions</b>: {$attachments_ext}<br />\r\n{/if}<br />', '{$ticket.name},\r\n\r\nThank you for request. We will be in touch shortly.\r\n\r\nSUBJECT: {$ticket.subject}\r\n\r\nSTATUS:\r\n{$ticket.status}\r\n{$ticket_url}\r\n\r\n{if $ticket_attachments}\r\nFollowing files have been attached:\r\n{foreach from=$ticket_attachments item=attachment}\r\n{$attachment.org_filename},\r\n{/foreach}\r\n{/if}\r\n\r\n{if $ticket_attachments_errors}\r\nFollowing Files: {foreach from=$ticket_attachments_errors item=attachment}{$attachment.org_filename},{/foreach} have been rejected.\r\nSupported attachments extensions: {$attachments_ext}\r\n{/if}', 1, 2, 1, 0, 0, 1),
(7, 'Account:Created:DirectAdmin', 'Product', 'Client', 1, 'New Hosting Account Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Your order has been accepted and your hosting account has been set-up.</p>\r\n\r\n<h2>New Account Information</h2>\r\n<p>\r\n   <b>Package:</b> {$service.product_name}<br>\r\n   <b>Hostname:</b> {$service.domain}<br>\r\n   <b>First Payment Amount:</b> {$service.firstpayment|price:$currency}<br>\r\n   <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n   <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n   <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n\r\n<h2>Login Details</h2>\r\n<p>\r\n    <b>Username:</b> {$service.username}<br>\r\n    <b>Password:</b> {$service.password}<br><br>\r\n    \r\n    <b>Control Panel URL: http://{$server.ip}:2222/<br>\r\n    Once your domain has propogated, you may also use http://www.{$service.domain}:2222/<br>\r\n</p>\r\n\r\n<h2>Server Information</h2>\r\n<p>\r\n    <b>Server Name:</b> {$server.name}<br>\r\n    <b>Server IP:</b> {$server.ip}<br><br>\r\n    \r\n    If you are using an existing domain with your new hosting account, you will need to update the nameservers to point to the nameservers listed below.\r\n    \r\n    <b>Nameserver 1:</b> {$server.ns1} ({$server.ip1})<br>\r\n    <b>Nameserver 2:</b> {$server.ns2} ({$server.ip2})<br>{if $service_ns3}\r\n    <b>Nameserver 3:</b> {$server.ns3} ({$server.ip3})<br>{/if}{if $service_ns4}\r\n    <b>Nameserver 4:</b> {$server.ns4} ({$server.ip4})<br>{/if}\r\n</p>\r\n\r\n<h2>Uploading Your Website</h2>\r\n<p>\r\n    Once your domain has propagated you may use the details below:\r\n    <br><br>\r\n    <b>FTP Hostname:</b> www.{$service.domain}<br>\r\n    <b>Webpage URL:</b> http://www.{$service.domain}<br>\r\n</p>\r\n\r\n<h2>Email Settings</h2>\r\n<p>\r\n    For email accounts that you setup, you should use the following connection details in your email program:\r\n    <br><br>\r\n    <b>POP3 Host Address:</b> mail.{$service.domain}<br>\r\n    <b>SMTP Host Address:</b> mail.{$service.domain}<br>\r\n    <b>Username:</b> The email address you are checking email for<br>\r\n    <b>Password:</b> As specified in your control panel<br>\r\n</p>', 'Dear {$client.firstname} {$client.lastname}.\r\n\r\nYour order has been accepted and your hosting account has been activated.\r\n\r\n# New Account Information\r\n\r\nHosting Package: {$service.product_name}\r\nDomain: {$service.domain}\r\nFirst Payment Amount: {$service.firstpayment|price:$currency}\r\nTotal Amount: {$service.total|price:$currency}\r\nBilling Cycle: {$service.billingcycle}\r\nNext Due Date: {$service.next_due|dateformat:$date_format}\r\n\r\n# Login Details\r\n\r\nUsername: {$service.username}\r\nPassword: {$service.password}\r\n\r\nControl Panel URL: http://{$server.ip}:2222/\r\nOnce your domain has propogated, you may also use http://www.{$service.domain}:2222/\r\n\r\n# Server Information\r\n\r\nServer Name: {$server.name}\r\nServer IP: {$server.ip}\r\n\r\nIf you are using an existing domain with your new hosting account, you will need to update the nameservers to point to the nameservers listed below.\r\n\r\nNameserver 1: {$server.ns1} ({$server.ip1})\r\nNameserver 2: {$server.ns2} ({$server.ip2}){if $service_ns3}\r\nNameserver 3: {$server.ns3} ({$server.ip3}){/if}{if $service_ns4}\r\nNameserver 4: {$server.ns4} ({$server.ip4}){/if}\r\n\r\n# Uploading Your Website\r\n\r\nOnce your domain has propagated you may use the details below:\r\n\r\nFTP Hostname: www.{$service.domain}\r\nWebpage URL: http://www.{$service.domain}\r\n\r\n# Email Settings\r\n\r\nFor email accounts that you setup, you should use the following connection details in your email program:\r\n\r\nPOP3 Host Address: mail.{$service.domain}\r\nSMTP Host Address: mail.{$service.domain}\r\nUsername: The email address you are checking email for\r\nPassword: As specified in your control panel\r\n', 1, 2, 1, 0, 0, 2),
(8, 'Account:Suspended', 'Product', 'Client', 1, 'Account :Suspended', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p><b >Your hosting account has been <span style=\"color:red\">suspended</span></b></p>\r\n\r\n\r\n<h2>Related Account Information</h2>\r\n<p>\r\n   <b>Package:</b> {$service.product_name}<br>\r\n   <b>Hostname:</b> {$service.domain}<br>\r\n   <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n   <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n   <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYour hosting account has been suspended\r\n\r\n# Account Information\r\n\r\nHosting Package: {$service.product_name}\r\nDomain: {$service.domain}\r\nTotal Amount: {$service.total|price:$currency}\r\nBilling Cycle: {$service.billingcycle}\r\nNext Due Date: {$service.next_due|dateformat:$date_format}\r\n', 1, 2, 1, 0, 0, 1),
(9, 'Account:Unsuspended', 'Product', 'Client', 1, 'Account {$service.domain}: Unsuspended', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p><b >Your hosting account has been <span style=\"color:green\">unsuspended</span></b></p>\r\n\r\n\r\n<h2>Related Account Information</h2>\r\n<p>\r\n   <b>Package:</b> {$service.product_name}<br>\r\n   <b>Hostname:</b> {$service.domain}<br>\r\n   <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n   <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n   <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\nYOUR HOSTING ACCOUNT HAS BEEN UNSUSPENDED \r\n\r\nDETAILS:\r\nPRODUCT/SERVICE: {$service.product_name}\r\nDOMAIN: {$service.domain}\r\nNEXT DUE DATE: {$service.next_due|dateformat:$date_format}\r\n\r\n', 1, 2, 1, 0, 0, 1),
(10, 'Ticket:Reply', 'Support', 'Client', 1, 'Ticket:Reply', '<p>{$reply.body}</p>\r\n<br/>\r\n{$reply.signature}<br />\r\n<hr />\r\n<b>Ticket id</b>: {$ticket.ticket_number}<br />\r\n<b>Subject</b>: {$ticket.subject}<br />\r\n<b>Status</b>: {$ticket.status}<br />\r\n<b>Ticket url</b>:  <a href=\"{$ticket_url}\">{$ticket_url}</a><br />\r\n<hr />', '{$reply.body}\r\n\r\n{$reply.signature}\r\n----------------------------------------------\r\nTicket ID: {$ticket.ticket_number}\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nTicket URL:  {$ticket_url}\r\n----------------------------------------------', 1, 2, 1, 0, 0, 1),
(11, 'Ticket:Reply', 'Support', 'Admin', 1, 'New Admin Ticket Reply', '<p>{$reply.body}</p>\r\n<br/>\r\n<hr />\r\n<b>Ticket id</b>: {$ticket.ticket_number}<br />\r\n<b>Subject</b>: {$ticket.subject}<br />\r\n<b>Status</b>: {$ticket.status}<br />\r\n<b>Url</b>: <a href=\"{$ticket_admin_url}\">{$ticket_admin_url}</a><br />\r\n<b>Available actions</b>:<br />\r\n- Close ticket: <a href=\"{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&status=Closed&make=setstatus\">{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&status=Closed&make=setstatus</a><br />\r\n- Delete ticket: <a href=\"{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&make=deleteticket\">{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&make=deleteticket</a><br />\r\n<hr />', '{$reply.body}\r\n\r\n----------------------------------------------\r\nTicket ID: {$ticket.ticket_number}\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nURL: {$ticket_admin_url}\r\nAvailable actions:\r\n- Close ticket: {$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&status=Closed&make=setstatus\r\n- Delete Ticket: {$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&make=deleteticket\r\n----------------------------------------------', 1, 2, 1, 0, 0, 1),
(12, 'Ticket:New', 'Support', 'Admin', 1, 'New Admin Ticket', '<p>{$ticket.body}</p>\r\n<br/>\r\n<hr />\r\n<b>Subject</b>: {$ticket.subject}<br />\r\n<b>Status</b>: {$ticket.status}<br />\r\n<b>Submitter</b>: {$ticket.name}<br />\r\n<b>Url</b>: <a href=\"{$ticket_admin_url}\">{$ticket_admin_url}</a><br />\r\n<hr />', '{$ticket.body}\r\n\r\n------------------------------------------\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nSubmitter: {$ticket.name}\r\nURL: {$ticket_admin_url}\r\n----------------------------------------------', 1, 2, 1, 0, 0, 1),
(13, 'Ticket:Bounce', 'Support', 'Client', 1, 'Your Ticket was not opened', '<h1>{$email_name},</h1>\r\n<br/>\r\nYour email to our support system could not be accepted as ticket because department you\'ve sent email to is for registered customers only, and your email was not recognised as our customer\'s one.<br />', '{$email_name},\r\n\r\nYour email to our support system could not be accepted as ticket because department you\'ve sent email to is for registered customers only, and Your email was not recognised as our customer\'s one.', 1, 2, 1, 0, 0, 1),
(15, 'Invoice:Overdue', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Payment Reminder', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Your invoice is now <b style=\"color:red\">Overdue</b>. To avoid service interruption, please submit payment at your earliest convenience</p>\r\n\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td><h2>Invoice  #{$invoice.id}</h2></td>\r\n                        <td><h2 class=\"align-right\">{$invoice.date|dateformat:$date_format}</h2></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td><h3>Status:  {$invoice.status}</h3></td>\r\n                        <td><h3 class=\"align-right\">Due: {$invoice.duedate|dateformat:$date_format}</h3></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                            {foreach from=$invoiceitems item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description} {if $item.qty}{$item.qty} x {/if}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$invoice.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n       \r\n       <p>\r\n           <b>Payment method:</b> {$invoice.gateway}<br>\r\n           <b><a href=\"{$invoices_url}\">Browse all invoices</a></b>\r\n       </p>             \r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nINVOICE:                {$invoice.id}\r\nGENERATED AT: {$invoice.date|dateformat:$date_format} \r\nDUE DATE:           {$invoice.duedate|dateformat:$date_format}.\r\n\r\nPAYMENT METHOD \r\n{$invoice.gateway}\r\n\r\n\r\nAmount Due: {$invoice.total|price:$currency}\r\n\r\nLINK TO PAY\r\n{$invoices_url}', 1, 2, 1, 0, 0, 1),
(19, 'Account:Automation Results', 'Product', 'Admin', 1, 'Account #{$service.id} Notify', '<h1>Action: {$account_action}</h1>\r\n<h2>Result: {if $result}<span style=\"color:green\">Success</span>{else}<span style=\"color:red\">FAIL</span>{/if}</h2>\r\n\r\n{if $account_error}\r\n<h2 style=\"color:red\">Errors:</h2>\r\n    <p>{foreach from=$account_error item=errx}\r\n        {$errx}\r\n    {/foreach}</p>\r\n{/if}\r\n<hr />\r\n<p>\r\n    <b>Client:</b> {$client.firstname} {$client.lastname}<br><br>\r\n    \r\n    <b>Order ID:</b>  {$service.order_id} <br>\r\n    <b>Order Number:</b> {$service.order_num} <br>\r\n    <b>Product:</b> {$service.product_name} <br>\r\n    <b>Username:</b> {$service.username} <br> <br>\r\n    \r\n    {if $service.domain}<b>Hostname:</b> {$service.domain} <br>{/if}\r\n    {if $domain_module}<b>Registrar:</b> {$domain_module} <br> <br>{/if}\r\n    \r\n    <b>Server Name:</b> {$server.name} <br>\r\n    <b>Server Hostname:</b> {$server.host} <br>\r\n    <b>Server IP:</b> {$server.ip} <br>\r\n    <b>Server NameServer 1:</b> {$server.ns1} <br>\r\n    <b>Server NameServer 2:</b> {$server.ns2} <br>\r\n</p>\r\n', 'Action: {$account_action}\r\nResult: {if $result}Success{else}FAIL{/if}\r\n\r\n{if $account_error}Errors:\r\n    {foreach from=$account_error item=errx}\r\n        {$errx}\r\n    {/foreach}\r\n{/if}\r\n----------------------------------------------------\r\n# Client: {$client.firstname} {$client.lastname}\r\n# Order ID:  {$service.order_id}\r\n# Order Number: {$service.order_num}\r\n\r\n# Domain Name: {$service.domain}\r\n# Registrar: {$domain_module}\r\n\r\n# Server Name: {$server.name}\r\n# Server Hostname: {$server.host}\r\n# Server IP: {$server.ip}\r\n# Server NameServer 1: {$server.ns1}\r\n# Server NameServer 2: {$server.ns2}\r\n\r\n# Product: {$service.product_name}\r\n# Username: {$service.username}', 1, 2, 1, 0, 0, 1),
(20, 'Account:Created:Cpanel', 'Product', 'Client', 1, 'New Hosting Account Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Your order has been accepted and your hosting account has been activated.</p>\r\n\r\n<h2>New Account Information</h2>\r\n<p>\r\n    <b>Hosting Package:</b> {$service.product_name}<br>\r\n    <b>Domain:</b> {$service.domain}<br>\r\n    <b>First Payment Amount:</b> {$service.firstpayment|price:$currency}<br>\r\n    <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n    <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n    <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n<h2>Login Details</h2>\r\n<p>\r\n    <b>Username:</b> {$service.username}<br>\r\n    <b>Password:</b> {$service.password}<br><br>\r\n    \r\n    <b>Control Panel URL:</b> http://{$server.ip}:2082/<br>\r\n    <b>Secure Control Panel URL:</b> https://{$server.ip}:2083/<br><br>\r\n    \r\n    Once your domain has propogated, you may also use http://www.{$service.domain}:2082/\r\n</p>\r\n\r\n<h2>Server Information</h2>\r\n<p>\r\n    <b>Server Name:</b> {$server.name}<br>\r\n    <b>Server IP:</b> {$server.ip}<br><br>\r\n    \r\n    If you are using an existing domain with your new hosting account, \r\n    you will need to update the nameservers to point to the nameservers listed below.<br><br>\r\n    \r\n    <b>Nameserver 1:</b> {$server.ns1} ({$server.ip1})<br>\r\n    <b>Nameserver 2:</b> {$server.ns2} ({$server.ip2})<br>{if $service_ns3}\r\n    <b>Nameserver 3:</b> {$server.ns3} ({$server.ip3})<br>{/if}{if $service_ns4}\r\n    <b>Nameserver 4:</b> {$server.ns4} ({$server.ip4})<br>{/if}\r\n</p>\r\n\r\n<h2>Uploading Your Website</h2>\r\n<p>\r\n    Once your domain has propagated you may use the details below:<br><br>\r\n    \r\n    <b>FTP Hostname:</b> www.{$service.domain}<br>\r\n    <b>Webpage URL:</b> http://www.{$service.domain}\r\n</p>\r\n<h2>Email Settings</h2>\r\n<p>\r\n    For email accounts that you setup, you should use the following connection details in your email program:\r\n    <br><br>\r\n    <b>POP3 Host Address:</b> mail.{$service.domain}<br>\r\n    <b>SMTP Host Address:</b> mail.{$service.domain}<br>\r\n    <b>Username:</b> The email address you are checking email for<br>\r\n    <b>Password:</b> As specified in your control panel\r\n</p>', 'Dear {$client.firstname} {$client.lastname}.\r\nYour order has been accepted and your hosting account has been activated.\r\n\r\n# New Account Information\r\nHosting Package: {$service.product_name}\r\nDomain: {$service.domain}\r\nFirst Payment Amount: {$service.firstpayment|price:$currency}\r\nTotal Amount: {$service.total|price:$currency}\r\nBilling Cycle: {$service.billingcycle}\r\nNext Due Date: {$service.next_due|dateformat:$date_format}\r\n\r\n# Login Details\r\n\r\nUsername: {$service.username}\r\nPassword: {$service.password}\r\n\r\nControl Panel URL: http://{$server.ip}:2082/\r\nSecure Connection Control Panel URL: https://{$server.ip}:2083/\r\nOnce your domain has propogated, you may also use http://www.{$service.domain}:2082/\r\n\r\n# Server Information\r\n\r\nServer Name: {$server.name}\r\nServer IP: {$server.ip}\r\n\r\nIf you are using an existing domain with your new hosting account, you will need to update the nameservers to point to the nameservers listed below.\r\n\r\nNameserver 1: {$server.ns1} ({$server.ip1})\r\nNameserver 2: {$server.ns2} ({$server.ip2}){if $service_ns3}\r\nNameserver 3: {$server.ns3} ({$server.ip3}){/if}{if $service_ns4}\r\nNameserver 4: {$server.ns4} ({$server.ip4}){/if}\r\n\r\n# Uploading Your Website\r\n\r\nTemporarily you may use one of the addresses given below manage your web site:\r\n\r\nTemporary FTP Hostname: {$server.ip}\r\nTemporary Webpage URL: http://{$server.ip}/~{$service.username}/\r\n\r\nAnd once your domain has propagated you may use the details below:\r\n\r\nFTP Hostname: www.{$service.domain}\r\nWebpage URL: http://www.{$service.domain}\r\n\r\n# Email Settings\r\n\r\nFor email accounts that you setup, you should use the following connection details in your email program:\r\n\r\nPOP3 Host Address: mail.{$service.domain}\r\nSMTP Host Address: mail.{$service.domain}\r\nUsername: The email address you are checking email for\r\nPassword: As specified in your control panel', 1, 2, 1, 0, 0, 2),
(21, 'Account:Created:Plesk', 'Product', 'Client', 1, 'New Hosting Account Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Your order has been accepted and your hosting account has been set-up.</p>\r\n\r\n<h2>New Account Information</h2>\r\n<p>\r\n   <b>Package:</b> {$service.product_name}<br>\r\n   <b>Hostname:</b> {$service.domain}<br>\r\n   <b>First Payment Amount:</b> {$service.firstpayment|price:$currency}<br>\r\n   <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n   <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n   <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n\r\n<h2>Login Details</h2>\r\n<p>\r\n    <b>Username:</b> {$service.username}<br>\r\n    <b>Password:</b> {$service.password}<br><br>\r\n    \r\n    <b>Control Panel URL: https://{$server.ip}:8443/<br>\r\n</p>\r\n\r\n<h2>Server Information</h2>\r\n<p>\r\n    <b>Server Name:</b> {$server.name}<br>\r\n    <b>Server IP:</b> {$server.ip}<br><br>\r\n    \r\n    If you are using an existing domain with your new hosting account, you will need to update the nameservers to point to the nameservers listed below.\r\n    \r\n    <b>Nameserver 1:</b> {$server.ns1} ({$server.ip1})<br>\r\n    <b>Nameserver 2:</b> {$server.ns2} ({$server.ip2})<br>{if $service_ns3}\r\n    <b>Nameserver 3:</b> {$server.ns3} ({$server.ip3})<br>{/if}{if $service_ns4}\r\n    <b>Nameserver 4:</b> {$server.ns4} ({$server.ip4})<br>{/if}\r\n</p>\r\n\r\n<h2>Uploading Your Website</h2>\r\n<p>\r\n    Once your domain has propagated you may use the details below:\r\n    <br><br>\r\n    <b>FTP Hostname:</b> www.{$service.domain}<br>\r\n    <b>Webpage URL:</b> http://www.{$service.domain}<br>\r\n</p>\r\n\r\n<h2>Email Settings</h2>\r\n<p>\r\n    For email accounts that you setup, you should use the following connection details in your email program:\r\n    <br><br>\r\n    <b>POP3 Host Address:</b> mail.{$service.domain}<br>\r\n    <b>SMTP Host Address:</b> mail.{$service.domain}<br>\r\n    <b>Username:</b> The email address you are checking email for<br>\r\n    <b>Password:</b> As specified in your control panel<br>\r\n</p>', 'Dear {$client.firstname} {$client.lastname}.\r\nYour order has been accepted and your hosting account has been activated.\r\n\r\n# New Account Information\r\n\r\nHosting Package: {$service.product_name}\r\nDomain: {$service.domain}\r\nFirst Payment Amount: {$service.firstpayment|price:$currency}\r\nTotal Amount: {$service.total|price:$currency}\r\nBilling Cycle: {$service.billingcycle}\r\nNext Due Date: {$service.next_due|dateformat:$date_format}\r\n\r\n# Login Details\r\n\r\nUsername: {$service.username}\r\nPassword: {$service.password}\r\n\r\nControl Panel URL: https://{$server.ip}:8443/\r\n\r\n# Server Information\r\n\r\nServer Name: {$server.name}\r\nServer IP: {$server.ip}\r\n\r\nIf you are using an existing domain with your new hosting account, you will need to update the nameservers to point to the nameservers listed below.\r\n\r\nNameserver 1: {$server.ns1} ({$server.ip1})\r\nNameserver 2: {$server.ns2} ({$server.ip2}){if $server.ns3}\r\nNameserver 3: {$server.ns3} ({$server.ip3}){/if}{if $server.ns4}\r\nNameserver 4: {$server.ns4} ({$server.ip4}){/if}\r\n\r\n# Uploading Your Website\r\n\r\nTemporarily you may use one of the addresses given below manage your web site:\r\n\r\nTemporary FTP Hostname: {$server.ip}\r\nTemporary Webpage URL: https://{$server.ip}:8443/sitepreview/http/{$service.domain}/\r\n\r\nAnd once your domain has propagated you may use the details below:\r\n\r\nFTP Hostname: www.{$service.domain}\r\nWebpage URL: http://www.{$service.domain}\r\n\r\n# Email Settings\r\n\r\nFor email accounts that you setup, you should use the following connection details in your email program:\r\n\r\nPOP3 Host Address: mail.{$service.domain}\r\nSMTP Host Address: mail.{$service.domain}\r\nUsername: The email address you are checking email for\r\nPassword: As specified in your control panel\r\n', 1, 2, 1, 0, 0, 2),
(23, 'Cron Results', 'General', 'Admin', 1, 'Cron-Run Results', '<h1>Cron Report generated: {$date}</h1>\r\n<p style=\"color:red\">{$failed_tasks}</p>\r\n\r\n<h2>Invoices</h2>\r\n    <h3>Invoices Generated ({$invoices_generated_count})</h3>\r\n    {if $invoices_generated}  \r\n    <p style=\"padding-left:10px\">\r\n        {foreach from=$invoices_generated item=gen_inv}\r\n            #{$gen_inv.id} - {$gen_inv.client}(ID: {$gen_inv.client_id}) - Total: {$gen_inv.total|price:$currency}<br/>\r\n        {/foreach}\r\n    </p>\r\n    {/if}\r\n\r\n\r\n<h3>Invoices Cancelled ({$invoices_cancelled_count})</h3>\r\n    {if $invoices_cancelled}\r\n    <p style=\"padding-left:10px\">\r\n        {foreach from=$invoices_cancelled item=can_inv}\r\n            #{$can_inv.id}: {$can_inv.firstname} {$can_inv.lastname}(ID: {$can_inv.client_id}) - Total: {$can_inv.total|price:$currency}, Balance: {$can_inv.balance|price:$currency}<br/>\r\n        {/foreach}\r\n    </p>\r\n    {/if}\r\n\r\n\r\n{if $reminds}\r\n<h3>Overdue Invoice Reminders Sent ({$reminds_count})</h3>\r\n <p style=\"padding-left:10px\">\r\n    {foreach from=$reminds item=remind}\r\n        {if $remind.number == 1}First{elseif $remind.number == 2}Second{else}Third{/if} Remind For {$remind.client}(ID:{$remind.client_id}) - Invoice #{$remind.id}<br/>\r\n    {/foreach}\r\n    </p>\r\n{/if}\r\n\r\n<br>\r\n\r\n<h2>Accounts</h2>\r\n<h3>Accounts Suspended ({$suspended_accounts_count})</h3>\r\n{if $suspended_accounts}\r\n <p style=\"padding-left:10px\">\r\n    {foreach from=$suspended_accounts item=sacc}\r\n        #{$sacc.id}: {$sacc.product_name} - {$sacc.domain} (Server: {$sacc.server_name} - {$sacc.server_ip}, Username: {$sacc.username}) Client: {$sacc.client}(ID:{$sacc.client_id})<br/>\r\n    {/foreach}\r\n</p>\r\n{/if}\r\n\r\n<h3>Accounts Terminated ({$terminated_accounts_count})</h3>\r\n{if $terminated_accounts}\r\n <p style=\"padding-left:10px\">\r\n    {foreach from=$terminated_accounts item=tacc}\r\n        #{$tacc.id}: {$tacc.product_name} - {$tacc.domain} (Server: {$tacc.server_name} - {$tacc.server_ip}, Username: {$tacc.username}) Client: {$tacc.client}(ID:{$tacc.client_id})<br/>\r\n    {/foreach}\r\n</p>\r\n{/if}\r\n\r\n<br>\r\n\r\n<h2>Addons</h2>\r\n<h3>Addons Suspended ({$suspended_addons_count})</h3>\r\n{if $suspended_addons}\r\n <p style=\"padding-left:10px\">\r\n    {foreach from=$suspended_addons item=sadd}<br/>\r\n        #{$sadd.id}: {$sadd.name} {if $sadd.product_name}({$sadd.product_name}, {$sadd.domain}){else}(Account ID:{$sadd.account_id}){/if} Client: {$sadd.client}(ID:{$sadd.client_id})<br/>\r\n    {/foreach}\r\n</p>\r\n{/if}\r\n\r\n<h3>Addons Terminated ({$terminated_addons_count})</h3>\r\n{if $terminated_addons}\r\n <p style=\"padding-left:10px\">\r\n    {foreach from=$terminated_addons item=tadd}\r\n        #{$tadd.id}: {$tadd.name} {if $tadd.product_name}({$tadd.product_name}, {$sadd.domain}){else}(Account ID:{$tadd.account_id}){/if} Client: {$tadd.client}(ID:{$tadd.client_id})<br/>\r\n    {/foreach}\r\n\r\n{/if}\r\n\r\n<br>\r\n\r\n<h2>Domains</h2>\r\n<h3>Upcoming Domain Renewal Notifications Sent ({$domain_reminds_count})</h3>\r\n\r\n{if $domain_reminds}\r\n <p style=\"padding-left:10px\">\r\n	{foreach from=$domain_reminds item=remind}\r\n	- Client: {$remind.client} (ID:{$remind.client_id}) - {$remind.domain} expiring: {$remind.expires|dateformat:$date_format}<br/>\r\n	 {/foreach}\r\n	 </p>\r\n{/if}\r\n<br>\r\n\r\n<h2>Cancellation Requests Processing</h2>\r\n<h3>Successfull automatic cancellations ({$cancellations_success_count})</h3>\r\n{if $cancellations_success}\r\n <p style=\"padding-left:10px\">\r\n	{foreach from=$cancellations_success item=cancel}<br/>\r\n	#Acc ID: {$cancel.account_id} - Client: {$cancel.client} (ID:{$cancel.client_id}) - {$cancel.domain}<br/>\r\n	 {/foreach}\r\n </p>\r\n{/if}\r\n\r\n\r\n<h3>Manual cancellation needed ({$cancellations_failed_count})</h3>\r\n{if $cancellations_failed}\r\n <p style=\"padding-left:10px\">\r\n      <strong style=\"color:red\">[see errors below]</strong><br/>\r\n	{foreach from=$cancellations_failed item=cancel}\r\n	    #Acc ID: {$cancel.account_id} - Client: {$cancel.client} (ID:{$cancel.client_id}) - {$cancel.domain}<br/>\r\n	 {/foreach}\r\n	 </p>\r\n{/if}\r\n\r\n<br>\r\n\r\n<h2>Support</h2>\r\n\r\n<h3>Tickets Automatically Closed ({$tickets_closed_count})</h3>\r\n{if $tickets_closed}\r\n     <p style=\"padding-left:10px\">\r\n     {foreach from=$tickets_closed item=closed}\r\n        - {$closed.subject}<br/>\r\n    {/foreach}\r\n    </p>\r\n{/if}\r\n\r\n<hr />\r\n<h2>Errors</h2>\r\n{if $suspend_errors}\r\n\r\n    <h3>Failed accounts automatic suspension (<span style=\"color:red\">{$suspend_errors_count}</span>)</h3>\r\n    <p>{foreach from=$suspend_errors item=sus_err}\r\n        #{$sus_err.id}: {$sus_err.product_name} - {$sus_err.domain} (Server: {$sus_err.server_name} - {$sus_err.server_ip}, Username: {$sus_err.username}) Client: {$sus_err.client}(ID:{$sus_err.client_id})<br/>\r\n        <span style=\"color:red\">{$sus_err.error}</span><br/><br/>\r\n    {/foreach}</p>\r\n    \r\n{/if}\r\n\r\n{if $terminate_errors}\r\n\r\n    <h3>Failed accounts automatic termination (<span style=\"color:red\">{$terminate_errors_count}</span>)</h3>\r\n     <p>{foreach from=$terminate_errors item=ter_err}\r\n        #{$ter_err.id}: {$ter_err.product_name} - {$ter_err.domain} (Server: {$ter_err.server_name} - {$ter_err.server_ip}, Username: {$ter_err.username}) Client: {$ter_err.client}(ID:{$ter_err.client_id})<br/>\r\n        <span style=\"color:red\">{$ter_err.error}</span><br/><br/>\r\n    {/foreach}</p>\r\n{/if}\r\n\r\n{if $cancellations_failed}\r\n\r\n    <h3>Errors during automatic cancellation requests processing:</h3>\r\n	 <p>{foreach from=$cancellations_failed item=cancel}<br/>\r\n	    #Acc ID: {$cancel.account_id} - Client: {$cancel.client} (ID:{$cancel.client_id}) - {$cancel.domain} <br/>\r\n       {foreach from=$cancel.errors item=err} \r\n            <span style=\"color:red\">{$err}</span><br/>\r\n		{/foreach}<br/>\r\n      {/foreach}</p>\r\n{/if}\r\n\r\n<hr />\r\n {$output}\r\n', '{$failed_tasks}\r\nCron Report generated: {$date}\r\nInvoices\r\nInvoices Generated ({$invoices_generated_count})\r\n{if $invoices_generated}\r\n{foreach from=$invoices_generated item=gen_inv}\r\n        #{$gen_inv.id} - {$gen_inv.client}(ID: {$gen_inv.client_id}) - Total: {$gen_inv.total|price:$currency}\r\n    {/foreach}\r\n{else}\r\n{/if}\r\nInvoices Cancelled ({$invoices_cancelled_count})\r\n{if $invoices_cancelled}\r\n    {foreach from=$invoices_cancelled item=can_inv}\r\n        #{$can_inv.id}: {$can_inv.firstname} {$can_inv.lastname}(ID: {$can_inv.client_id}) - Total: {$can_inv.total|price:$currency}, Balance: {$can_inv.balance|price:$currency}\r\n    {/foreach}\r\n{else}\r\n{/if}\r\n{if $reminds}\r\nOverdue Invoice Reminders Sent ({$reminds_count})\r\n    {foreach from=$reminds item=remind}\r\n        {if $remind.number == 1}First{elseif $remind.number == 2}Second{else}Third{/if} Remind For {$remind.client}(ID:{$remind.client_id}) - Invoice #{$remind.id}\r\n    {/foreach}\r\n{/if}\r\nAccounts\r\nAccounts Suspended ({$suspended_accounts_count})\r\n{if $suspended_accounts}\r\n    {foreach from=$suspended_accounts item=sacc}\r\n        #{$sacc.id}: {$sacc.product_name} - {$sacc.domain} (Server: {$sacc.server_name} - {$sacc.server_ip}, Username: {$sacc.username}) Client: {$sacc.client}(ID:{$sacc.client_id})\r\n    {/foreach}\r\n{else}\r\n{/if}\r\nAccounts Terminated ({$terminated_accounts_count})\r\n{if $terminated_accounts}\r\n    {foreach from=$terminated_accounts item=tacc}\r\n        #{$tacc.id}: {$tacc.product_name} - {$tacc.domain} (Server: {$tacc.server_name} - {$tacc.server_ip}, Username: {$tacc.username}) Client: {$tacc.client}(ID:{$tacc.client_id})\r\n    {/foreach}\r\n{else}\r\n{/if}\r\nAddons\r\nAddons Suspended ({$suspended_addons_count})\r\n{if $suspended_addons}\r\n    {foreach from=$suspended_addons item=sadd}\r\n        #{$sadd.id}: {$sadd.name} {if $sadd.product_name}({$sadd.product_name}, {$sadd.domain}){else}(Account ID:{$sadd.account_id}){/if} Client: {$sadd.client}(ID:{$sadd.client_id})\r\n    {/foreach}\r\n{else}\r\n{/if}\r\nAddons Terminated ({$terminated_addons_count})\r\n{if $terminated_addons}\r\n    {foreach from=$terminated_addons item=tadd}\r\n        #{$tadd.id}: {$tadd.name} {if $tadd.product_name}({$tadd.product_name}, {$sadd.domain}){else}(Account ID:{$tadd.account_id}){/if} Client: {$tadd.client}(ID:{$tadd.client_id})\r\n    {/foreach}\r\n{else}\r\n{/if}\r\nUpcoming Domain Renewal Notifications Sent ({$domain_reminds_count})\r\n{if $domain_reminds}\r\n	{foreach from=$domain_reminds item=remind}\r\n	- Client: {$remind.client} (ID:{$remind.client_id}) - {$remind.domain} expiring: {$remind.expires|dateformat:$date_format}\r\n	 {/foreach}\r\n{/if}\r\nCancellation Requests Processing\r\nSuccessfull automatic cancellations ({$cancellations_success_count})\r\n{if $cancellations_success}\r\n	{foreach from=$cancellations_success item=cancel}\r\n	#Acc ID: {$cancel.account_id} - Client: {$cancel.client} (ID:{$cancel.client_id}) - {$cancel.domain}\r\n	 {/foreach}\r\n{/if}\r\nManual cancellation needed ({$cancellations_failed_count})\r\n{if $cancellations_failed} [see errors below]\r\n	{foreach from=$cancellations_failed item=cancel}\r\n	#Acc ID: {$cancel.account_id} - Client: {$cancel.client} (ID:{$cancel.client_id}) - {$cancel.domain}\r\n	 {/foreach}\r\n{/if}\r\nTickets\r\nTickets Automatically Closed ({$tickets_closed_count})\r\n{if $tickets_closed}\r\n {foreach from=$tickets_closed item=closed}\r\n- {$closed.subject}\r\n{/foreach}\r\n{/if}\r\n------------------------------------------------------------------------\r\nErrors:\r\n{if $suspend_errors}\r\n    Failed accounts automatic suspension ({$suspend_errors_count})\r\n    {foreach from=$suspend_errors item=sus_err}\r\n        #{$sus_err.id}: {$sus_err.product_name} - {$sus_err.domain} (Server: {$sus_err.server_name} - {$sus_err.server_ip}, Username: {$sus_err.username}) Client: {$sus_err.client}(ID:{$sus_err.client_id})\r\n        {$sus_err.error}\r\n    {/foreach}\r\n{/if}\r\n{if $terminate_errors}\r\n    Failed accounts automatic termination ({$terminate_errors_count})\r\n    {foreach from=$terminate_errors item=ter_err}\r\n        #{$ter_err.id}: {$ter_err.product_name} - {$ter_err.domain} (Server: {$ter_err.server_name} - {$ter_err.server_ip}, Username: {$ter_err.username}) Client: {$ter_err.client}(ID:{$ter_err.client_id})\r\n        {$ter_err.error}\r\n    {/foreach}\r\n{/if}\r\n{if $cancellations_failed}\r\nErrors during automatic cancellation requests processing:\r\n	{foreach from=$cancellations_failed item=cancel}\r\n	#Acc ID: {$cancel.account_id} - Client: {$cancel.client} (ID:{$cancel.client_id}) - {$cancel.domain} \r\n                           {foreach from=$cancel.errors item=err} {$err}\r\n		{/foreach}\r\n            {/foreach}\r\n{/if}\r\n------------------------------------------------------------------------\r\n {$output}\r\n', 1, 2, 1, 0, 0, 1),
(24, 'Order:New', 'General', 'Admin', 1, 'New Order #{$order.id}', '<h1>New order: {$order.id}</h1>\r\n\r\n<h2>Order Info</h2>\r\n<p>\r\n    <b>Order ID:</b> {$order.id}<br>\r\n    <b>Order Number:</b> {$order.number}<br>\r\n    <b>Date Created:</b> {$order.date_created|dateformat:$date_format}<br>\r\n    <b>Invoice Number:</b> {$order.invoice_id}<br>\r\n    <b>Payment Method:</b> {$order.module}<br>\r\n    {if $order.fraudscore}<b>FraudModule risk score:</b> {$order.fraudscore}<br>{/if}\r\n    <b>IP:</b> {$ip_addr}<br>\r\n    <b>Host:</b> {$host_addr}<br>\r\n\r\n</p>\r\n\r\n\r\n<h2>Order Items</h2>\r\n{if $order_details}\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      \r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                           {foreach from=$order_details item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total (+tax):</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$order.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n{else}\r\n    <p>No items to list.</p>\r\n{/if}\r\n   \r\n   \r\n<h2>Client Info</h2>\r\n<p>\r\n    <b>ID:</b> {$client.id} <br>\r\n    <b>Name:</b> {$client.firstname} {$client.lastname} <br>\r\n    <b>Email:</b> {$client.email} <br>\r\n    <b>Company:</b> {$client.companyname} <br>\r\n    <b>Address 1:</b> {$client.address1} <br>\r\n    <b>Address 2:</b> {$client.address2} <br>\r\n    <b>City:</b> {$client.city} <br>\r\n    <b>State/Region:</b> {$client.state} <br>\r\n    <b>Zip Code:</b> {$client.postcode} <br>\r\n    <b>Country:</b> {$client.country} <br>\r\n    <b>Phone Number:</b> {$client.phonenumber} \r\n</p>\r\n', '---------------------------------------------------------------\r\nOrder Info\r\n---------------------------------------------------------------\r\n# Order ID: {$order.id}\r\n# Order Number: {$order.number}\r\n# Date Created: {$order.date_created|dateformat:$date_format}\r\n# Invoice Number: {$order.invoice_id}\r\n# Payment Method: {$order.module}\r\n{if $order.fraudscore}# FraudModule risk score: {$order.fraudscore}{/if}\r\n\r\n---------------------------------------------------------------\r\nClient Info\r\n---------------------------------------------------------------\r\n# ID: {$client.id}\r\n# Name: {$client.firstname} {$client.lastname}\r\n# Email: {$client.email}\r\n# Company: {$client.companyname}\r\n# Address 1: {$client.address1}\r\n# Address 2: {$client.address2}\r\n# City: {$client.city}\r\n# State/Region: {$client.state}\r\n# Zip Code: {$client.postcode}\r\n# Country: {$client.country}\r\n# Phone Number: {$client.phonenumber}\r\n\r\n---------------------------------------------------------------\r\nOrder Items\r\n---------------------------------------------------------------\r\n{if $order_details}\r\n{foreach from=$order_details item=item}\r\n #  {$item.amount|price:$currency} - {$item.description}\r\n{/foreach}\r\n\r\nTotal(+tax): {$order.total|price:$currency}\r\n{else}\r\nNo items to list.\r\n{/if}\r\n\r\n\r\n---------------------------------------------------------------\r\nIP: {$ip_addr}\r\nHost: {$host_addr}', 1, 2, 1, 0, 0, 1),
(25, 'Account:Cancellation Request', 'General', 'Admin', 1, 'Account #{$details.acc_id} Cancellation Request', '<h1>New cancellation request</h1>\r\n\r\n\r\n<p>\r\n    <b>Client ID:</b> {$client.id}  <br>\r\n    <b>Client Name:</b> {$client.firstname} {$client.lastname}  <br>\r\n</p>\r\n\r\n<p>\r\n    <b>Order ID:</b> {$order_id} <br>\r\n    <b>Account ID:</b> {$details.acc_id} <br>\r\n    <b>Type:</b> {$details.type} <br>\r\n    <b style=\"color:red\">Reason:</b> {$details.reason} <br> <br>\r\n</p>', 'Cancellation request has been submitted by:\r\n# Client ID: {$client.id} \r\n# Client Name: {$client.firstname} {$client.lastname} \r\n\r\n# Order ID: {$order_id}\r\n\r\n# Account ID: {$details.acc_id}\r\n# Type: {$details.type}\r\n# Reason: {$details.reason}', 1, 2, 1, 0, 0, 1),
(28, 'Domain:Registered', 'Domain', 'Client', 1, 'Domain {$domain.name}: Registered', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br/>\r\n<b>Domain</b>: {$domain.name} has been registered.<br />\r\n<br/>\r\n\r\n<b>Details</b>:<br />\r\n<b>Registration date</b>: {$domain.date_created|dateformat:$date_format}<br />\r\n<b>Registration period</b>: {$domain.period} year/s<br />\r\n<b>Next due date</b>: {$domain.next_due|dateformat:$date_format}<br />\r\n<b>Amount</b>: {$domain.firstpayment|price:$currency}<br />', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nDOMAIN: {$domain.name} has been registered.\r\n\r\n\r\nDETAILS:\r\nREGISTRATION DATE: {$domain.date_created|dateformat:$date_format}\r\nREGISTRATION PERIOD: {$domain.period} year/s\r\nNEXT DUE DATE: {$domain.next_due|dateformat:$date_format}\r\nAMOUNT: {$domain.firstpayment|price:$currency}', 1, 2, 1, 1, 0, 1);
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`) VALUES
(29, 'Domain:Renewed', 'Domain', 'Client', 1, 'Domain {$domain.name}: Renewed', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br/>\r\n<b>Domain</b>: {$domain.name} has been renewed!<br/>\r\n<br/>\r\n<b>Details</b>:<br/>\r\n<b>Renewal period</b>:  {$domain.period} year/s<br/>\r\n<b>Renewal price</b>: {$domain.recurring_amount|price:$currency}<br/>\r\n<b>Next due date</b>:  {$domain.next_due|dateformat:$date_format}<br/>\r\n<br/>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nDOMAIN: {$domain.name} has been renewed!\r\n\r\nDETAILS:\r\nRENEWAL PERIOD:  {$domain.period} year/s\r\nRENEWAL PRICE: {$domain.recurring_amount|price:$currency}\r\nNEXT DUE DATE:  {$domain.next_due|dateformat:$date_format}\r\n', 1, 2, 1, 1, 0, 1),
(30, 'Domain:Transfer Started', 'Domain', 'Client', 1, 'Domain {$domain.name}: Transfer Initiated', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br/>\r\n<b>Transfer of  domain</b>: {$domain.name} has been initiated.<br/>\r\n<br/>\r\n<b>Details</b>:<br/>\r\n<b>Registration period</b>:  {$domain.period} year/s<br/>\r\n<b>Amount</b>:  {$domain.firstpayment|price:$currency}<br/>\r\n<b>Renewal price</b>: {$domain.recurring_amount|price:$currency}<br/>\r\n<b>Next due date</b>:  {$domain.next_due|dateformat:$date_format}<br/>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nTransfer of  DOMAIN: {$domain.name} has been initiated. \r\n\r\nDETAILS:\r\nREGISTRATION PERIOD:  {$domain.period} year/s\r\nAMOUNT:  {$domain.firstpayment|price:$currency}\r\nRENEWAL PRICE: {$domain.recurring_amount|price:$currency}\r\nNEXT DUE DATE:  {$domain.next_due|dateformat:$date_format}', 1, 2, 1, 1, 0, 1),
(32, 'Details:Failed Login', 'General', 'Admin', 1, 'Failed Admin Login', '{if $third}\r\n<p style=\"color:red\">\r\n     This is third failed login attempt!<br>\r\n    IP <b>{$ip}</b> has been banned for 5 hours.\r\n</p>\r\n   \r\n{else}\r\n    <h2>There was a failed login attempt to HostBill admin area.</h2>\r\n{/if}\r\n<p>\r\n    <b>Date:</b> {$date}<br>\r\n    <b>IP:</b> {$ip}<br>\r\n    <b>Host:</b> {$host}<br>\r\n    <b>Login:</b> {$login}\r\n</p>', '{if $third}\r\nThis is third failed login attempt!\r\nIP has been banned for 5 hours.\r\n{else}\r\nThere was a failed login attempt to admin area in HostBill.\r\n{/if}\r\n----------------------------------------------------\r\nDate: {$date}\r\nIP: {$ip}\r\nHost: {$host}\r\n\r\nLogin: {$login}\r\n----------------------------------------------------', 1, 2, 1, 1, 0, 1),
(33, 'Clients:Details Changed', 'General', 'Admin', 1, 'Client #{$old.id} Details Changed', '<h1>Client #{$old.id} changed his details</h1>\r\n\r\n<h2>Old details</h2>\r\n<p>\r\n    <b>First Name</b> {$old.firstname}<br>\r\n    <b>Last Name</b> {$old.lastname}<br>\r\n    <b>Email Address</b> {$old.email}<br>\r\n    <b>Company Name</b> {$old.companyname}<br>\r\n    <b>Address 1</b> {$old.address1}<br>\r\n    <b>Address 2</b> {$old.address2}<br>\r\n    <b>City</b> {$old.city}<br>\r\n    <b>State/Region</b> {$old.state}<br>\r\n    <b>Zip Code</b> {$old.postcode}<br>\r\n    <b>Country</b> {$old.country}<br>\r\n    <b>Phone Number</b> {$old.phonenumber}<br>\r\n</p>\r\n\r\n<h2>New details</h2>\r\n<p>\r\n    <b>First Name</b> {$new.firstname}<br>\r\n    <b>Last Name</b> {$new.lastname}<br>\r\n    <b>Email Address</b> {$new.email}<br>\r\n    <b>Company Name</b> {$new.companyname}<br>\r\n    <b>Address 1</b> {$new.address1}<br>\r\n    <b>Address 2</b> {$new.address2}<br>\r\n    <b>City</b> {$new.city}<br>\r\n    <b>State/Region</b> {$new.state}<br>\r\n    <b>Zip Code</b> {$new.postcode}<br>\r\n    <b>Country</b> {$new.country}<br>\r\n    <b>Phone Number</b> {$new.phonenumber}<br>\r\n</p>', 'Client with ID #{$old.id} changed his details.\r\n\r\n---------------------------------------------------------------\r\nOld Details\r\n---------------------------------------------------------------\r\n# First Name: {$old.firstname}\r\n# Last Name: {$old.lastname}\r\n# Email Address: {$old.email}\r\n# Company Name: {$old.companyname}\r\n# Address 1: {$old.address1}\r\n# Address 2: {$old.address2}\r\n# City: {$old.city}\r\n# State/Region: {$old.state}\r\n# Zip Code: {$old.postcode}\r\n# Country: {$old.country}\r\n# Phone Number: {$old.phonenumber}\r\n\r\n---------------------------------------------------------------\r\nNew Details\r\n---------------------------------------------------------------\r\n# First Name: {$new.firstname}\r\n# Last Name: {$new.lastname}\r\n# Email Address: {$new.email}\r\n# Company Name: {$new.companyname}\r\n# Address 1: {$new.address1}\r\n# Address 2: {$new.address2}\r\n# City: {$new.city}\r\n# State/Region: {$new.state}\r\n# Zip Code: {$new.postcode}\r\n# Country: {$new.country}\r\n# Phone Number: {$new.phonenumber}', 1, 2, 1, 1, 0, 1),
(34, 'Account:Automatic Setup', 'Product', 'Admin', 1, 'Automatic Setup: Account #{$service.id}', '<h1>Automatic setup notification</h1>\r\n\r\n<p>\r\n    First payment has been received for the following order and account has been automatically created.\r\n</p>\r\n\r\n<p>\r\n    <b>Client:</b> {$client.firstname} {$client.lastname}, ID: {$client.client_id} <br>\r\n    <b>Product: </b>{$service.product_name} <br>\r\n    <b>Domain:</b> {$service.domain} <br>\r\n    <b>Order ID:</b> {$service.order_id} <br>\r\n    <b>Order Number:</b> {$service.order_num} <br>\r\n</p>', 'First payment has been received for the following order and account has been automatically created.\r\n\r\n# Order ID: {$service.order_id}\r\n# Order Number: {$service.order_num}\r\n\r\n# Client: {$client.firstname} {$client.lastname}, ID: {$client.client_id}\r\n# Product: {$service.product_name}\r\n# Domain: {$service.domain}', 1, 2, 1, 1, 0, 1),
(35, 'Details:Password Reset', 'General', 'Client', 1, 'Login details to {$system_url}', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Your new client area password has been generated</p>\r\n<p>\r\n    <b>E-mail:</b> {$client.email}<br>\r\n    <b>Password:</b> {$newpass}<br><br>\r\n    \r\n    <b>Login URL:</b>  <a href=\"{$system_url}\">{$system_url}</a>\r\n</p>\r\n ', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\n\r\nEMAIL: {$client.email}\r\nPASSWORD:{$newpass}\r\n\r\nLOGIN LINK  {$system_url}\r\n ', 1, 2, 1, 1, 0, 2),
(54, 'Domain:Reminder', 'Domain', 'Client', 1, 'Domain: {$domain.name} Renew Now', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br/>\r\n<b>Domain</b>:{$domain.name}  will expire on {$domain.expires|dateformat:$date_format} .<br/>\r\n<br/>\r\n\r\n<b>Renew domain</b>: <a href=\"{$clientarea_url}\">{$clientarea_url}</a><br/>\r\n<br/>\r\n', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\nDOMAIN:{$domain.name}  WILL EXPIRE ON {$domain.expires|dateformat:$date_format} .\r\n\r\n\r\n\r\nRENEW DOMAIN:\r\n {$clientarea_url}\r\n\r\n', 1, 2, 1, 0, 0, 1),
(55, 'Ticket:AutoClose', 'Support', 'Client', 1, 'Support Ticket Closed', '<h1>{$ticket.name},</h1>\r\n<br/>\r\n<b>Ticket</b>: #{$ticket.ticket_number} changed status from open to closed<br/>\r\n<b>Last response</b>: {$ticket_autoclose_time} hours ago.<br/>\r\n<br/>\r\nIf your issue is not resolved within a reasonable timeframe, you should contact us again.<br/>\r\n<br/>\r\n<hr/>\r\n<b>Subject</b>: {$ticket.subject}<br/>\r\n<b>Department</b>: {$ticket.department}<br/>\r\n<b>Status</b>: {$ticket.status}<br/>\r\n<hr/>\r\n<br/>', '{$ticket.name},\r\n\r\nTicket: #{$ticket.ticket_number} changed status from Open to Closed \r\nLast response: {$ticket_autoclose_time} hours ago. \r\n\r\nIf your issue is not resolved within a reasonable timeframe, you should contact us again.\r\n\r\n------------------------------------- \r\nSubject: {$ticket.subject} \r\nDepartment: {$ticket.department} \r\nStatus: {$ticket.status} \r\n-------------------------------------\r\n', 1, 2, 1, 0, 0, 1),
(56, 'Domain:Manual Register', 'Domain', 'Admin', 1, 'Register Domain {$domain.name}', '<h1>Domain name: {$domain.name}</h1>\r\n# period: {$domain.period} year/s<br/>\r\n{foreach from=$nameservers item=ns key=nsnr}<br/>\r\n{if $ns}# name server {$nsnr} : {$ns}{/if}<br/>\r\n{/foreach}<br/>\r\n<br/>\r\n# registrant first name: {$client.firstname}<br/>\r\n# registrant last name: {$client.lastname}<br/>\r\n# registrant email: {$client.email}<br/>\r\n# registrant company: {$client.companyname}<br/>\r\n# registrant address 1: {$client.address1}<br/>\r\n# registrant address 2: {$client.address2}<br/>\r\n# registrant city: {$client.city}<br/>\r\n# registrant state/Region: {$client.state}<br/>\r\n# registrant zip code: {$client.postcode}<br/>\r\n# registrant country: {$client.country}<br/>\r\n# registrant phone number: {$client.phonenumber}<br/>\r\n<br/>\r\n# admin first name: {$client.firstname}<br/>\r\n# admin last name: {$client.lastname}<br/>\r\n# admin email: {$client.email}<br/>\r\n# admin company: {$client.companyname}<br/>\r\n# admin address 1: {$client.address1}<br/>\r\n# admin address 2: {$client.address2}<br/>\r\n# admin city: {$client.city}<br/>\r\n# admin state/Region: {$client.state}<br/>\r\n# admin zip code: {$client.postcode}<br/>\r\n# admin country: {$client.country}<br/>\r\n# admin phone number: {$client.phonenumber}<br/>', '# Domain Name: {$domain.name}\r\n# Period: {$domain.period} Year/s\r\n{foreach from=$nameservers item=ns key=nsnr}\r\n{if $ns}# Name Server {$nsnr} : {$ns}{/if}\r\n{/foreach}\r\n\r\n# Registrant First Name: {$client.firstname}\r\n# Registrant Last Name: {$client.lastname}\r\n# Registrant Email: {$client.email}\r\n# Registrant Company: {$client.companyname}\r\n# Registrant Address 1: {$client.address1}\r\n# Registrant Address 2: {$client.address2}\r\n# Registrant City: {$client.city}\r\n# Registrant State/Region: {$client.state}\r\n# Registrant Zip Code: {$client.postcode}\r\n# Registrant Country: {$client.country}\r\n# Registrant Phone Number: {$client.phonenumber}\r\n\r\n# Admin First Name: {$client.firstname}\r\n# Admin Last Name: {$client.lastname}\r\n# Admin Email: {$client.email}\r\n# Admin Company: {$client.companyname}\r\n# Admin Address 1: {$client.address1}\r\n# Admin Address 2: {$client.address2}\r\n# Admin City: {$client.city}\r\n# Admin State/Region: {$client.state}\r\n# Admin Zip Code: {$client.postcode}\r\n# Admin Country: {$client.country}\r\n# Admin Phone Number: {$client.phonenumber}', 1, 2, 1, 1, 0, 1),
(57, 'Domain:Manual Transfer', 'Domain', 'Admin', 1, 'Transfer Domain {$domain.name}', '<h1>Domain name: {$domain.name}</h1>\r\n# period: {$domain.period} year/s<br/>\r\n# epp code: {$domain.epp_code}<br/>\r\n{foreach from=$nameservers item=ns key=nsnr}<br/>\r\n{if $ns}<br/>\r\n# name server {$nsnr} : {$ns}<br/>\r\n{/if}<br/>\r\n{/foreach}<br/>\r\n<br/>\r\n# registrant first name: {$client.firstname}<br/>\r\n# registrant last name: {$client.lastname}<br/>\r\n# registrant email: {$client.email}<br/>\r\n# registrant company: {$client.companyname}<br/>\r\n# registrant address 1: {$client.address1}<br/>\r\n# registrant address 2: {$client.address2}<br/>\r\n# registrant city: {$client.city}<br/>\r\n# registrant state/Region: {$client.state}<br/>\r\n# registrant zip code: {$client.postcode}<br/>\r\n# registrant country: {$client.country}<br/>\r\n# registrant phone number: {$client.phonenumber}<br/>\r\n<br/>\r\n# admin first name: {$client.firstname}<br/>\r\n# admin last name: {$client.lastname}<br/>\r\n# admin email: {$client.email}<br/>\r\n# admin company: {$client.companyname}<br/>\r\n# admin address 1: {$client.address1}<br/>\r\n# admin address 2: {$client.address2}<br/>\r\n# admin city: {$client.city}<br/>\r\n# admin state/Region: {$client.state}<br/>\r\n# admin zip code: {$client.postcode}<br/>\r\n# admin country: {$client.country}<br/>\r\n# admin phone number: {$client.phonenumber}<br/>', '# Domain Name: {$domain.name}\r\n# Period: {$domain.period} Year/s\r\n# Epp Code: {$domain.epp_code}\r\n{foreach from=$nameservers item=ns key=nsnr}\r\n{if $ns}\r\n# Name Server {$nsnr} : {$ns}\r\n{/if}\r\n{/foreach}\r\n\r\n# Registrant First Name: {$client.firstname}\r\n# Registrant Last Name: {$client.lastname}\r\n# Registrant Email: {$client.email}\r\n# Registrant Company: {$client.companyname}\r\n# Registrant Address 1: {$client.address1}\r\n# Registrant Address 2: {$client.address2}\r\n# Registrant City: {$client.city}\r\n# Registrant State/Region: {$client.state}\r\n# Registrant Zip Code: {$client.postcode}\r\n# Registrant Country: {$client.country}\r\n# Registrant Phone Number: {$client.phonenumber}\r\n\r\n# Admin First Name: {$client.firstname}\r\n# Admin Last Name: {$client.lastname}\r\n# Admin Email: {$client.email}\r\n# Admin Company: {$client.companyname}\r\n# Admin Address 1: {$client.address1}\r\n# Admin Address 2: {$client.address2}\r\n# Admin City: {$client.city}\r\n# Admin State/Region: {$client.state}\r\n# Admin Zip Code: {$client.postcode}\r\n# Admin Country: {$client.country}\r\n# Admin Phone Number: {$client.phonenumber}', 1, 2, 1, 1, 0, 1),
(58, 'Domain:Manual Renew', 'Domain', 'Admin', 1, 'Renew Domain {$domain.name}', '<h1>Domain name: {$domain.name}</h1>\r\n# period: {$domain.period} year/s<br/>', '# Domain Name: {$domain.name}\r\n# Period: {$domain.period} Year/s', 1, 2, 1, 1, 0, 1),
(59, 'Invoice:Reminder', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Unpaid Reminder', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>We send this email to remind you that your invoice is still unpaid. To avoid service interruption, please submit payment at your earliest convenience</p>\r\n\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td><h2>Invoice  #{$invoice.id}</h2></td>\r\n                        <td><h2 class=\"align-right\">{$invoice.date|dateformat:$date_format}</h2></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td><h3>Status:  {$invoice.status}</h3></td>\r\n                        <td><h3 class=\"align-right\">Due: {$invoice.duedate|dateformat:$date_format}</h3></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                            {foreach from=$invoiceitems item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description} {if $item.qty}{$item.qty} x {/if}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$invoice.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n       \r\n       <p>\r\n           <b>Payment method:</b> {$invoice.gateway}<br>\r\n           <b><a href=\"{$invoices_url}\">Browse all invoices</a></b>\r\n       </p>             \r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nINVOICE:                {$invoice.id}\r\nGENERATED AT: {$invoice.date|dateformat:$date_format} \r\nDUE DATE:           {$invoice.duedate|dateformat:$date_format}.\r\n\r\nPAYMENT METHOD \r\n{$invoice.gateway}\r\n\r\n\r\nAmount Due: {$invoice.total|price:$currency}\r\n\r\nLINK TO PAY\r\n{$invoices_url}', 1, 2, 1, 0, 0, 1),
(60, 'Account:Created:VPS', 'Product', 'Client', 1, 'New Hosting Account Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<p>Your order has been accepted and your VPS Server has been set-up.</p>\r\n\r\n<h2>New Account Information</h2>\r\n<p>\r\n   <b>Package:</b> {$service.product_name}<br>\r\n   <b>Hostname:</b> {$service.domain}<br>\r\n   <b>First Payment Amount:</b> {$service.firstpayment|price:$currency}<br>\r\n   <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n   <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n   <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n\r\n<h2>Login Details</h2>\r\n<p>\r\n   <b>Username:</b> {$service.username}<br>\r\n   <b>Password:</b> {$service.password}<br>\r\n   <b>RootPassword:</b> {$service.rootpassword}<br>\r\n\r\n{if $service.ip}<b>Main IP:</b> {$service.ip}<br>{/if}\r\n{if $service.additional_ip!=\"\"}<b>Additional IPs:</b> {$service.additional_ip}<br>{/if}\r\n{if $service.disk_limit!=\"0\"}<b>Disk Limit:</b> {$service.disk_limit} GB<br>{/if}\r\n{if $service.bw_limit!=\"0\"}<b>Bandwidth Limit:</b> {$service.bw_limit} MB<br>{/if}\r\n{if $service.guaranteed_ram!=\"0\"}<b>Memory:</b> {$service.guaranteed_ram} MB<br>{/if}\r\n{if $service.os!=\"\"}<b>OS:</b> {$service.os}<br>{/if}\r\n</p>\r\n\r\n', 'Dear {$client.firstname} {$client.lastname},\r\nYour order has been accepted and your VPS Server has been set-up.\r\n\r\n# New Account Information\r\n\r\n   Package: {$service.product_name}\r\n\r\n   Hostname: {$service.domain}\r\n\r\n   First Payment Amount: {$service.firstpayment|price:$currency}\r\n\r\n   Total Amount: {$service.total|price:$currency}\r\n\r\n   Billing Cycle: {$service.billingcycle}\r\n\r\n   Next Due Date: {$service.next_due|dateformat:$date_format}\r\n\r\n\r\n\r\n# Login Details\r\n\r\n   Username: {$service.username}\r\n\r\n   Password: {$service.password}\r\n\r\n   RootPassword: {$service.rootpassword}\r\n\r\n{if $service.ip}  Main IP: {$service.ip}\r\n{/if}\r\n{if $service.additional_ip!=\"\"}Additional IPs: {$service.additional_ip}\r\n{/if}\r\n{if $service.disk_limit!=\"0\"}Disk Limit: {$service.disk_limit} GB\r\n{/if}\r\n{if $service.bw_limit!=\"0\"}Bandwidth Limit: {$service.bw_limit} MB\r\n{/if}\r\n{if $service.guaranteed_ram!=\"0\"}Memory: {$service.guaranteed_ram} MB\r\n{/if}\r\n{if $service.os!=\"\"}OS: {$service.os}\r\n{/if}\r\n\r\n', 1, 2, 1, 0, 0, 2),
(61, 'Domain:Manual Change NS', 'Domain', 'Admin', 1, 'Domain: {$domain.name} Change Nameservers', '<h1>Domain name: {$domain.name}</h1>\r\n<br/>\r\n{foreach from=$ns item=n key=k}<br/>\r\n# nameserver {$k+1}: {$n}<br/>\r\n<br/>\r\n{/foreach}<br/>', '# Domain Name: {$domain.name}\r\n\r\n{foreach from=$ns item=n key=k}\r\n# Nameserver {$k+1}: {$n} \r\n\r\n{/foreach} ', 1, 2, 1, 1, 0, 1),
(63, 'Account:Created:InterWorx', 'Product', 'Client', 1, 'New Hosting Account Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Your order has been accepted and your hosting account has been set-up.</p>\r\n\r\n<h2>New Account Information</h2>\r\n<p>\r\n   <b>Package:</b> {$service.product_name}<br>\r\n   <b>Hostname:</b> {$service.domain}<br>\r\n   <b>First Payment Amount:</b> {$service.firstpayment|price:$currency}<br>\r\n   <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n   <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n   <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n\r\n<h2>Login Details</h2>\r\n<p>\r\n    <b>Username:</b> {$service.username}<br>\r\n    <b>Password:</b> {$service.password}<br>\r\n    <b>Domain:</b> {$service.domain}<br><br>\r\n\r\n    <b>Control Panel URL:</b> https://{$server.ip}:2443/siteworx/\r\n</p>\r\n\r\n<h2>Server Information</h2>\r\n<p>\r\n    <b>Server Name:</b> {$server.name}<br>\r\n    <b>Server IP:</b> {$server.ip}<br><br>\r\n    \r\n    If you are using an existing domain with your new hosting account, you will need to update the nameservers to point to the nameservers listed below.\r\n    \r\n    <b>Nameserver 1:</b> {$server.ns1} ({$server.ip1})<br>\r\n    <b>Nameserver 2:</b> {$server.ns2} ({$server.ip2})<br>{if $service_ns3}\r\n    <b>Nameserver 3:</b> {$server.ns3} ({$server.ip3})<br>{/if}{if $service_ns4}\r\n    <b>Nameserver 4:</b> {$server.ns4} ({$server.ip4})<br>{/if}\r\n</p>\r\n\r\n<h2>Uploading Your Website</h2>\r\n<p>\r\n    Once your domain has propagated you may use the details below:\r\n    <br><br>\r\n    <b>FTP Hostname:</b> www.{$service.domain}<br>\r\n    <b>Webpage URL:</b> http://www.{$service.domain}<br>\r\n</p>\r\n\r\n<h2>Email Settings</h2>\r\n<p>\r\n    For email accounts that you setup, you should use the following connection details in your email program:\r\n    <br><br>\r\n    <b>POP3 Host Address:</b> mail.{$service.domain}<br>\r\n    <b>SMTP Host Address:</b> mail.{$service.domain}<br>\r\n    <b>Username:</b> The email address you are checking email for<br>\r\n    <b>Password:</b> As specified in your control panel<br>\r\n</p>', 'Dear {$client.firstname} {$client.lastname}.\r\nYour order has been accepted and your hosting account has been activated.\r\n\r\n# New Account Information\r\nHosting Package: {$service.product_name}\r\nDomain: {$service.domain}\r\nFirst Payment Amount: {$service.firstpayment|price:$currency}\r\nTotal Amount: {$service.total|price:$currency}\r\nBilling Cycle: {$service.billingcycle}\r\nNext Due Date: {$service.next_due|dateformat:$date_format}\r\n\r\n# Login Details\r\n\r\nUsername: {$service.username}\r\n\r\nEmail Address: {$client.email}\r\nPassword: {$service.password}\r\nDomain: {$service.domain}\r\n\r\nControl Panel URL: https://{$server.ip}:2443/siteworx/\r\n\r\n# Server Information\r\n\r\nServer Name: {$server.name}\r\nServer IP: {$server.ip}\r\n{if $server.host}Server Hostname: {$server.host}\r\n{/if}\r\nIf you are using an existing domain with your new hosting account, you will need to update the nameservers to point to the nameservers listed below.\r\n\r\nNameserver 1: {$server.ns1} ({$server.ip1})\r\nNameserver 2: {$server.ns2} ({$server.ip2})\r\n{if $service_ns3}Nameserver 3: {$server.ns3} ({$server.ip3})\r\n{/if}{if $service_ns4}Nameserver 4: {$server.ns4} ({$server.ip4})\r\n{/if}\r\n', 1, 2, 1, 0, 0, 2),
(64, 'Account:Password Reset', 'Product', 'Admin', 1, 'Account #{$service.id} Password Reset', '<h1>Account password changed</h1>\r\n\r\n<p>\r\n    <b>Account: </b> {$service.id}<br>\r\n    <b>Client: </b>  {$client.firstname} {$client.lastname}<br>\r\n    <br>\r\n    <b>Server Name:</b>  {$server.name}<br>\r\n    <b>Product:</b>  {$service.name}<br>\r\n    <b>Username:</b>  {$service.username}<br>\r\n    <b>Password:</b>  *HIDDEN*<br>\r\n</p>\r\n\r\n\r\n<p>\r\n    Changed by:<br>\r\n    <b>IP:</b> {$ip}<br>\r\n    <b>Host:</b> {$host} <br>\r\n</p>\r\n', 'Password for account has been changed.\r\n\r\n# Client: {$client.firstname} {$client.lastname}\r\n# Order ID:  {$service.order_id}\r\n\r\n# Server Name: {$server.name}\r\n# Product: {$service.name}\r\n# Username: {$service.username}\r\n# Password:*HIDDEN*\r\n\r\n#IP: {$ip}\r\n#Host: {$host}', 1, 2, 1, 0, 0, 1),
(65, 'ChargeFailed:CreditCard', 'General', 'Client', 1, 'Credit Card Charge Failed', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\n    This is notification that <b>we were <span style=\"color:red\">unable</span> to automatically charge your credit card ({$details.cardnum}).</b>\r\n</p>\r\n<p>\r\n    Please verify credit card details in our client section.\r\n</p>', 'Dear {$details.firstname} {$details.lastname},\r\n\r\n\r\nThis is notification that we were unable to automatically charge your credit card ({$details.cardnum}).\r\nPlease verify credit card details in our client section.', 1, 2, 1, 0, 0, 1),
(66, 'Account:Password Reset', 'Product', 'Client', 1, 'Service Password Reset', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>You requested to reset the password for the service {$service.name}.</p>\r\n\r\n<h2>New access details:</h2\r\n<p>\r\n    <b>Username:</b> {$service.username}\r\n    <b>Password:</b> {$newpassword}\r\n</p>', 'Dear  {$client.firstname} {$client.lastname},\r\n\r\nYou requested to reset the password for the service {$service.name} .\r\n\r\n# This is your new details:\r\nUsername: {$service.username}\r\nPassword: {$newpassword}', 1, 2, 1, 0, 0, 1),
(67, 'Account:Created:Dedicated', 'Product', 'Client', 1, 'New Dedicated server set-up', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<p>Your order has been accepted and your Dedicated Server has been set-up.</p>\r\n\r\n<h2>New Account Information</h2>\r\n<p>\r\n   <b>Package:</b> {$service.product_name}<br>\r\n   <b>Hostname:</b> {$service.domain}<br>\r\n   <b>First Payment Amount:</b> {$service.firstpayment|price:$currency}<br>\r\n   <b>Total Amount:</b> {$service.total|price:$currency}<br>\r\n   <b>Billing Cycle:</b> {$service.billingcycle}<br>\r\n   <b>Next Due Date:</b> {$service.next_due|dateformat:$date_format}<br>\r\n</p>\r\n\r\n\r\n<h2>Login Details</h2>\r\n<p>\r\n   <b>Username:</b> {$service.username}<br>\r\n   <b>Password:</b> {$service.password}<br>\r\n   <b>RootPassword:</b> {$service.rootpassword}<br>\r\n\r\n{if $service.ip}<b>Main IP:</b> {$service.ip}<br>{/if}\r\n{if $service.additional_ip!=\"\"}<b>Additional IPs:</b> {$service.additional_ip}<br>{/if}\r\n{if $service.disk_limit!=\"0\"}<b>Disk Limit:</b> {$service.disk_limit} GB<br>{/if}\r\n{if $service.bw_limit!=\"0\"}<b>Bandwidth Limit:</b> {$service.bw_limit} MB<br>{/if}\r\n{if $service.guaranteed_ram!=\"0\"}<b>Memory:</b> {$service.guaranteed_ram} MB<br>{/if}\r\n{if $service.os!=\"\"}<b>OS:</b> {$service.os}<br>{/if}\r\n</p>\r\n\r\n', 'Dear {$client.firstname} {$client.lastname},\r\nYour order has been accepted and your Dedicated Server has been set-up.\r\n\r\n# New Account Information\r\n\r\n   Package: {$service.product_name}\r\n\r\n   Hostname: {$service.domain}\r\n\r\n   First Payment Amount: {$service.firstpayment|price:$currency}\r\n\r\n   Total Amount: {$service.total|price:$currency}\r\n\r\n   Billing Cycle: {$service.billingcycle}\r\n\r\n   Next Due Date: {$service.next_due|dateformat:$date_format}\r\n\r\n\r\n\r\n# Login Details\r\n\r\n   Username: {$service.username}\r\n\r\n   Password: {$service.password}\r\n\r\n   RootPassword: {$service.rootpassword}\r\n\r\n{if $service.ip}  Main IP: {$service.ip}\r\n{/if}\r\n{if $service.additional_ip!=\"\"}Additional IPs: {$service.additional_ip}\r\n{/if}\r\n{if $service.disk_limit!=\"0\"}Disk Limit: {$service.disk_limit} GB\r\n{/if}\r\n{if $service.bw_limit!=\"0\"}Bandwidth Limit: {$service.bw_limit} MB\r\n{/if}\r\n{if $service.guaranteed_ram!=\"0\"}Memory: {$service.guaranteed_ram} MB\r\n{/if}\r\n{if $service.os!=\"\"}OS: {$service.os}\r\n{/if}\r\n\r\n', 1, 2, 1, 0, 0, 2),
(69, 'Affiliate Monthly Report', 'General', 'Client', 1, 'Affiliate Monthly Report', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n\r\n<p>This is your monthly affiliate referrals report. \r\nYou can view your affiliate statistics by logging in to the client area.</p>\r\n\r\n<p>\r\n    <b>Total Visitors:</b> {$affiliate.visits}<br>\r\n    <b>Current Balance:</b> {$affiliate.balance|price:$affiliate.currency_id}<br>\r\n    <b>Amount Withdrawn:</b> {$affiliate.total_withdrawn|price:$affiliate.currency_id}<br>\r\n</p>\r\n\r\n{if $affiliate.orders}\r\n<h2>New Signups this Month referred by you:</h2>\r\n\r\n{foreach from=$affiliate.orders item=order}\r\n<p>\r\n    {if $order.acstatus}<b>Account:</b> {$order.pname}<br>{/if}\r\n    {if $order.domstatus}<b>Domain:</b> {$order.domain}<br>{/if}\r\n    <b>Order Total:</b> {$order.total|price:$affiliate.currency_id} <br>\r\n    {if $moredetails}\r\n        {if $order.firstname || $order.lastname || $order.companyname}\r\n            Client Info: {if $order.companyname}{$order.companyname}<br>\r\n        {else}\r\n            {$order.firstname}{$order.lastname}{$order.companyname}<br>\r\n        {/if}\r\n    {/if}\r\n        {if $order.inv_id}Invoice ID: #{if $proforma && ($order.inv_status==\'Paid\' || $order.inv_status==\'Refunded\') && $order.inv_paid!=\'\'}{$order.inv_paid}\r\n        <br>\r\n        {else}\r\n            {$order.inv_date|invprefix:$prefix:$order.client_id}{$order.inv_id}\r\n        <br>{/if}\r\n        Invoice Date: {$order.inv_date|dateformat:$date_format}<br>\r\n        Invoice Due Date: {$order.inv_due|dateformat:$date_format}<br>\r\n        Invoice Total: {$order.inv_total|price:$order.currency_id} <br>\r\n    {/if}{/if}\r\n    <b>Commission:</b> {$order.commission|price:$affiliate.currency_id}\r\n</p>\r\n{/foreach}\r\n{else}\r\n<p><b>No new signups referred this month.</b></p>\r\n{/if}\r\n<p>Remember: You can refer new customers using your unique affiliate link: {$affiliate.url}</p>\r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\n\r\nThis is your monthly affiliate referrals report. You can view your affiliate statistics by logging in to the client area.\r\n\r\nTotal Visitors : {$affiliate.visits}\r\nCurrent Balance: {$affiliate.balance|price:$affiliate.currency_id}\r\nAmount Withdrawn: {$affiliate.total_withdrawn|price:$affiliate.currency_id}\r\n\r\n{if $affiliate.orders}\r\n# New Signups this Month referred by you:\r\n--\r\n{foreach from=$affiliate.orders item=order}\r\n{if $order.acstatus}Account: {$order.pname}\r\n{/if}{if $order.domstatus}Domain: {$order.domain}\r\n{/if}\r\nOrder Total: {$order.total|price:$affiliate.currency_id} \r\n{if $moredetails}\r\n{if $order.firstname || $order.lastname || $order.companyname}Client Info: {if $order.companyname}{$order.companyname}\r\n{else}{$order.firstname}{$order.lastname}{$order.companyname}\r\n{/if}\r\n{/if}\r\n{if $order.inv_id}Invoice ID: #{if $proforma && ($order.inv_status==\'Paid\' || $order.inv_status==\'Refunded\') && $order.inv_paid!=\'\'}{$order.inv_paid}\r\n{else}{$order.inv_date|invprefix:$prefix:$order.client_id}{$order.inv_id}\r\n{/if}\r\nInvoice Date: {$order.inv_date|dateformat:$date_format}\r\nInvoice Due Date: {$order.inv_due|dateformat:$date_format}\r\nInvoice Total: {$order.inv_total|price:$order.currency_id} \r\n{/if}{/if}\r\nCommission: {$order.commission|price:$affiliate.currency_id}\r\n--\r\n{/foreach}\r\n{/if}\r\nYou can refer new customers using your unique affiliate link: {$affiliate.url}\r\n', 1, 2, 1, 0, 0, 1),
(70, 'Details:Password Reset', 'General', 'Admin', 1, 'Admin Password Reset', '<h1>Hi {$firstname} {$lastname},</h1>\r\n\r\n\r\n<p>\r\nYou have requested and confirmed password reset in Admin Area. Your new details:<br><br>\r\n    <b>Username:</b> {$username}<br>\r\n    <b>Password:</b> {$newpassword}<br>\r\n</p>\r\n\r\n<h3>Request info</h3>\r\n<p>\r\n    <b>Date:</b>  {$date}<br>\r\n    <b>IP:</b>  {$ip}<br>\r\n    <b>Host:  {$host}<br>\r\n</p>\r\n', 'Dear  {$firstname} {$lastname},\r\n\r\n You have requested password reset in Admin Area. Your new details:\r\n #Username: {$username}\r\n #Password: {$newpassword}\r\n\r\n ----------------------------------------------------\r\n Date: {$date}\r\n IP: {$ip}\r\n Host: {$host}\r\n ----------------------------------------------------', 1, 2, 1, 1, 0, 2),
(71, 'Details:Password Request', 'General', 'Client', 1, 'Password Reset for {$system_url}', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\nYou requested that you be reminded of your Client Area Login Details.\r\n</p>\r\n\r\n<p>Please click the link below to reset your password:</p>\r\n\r\n<table class=\"body-action\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td align=\"center\">\r\n                          <div>\r\n                            <!--[if mso]><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"{$hash}\" style=\"height:45px;v-text-anchor:middle;width:200px;\" arcsize=\"7%\" stroke=\"f\" fill=\"t\">\r\n                            <v:fill type=\"tile\" color=\"#22BC66\" />\r\n                            <w:anchorlock/>\r\n                            <center style=\"color:#ffffff;font-family:sans-serif;font-size:15px;\">Reset password</center>\r\n                          </v:roundrect><![endif]-->\r\n                            <a href=\"{$hash}\" class=\"button button--green\">Reset password</a>\r\n                          </div>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n                    \r\n                    <table class=\"body-sub\">\r\n                      <tbody><tr>\r\n                        <td>\r\n                          <p class=\"sub\">If you’re having trouble clicking the Reset password button, copy and paste the URL below into your web browser.\r\n                          </p>\r\n                          <p class=\"sub\"><a href=\"{$hash}\">{$hash}</a></p>\r\n                        </td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                    \r\n                    \r\n ', 'Dear  {$client.firstname} {$client.lastname},\r\n\r\nYou requested that you be reminded of your Client Area Login Details.\r\nPlease click the link below to reset your password:\r\n {$hash}\r\n ', 1, 2, 1, 0, 0, 2),
(72, 'Details:Password Request', 'General', 'Admin', 1, 'Admin Area new password', '<h1>Hi {$firstname} {$lastname},</h1>\r\n\r\n\r\n<p>\r\n    There was an password reset attempt for your login in HostBill Admin.<br>\r\n    If this was not placed by you please investigate!<br>\r\n    <b>Request date:</b> {$date}<br>\r\n    <b>Request IP:</b> {$ip}<br>\r\n    <b>Request Host:</b> {$host}<br>\r\n    <br>\r\n    To <b>reset password</b>, please use link below:\r\n</p>\r\n\r\n\r\n\r\n<table class=\"body-action\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td align=\"center\">\r\n                          <div>\r\n                            <!--[if mso]><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"{$hash}\" style=\"height:45px;v-text-anchor:middle;width:200px;\" arcsize=\"7%\" stroke=\"f\" fill=\"t\">\r\n                            <v:fill type=\"tile\" color=\"#22BC66\" />\r\n                            <w:anchorlock/>\r\n                            <center style=\"color:#ffffff;font-family:sans-serif;font-size:15px;\">Reset password</center>\r\n                          </v:roundrect><![endif]-->\r\n                            <a href=\"{$hash}\" class=\"button button--green\">Reset password</a>\r\n                          </div>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n                    \r\n                    <table class=\"body-sub\">\r\n                      <tbody><tr>\r\n                        <td>\r\n                          <p class=\"sub\">If you’re having trouble clicking the Reset password button, copy and paste the URL below into your web browser.\r\n                          </p>\r\n                          <p class=\"sub\"><a href=\"{$hash}\">{$hash}</a></p>\r\n                        </td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                    ', 'Dear  {$firstname} {$lastname},\r\n\r\n You have requested password reset in Admin Area.\r\n Please click the link below to reset your password:\r\n {$hash}\r\n\r\n\r\n ----------------------------------------------------\r\n Date: {$date}\r\n IP: {$ip}\r\n Host: {$host}\r\n ----------------------------------------------------', 1, 2, 1, 1, 0, 2),
(73, 'Estimate', 'General', 'Client', 1, 'Requested Estimate', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\n     Attached is estimate you\'ve requested. You can view this estimate online following link below:\r\n     \r\n</p>\r\n\r\n<table class=\"body-action\" align=\"center\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td align=\"center\">\r\n                          <div>\r\n                            <!--[if mso]><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"{$estimate_link} \" style=\"height:45px;v-text-anchor:middle;width:200px;\" arcsize=\"7%\" stroke=\"f\" fill=\"t\">\r\n                            <v:fill type=\"tile\" color=\"#22BC66\" />\r\n                            <w:anchorlock/>\r\n                            <center style=\"color:#ffffff;font-family:sans-serif;font-size:15px;\">View estimate</center>\r\n                          </v:roundrect><![endif]-->\r\n                            <a href=\"{$estimate_link} \" class=\"button button--green\">View estimate</a>\r\n                          </div>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n                    \r\n                    <table class=\"body-sub\">\r\n                      <tbody><tr>\r\n                        <td>\r\n                          <p class=\"sub\">If you’re having trouble clicking th button above, copy and paste the URL below into your web browser.\r\n                          </p>\r\n                          <p class=\"sub\"><a href=\"{$estimate_link} \">{$estimate_link} </a></p>\r\n                        </td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                    \r\n     <p>\r\n         \r\n {if $estimate.date_expires!=\'0000-00-00\'}<b>This estimate is valid until {$estimate.date_expires|dateformat:$date_format}</b><br>{/if}\r\n Contact us if you have any questions\r\n     </p>               \r\n', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\n Attached is estimate you\'ve requested. You can view this estimate online following this link: {$estimate_link} \r\n\r\n {if $estimate.date_expires!=\'0000-00-00\'}Estimate is valid until {$estimate.date_expires|dateformat:$date_format}{/if}. \r\n \r\n Contact us if you have any questions', 1, 2, 1, 0, 0, 1),
(74, 'Domain:Automation Results', 'Domain', 'Admin', 1, 'Domain {$domain.name}:Automation Results', '<h1><b>Action</b>: {$domain_action}</h1>\r\n<b>Result</b>: {if $domain_result}Success{else}Fail{/if}<br/>\r\n<br/>\r\n{if $domain_error}Error: {$domain_error}{/if}<br/>\r\n<br/>\r\n<h2>\r\n# client: {$client.firstname} {$client.lastname}<br/>\r\n# order id:  {$domain.order_id}<br/>\r\n# order number: {$domain.order_num}<br/>\r\n<br/>\r\n\r\n# domain name: {$domain.name}<br/>\r\n# period: {$domain.period} year/s<br/>\r\n# registrar: {$domain.module}<br/>', 'Action: {$domain_action}\r\nResult: {if $domain_result}Success{else}FAIL{/if}\r\n\r\n{if $domain_error}Error: {$domain_error}{/if}\r\n\r\n----------------------------------------------------\r\n# Client: {$client.firstname} {$client.lastname}\r\n# Order ID:  {$domain.order_id}\r\n# Order Number: {$domain.order_num}\r\n\r\n\r\n# Domain Name: {$domain.name}\r\n# Period: {$domain.period} Year/s\r\n# Registrar: {$domain.module}', 1, 2, 1, 1, 0, 1),
(75, 'Account:Created:CakeMail', 'Product', 'Client', 1, 'New Email Marketing Account Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Your order has been accepted and your email marketing account has been activated!</p>\r\n\r\n<h2>Login Details</h2>\r\n<p>\r\n    <b>Username:</b> {$client.email}  <br>\r\n    <b>Password:</b> {$service.password}  <br>\r\n    <b>Login URL:</b> http://{$server.host} <br>\r\n</p>\r\n\r\n<h2>New Account Information</h2>\r\n<p>\r\n    Marketing Package: {$service.product_name} <br>\r\n    First Payment Amount: {$service.firstpayment|price:$currency} <br>\r\n    Total Amount: {$service.total|price:$currency} <br>\r\n    Billing Cycle: {$service.billingcycle} <br>\r\n    Next Due Date: {$service.next_due|dateformat:$date_format}\r\n</p>\r\n\r\n', 'Dear {$client.firstname} {$client.lastname}.\r\nYour order has been accepted and your email marketing account has been activated.\r\n\r\nNew Account Information\r\nMarketing Package: {$service.product_name} \r\nFirst Payment Amount: {$service.firstpayment|price:$currency}\r\nTotal Amount: {$service.total|price:$currency}\r\nBilling Cycle: {$service.billingcycle}\r\nNext Due Date: {$service.next_due|dateformat:$date_format}\r\n\r\nLogin Details\r\nUsername: {$client.email} \r\nPassword: {$service.password} \r\nLogin URL: http://{$server.host}', 1, 2, 1, 0, 0, 2),
(76, 'Ticket:By Admin', 'Support', 'Client', 1, 'Ticket: New', '<h1><b>Subject</b>: {$ticket.subject}</h1>\r\n<p>{$ticket.body}</p>\r\n<br/>\r\n\r\n<b>Ticket url</b>: <a href=\"{$ticket_url}\">{$ticket_url}</a><br/>', 'Subject: {$ticket.subject}\r\n {$ticket.body}\r\n\r\n\r\nTicket URL: {$ticket_url}', 1, 2, 1, 0, 0, 1),
(77, 'Ticket:Closed', 'Support', 'Admin', 1, 'Client closed ticket #{$ticket.ticket_number} ', '<b>Ticket id</b>: {$ticket.ticket_number}<br/>\r\n<b>Subject</b>: {$ticket.subject}<br/>\r\n<b>Status</b>: {$ticket.status}<br/>\r\n<b>Url</b>: <a href=\"{$ticket_admin_url}\">{$ticket_admin_url}</a><br/>\r\n<b>Available actions</b>:<br/>\r\n- Re-Open ticket: <a href=\"{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&status=Open&make=setstatus\">{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&status=Open&make=setstatus</a><br/>\r\n- Delete ticket: <a href=\"{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&make=deleteticket\">{$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&make=deleteticket</a><br/>\r\n', '----------------------------------------------\r\nTicket ID: {$ticket.ticket_number}\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nURL: {$ticket_admin_url}\r\nAvailable actions:\r\n- Re-Open ticket: {$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&status=Open&make=setstatus\r\n- Delete Ticket: {$admin_url}?cmd=tickets&action=menubutton&id={$ticket.ticket_number}&make=deleteticket\r\n----------------------------------------------', 1, 2, 1, 0, 0, 1),
(78, 'Ticket:Notes Change', 'Support', 'Admin', 1, 'Notes for ticket: #{$ticket.ticket_number}  updated', '<h1>Notes has just been updated for ticket #{$ticket.ticket_number}</h1>\r\n<br/>\r\n{if $notes}<br/>\r\n<hr/>\r\n{foreach from=$notes item=entry}<br/>\r\n{$entry.date|dateformat:$date_format}<br/>\r\n{$entry.name}:  {$entry.note}<br/>\r\n{/foreach}<br/>\r\n<hr/>\r\n{/if}<br/>\r\n<br/>\r\n\r\n<b>New note</b>:<br/>\r\n<hr/>\r\n{$note.date|dateformat:$date_format}<br/>\r\n{$note.name}:  {$note.msg}<br/>\r\n<br/>\r\n<b>Url</b>: {$ticket.url}<br/>', 'Notes has just been updated for ticket #{$ticket.ticket_number}\r\n\r\n{if $notes}\r\n{foreach from=$notes item=entry}\r\n----------------------------------------------------------------\r\n{$entry.date|dateformat:$date_format}\r\n{$entry.name}:  {$entry.note}\r\n{/foreach}\r\n----------------------------------------------------------------\r\n{/if}\r\n\r\n\r\nNew note:\r\n----------------------------------------------------------------\r\n{$note.date|dateformat:$date_format}\r\n{$note.name}:  {$note.msg}\r\n\r\nURL: {$ticket.url}', 1, 2, 1, 0, 0, 1),
(80, 'Clients:Add Contact', 'General', 'Admin', 1, 'Client #{$client.id} added new contact to his profile', '<h3>Client #{$client.id} {$client.firstname} {$client.lastname} added new contact to his profile:</h3>\r\n\r\n<p>\r\n    <b> First Name</b> {$new.firstname}<br>\r\n    <b> Last Name</b> {$new.lastname}<br>\r\n    <b> Email Address</b> {$new.email}<br>\r\n    <b> Address 1</b> {$new.address1}<br>\r\n    <b> Address 2</b> {$new.address2}<br>\r\n    <b> City</b> {$new.city}<br>\r\n    <b> State/Region</b> {$new.state}<br>\r\n    <b> Zip Code</b> {$new.postcode}<br>\r\n    <b> Country</b> {$new.country}<br>\r\n    <b> Phone Number</b> {$new.phonenumber}<br>\r\n</p>', 'Client #{$client.id} {$client.firstname} {$client.lastname} added new contact to his profile:\r\n\r\n# First Name: {$new.firstname}\r\n# Last Name: {$new.lastname}\r\n# Email Address: {$new.email}\r\n# Address 1: {$new.address1}\r\n# Address 2: {$new.address2}\r\n# City: {$new.city}\r\n# State/Region: {$new.state}\r\n# Zip Code: {$new.postcode}\r\n# Country: {$new.country}\r\n# Phone Number: {$new.phonenumber}', 1, 2, 1, 0, 0, 1),
(81, 'Details:Admin Login Notification', 'General', 'Admin', 1, 'Login from {$ip}', '<h2>Admin: \'{$login}\' logged into HostBill</h2>\r\n\r\n<p>\r\n    <b>Date:</b> {$date} <br>\r\n    <b>IP:</b> {$ip}  <br>\r\n    <b>Host:</b> {$host}   \r\n</p>\r\n', 'Admin: \'{$login}\' was logged into HostBill\r\n----------------------------------------------------\r\nDate: {$date} \r\nIP: {$ip} Host: {$host} \r\n----------------------------------------------------', 1, 2, 1, 1, 0, 1),
(83, 'Invoice:Refund', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Refund', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\n    Transaction <b>#{$transaction.trans_id}</b> has just been refunded, amount refunded <b>{$amount|price:$currency}</b>\r\n</p>\r\n\r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nTransaction #{$transaction.trans_id} has been refunded, amount refunded {$amount}\r\n', 1, 2, 1, 0, 0, 1),
(84, 'Mobile:Account:Created', 'Mobile', 'Client', 1, 'Your service is ready', 'Dear client, your order has been accepted and your service {$service.product_name} is active', 'Dear client, Your order has been accepted and your service {$service.product_name} is active', 1, 1, 1, 0, 0, 1),
(85, 'Mobile:Domain:Registered', 'Mobile', 'Client', 1, 'Your domain has been registered', 'Dear client, your domain: {$domain.name} has been registered', 'Dear client, Your domain: {$domain.name} has been registered', 1, 1, 1, 0, 0, 1),
(86, 'Mobile:Domain:Transfered', 'Mobile', 'Client', 1, 'Your domain has been transfered', 'Dear client, your domain: {$domain.name} has been transfered', 'Dear client, Your domain: {$domain.name} has been transfered', 1, 1, 1, 0, 0, 1),
(87, 'Mobile:Domain:Reminder', 'Mobile', 'Client', 1, 'Your domain will soon expire', 'Dear client, your domain: {$domain.name} will soon expire - make sure to renew!', 'Dear client, Your domain: {$domain.name} will soon expire - make sure to renew!', 1, 1, 1, 0, 0, 1),
(88, 'Mobile:Invoice:New', 'Mobile', 'Client', 1, 'New invoice', 'Dear client, New invoice has been added to your account with us, proceed to our client area for details', 'Dear client, New invoice has been added to your account with us, proceed to our client area for details', 1, 1, 1, 0, 0, 1),
(89, 'Mobile:Invoice:Reminder', 'Mobile', 'Client', 1, 'Due invoice', 'Dear client, Invoice in your account is due, to avoid downtimes pay it in time', 'Dear client, Invoice in your account is due, to avoid downtimes pay it in time', 1, 1, 1, 0, 0, 1),
(90, 'Mobile:Ticket:Reply', 'Mobile', 'Client', 1, 'Reply to ticket', 'Dear client, staff member replied to your support ticket -  {$ticket.subject}', 'Dear client, staff member replied to your support ticket -  {$ticket.subject}', 1, 1, 1, 0, 0, 1),
(91, 'Mobile:Ticket:New', 'Mobile', 'Admin', 1, 'New Support Ticket', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0, 0, 1),
(92, 'Mobile:Ticket:Escalated', 'Mobile', 'Admin', 1, 'Support Ticket Escalated', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0, 0, 1),
(93, 'Mobile:Ticket:Reply', 'Mobile', 'Admin', 1, 'Client repiled to ticket', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0, 0, 1),
(94, 'Mobile:Ticket:Note', 'Mobile', 'Admin', 1, 'New ticket note', '#{$ticket.ticket_number} \r\n Note: {$note.msg}', '#{$ticket.ticket_number} \r\n Note: {$note.msg}', 1, 1, 1, 0, 0, 1),
(95, 'Mobile:Failed Login', 'Mobile', 'Admin', 1, 'Adminarea failed login', 'Failed Login: Date: {$date}\r\nIP: {$ip}\r\nHost: {$host}\r\n\r\nLogin: {$login}', 'Failed Login: Date: {$date}\r\nIP: {$ip}\r\nHost: {$host}\r\n\r\nLogin: {$login}', 1, 1, 1, 0, 0, 1),
(96, 'Mobile:Order:New', 'Mobile', 'Admin', 1, 'New HostBill Order', 'Client: {$client.firstname} {$client.lastname}\r\nTotal(+tax): {$order.total|price:$currency}', 'Client: {$client.firstname} {$client.lastname}\r\nTotal(+tax): {$order.total|price:$currency}', 1, 1, 1, 0, 0, 1),
(97, 'Mobile:Transaction:New', 'Mobile', 'Admin', 1, 'New Payment from client', 'Transaction total: {$transaction.in|price:$currency}, Invoice: {$transaction.invoice_id}', 'Transaction total: {$transaction.in|price:$currency}, Invoice: {$transaction.invoice_id}', 1, 1, 1, 0, 0, 1),
(98, 'Mobile:AccountAutomation:Failed', 'Mobile', 'Admin', 1, 'Account automation failed', 'Action: {$account_action}, {if $account_error}Errors:{foreach from=$account_error item=errx} {$errx}    {/foreach}{/if}Account ID: {$service.id} ', 'Action: {$account_action}, {if $account_error}Errors:{foreach from=$account_error item=errx} {$errx}    {/foreach}{/if}Account ID: {$service.id} ', 1, 1, 1, 0, 0, 1),
(99, 'Mobile:DomainAutomation:Failed', 'Mobile', 'Admin', 1, 'Domain automation failed', 'Action:  {$domain_action} FAILED, {if $domain_error}Error: {$domain_error}{/if}, Domain Name: {$domain.name}', 'Action:  {$domain_action} FAILED, {if $domain_error}Error: {$domain_error}{/if}, Domain Name: {$domain.name}', 1, 1, 1, 0, 0, 1);
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`) VALUES
(100, 'Ticket:Assigned', 'Support', 'Admin', 1, 'You have been assigned to ticket: #{$ticket.ticket_number}', '<h1><b>Staff member</b>: {$admin.firstname} {$admin.lastname} assigned you to ticket #{$ticket.ticket_number}</h1>\r\n<br/>\r\n<hr/>\r\n<p>{$ticket.body}</p>\r\n<hr/>\r\n<b>Subject</b>: {$ticket.subject}<br/>\r\n<b>Status</b>: {$ticket.status}<br/>\r\n<b>Submitter</b>: {$ticket.name}<br/>\r\n<b>Url</b>: <a href=\"{$ticket_admin_url}\">{$ticket_admin_url}</a><br/>', 'Staff member: {$admin.firstname} {$admin.lastname} assigned you to ticket #{$ticket.ticket_number}\r\n\r\n------------------------------------------\r\n\r\n{$ticket.body}\r\n\r\n------------------------------------------\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nSubmitter: {$ticket.name}\r\nURL: {$ticket_admin_url}\r\n----------------------------------------------', 1, 2, 1, 0, 0, 1),
(101, 'Ticket:Escalated', 'Support', 'Admin', 1, 'Ticket: #{$ticket.ticket_number} has been escalated', '<h1><b>This ticket is now</b>: {if $overdue}Overdue{else}Escalated{/if}</h1>\r\n<br/>\r\nTicket #{$ticket.ticket_number}<br/>\r\n<b>Subject</b>: {$ticket.subject}<br/>\r\n<b>Status</b>: {$ticket.status}<br/>\r\n<b>Submitter</b>: {$ticket.name}<br/>\r\n<b>Url</b>: <a href=\"{$ticket_admin_url}\">{$ticket_admin_url}</a><br/>\r\n', 'This ticket is now: {if $overdue}OVERDUE{else}ESCALATED{/if}\r\n\r\nTicket #{$ticket.ticket_number}\r\nSubject: {$ticket.subject}\r\nStatus: {$ticket.status}\r\nSubmitter: {$ticket.name}\r\nURL: {$ticket_admin_url}\r\n----------------------------------------------', 1, 2, 1, 0, 0, 1),
(102, 'Ticket:TimeLimit', 'Support', 'Client', 1, 'Your Ticket was not opened', '<h1>{$email_name},</h1>\r\n<br/>\r\nYour email to our support system could not be accepted as ticket, you have to wait {$time_left} second(s) before sending next request.<br/>', '{$email_name},\r\n\r\nYour email to our support system could not be accepted as ticket, you have to wait {$time_left} second(s) before sending next request.', 1, 2, 1, 0, 0, 1),
(103, 'LiveChat:Chat transcription', 'Support', 'Client', 1, 'Chat session transcription - {$chat.start_date|dateformat:$date_format}', '<h1>Hello {$client.visitor_name},</h1>\r\n<br/>\r\nYou can find requested chat session transcription bellow.<br/>\r\n<br/>\r\n{foreach from=$chat.messages item=line}<br/>\r\n{if $line.type==\"Staff\"}<br/>\r\n<br/>\r\n#{$line.submitter_name}:<br/>\r\n{elseif $line.type==\"Client\"}<br/>\r\n<br/>\r\n#{$line.submitter_name}:<br/>\r\n{else}-{/if}{$line.message}<br/>\r\n{/foreach}<br/>', 'Hello {$client.visitor_name},\r\n\r\nYou can find requested chat session transcription bellow.\r\n\r\n{foreach from=$chat.messages item=line}\r\n{if $line.type==\"Staff\"}\r\n\r\n#{$line.submitter_name}:\r\n{elseif $line.type==\"Client\"}\r\n\r\n#{$line.submitter_name}:\r\n{else}-{/if}{$line.message}\r\n{/foreach}', 1, 2, 1, 0, 0, 1),
(104, 'Ticket:BounceClose', 'Support', 'Client', 1, 'Your ticket is closed', '<h1>{$email_name},</h1>\r\n<br/>\r\nYour email to our support system could not be accepted as ticket reply because related ticket has already been closed by staff member. if required, please open new ticket.<br/>', '{$email_name},\r\n\r\nYour email to our support system could not be accepted as ticket reply because related ticket has already been closed by staff member. If required, please open new ticket.', 1, 2, 1, 0, 0, 1),
(105, 'Mobile:Ticket:Closed', 'Mobile', 'Admin', 1, 'Support Ticket Closed', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 'Subject: {$ticket.subject}\r\n Submitter: {$ticket.name} \r\n Dept: {$ticket.department}', 1, 1, 1, 0, 0, 1),
(106, 'Notes:Change', 'General', 'Admin', 1, 'Notes for {$type}: #{$id} updated', '<h1>Notes for {$type}: #{$id} updated</h1>\r\n\r\n<p>\r\n    <b>URL:</b> {$url}\r\n</p>\r\n\r\n{if $note}\r\n    <h2>{if $note.action==\'add\'}New note:{else}Updated note:{/if}</h2>\r\n    <p>\r\n        <small>{$note.date|dateformat:$date_format}</small>\r\n        {$note.note}\r\n    </p>\r\n{/if}\r\n\r\n{if $notes}\r\n    {foreach from=$notes item=entry}\r\n    <p>\r\n        <small>{$entry.date|dateformat:$date_format}</small><br>\r\n        {$entry.note}\r\n    </p>\r\n    {/foreach}\r\n\r\n{/if}\r\n', 'Note has just been updated for {$type} #{$id}\r\n\r\n{if $notes}\r\n{foreach from=$notes item=entry}\r\n----------------------------------------------------------------\r\n{$entry.date|dateformat:$date_format}\r\n{$entry.note}\r\n{/foreach}\r\n----------------------------------------------------------------\r\n{/if}\r\n\r\n{if $note}\r\n{if $note.action==\'add\'}New note:{else}Updated note:{/if}\r\n----------------------------------------------------------------\r\n{$note.date|dateformat:$date_format}\r\n{$note.note}\r\n{/if}\r\nURL: {$url}', 1, 2, 1, 0, 0, 1),
(107, 'Invoice:Final', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id} generated', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\n    This is notification that VAT invoice has been issued to your recent payment.<br/>\r\n    <br>\r\n    <b>Related Invoice:</b>  #{$invoice.id} <br>\r\n    <b>All invoices</b> <a href=\"{$clientarea_url}\">{$clientarea_url}</a>\r\n</p>', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\nFinal invoice has been generated to your recent payment\r\n\r\nINVOICE  #{$invoice.id} \r\n\r\n\r\n\r\n\r\n\r\nINVOICE HISTORY: {$clientarea_url}\r\n', 1, 2, 1, 0, 0, 1),
(108, 'CreditNote:New', 'Invoice', 'Client', 1, 'New Credit Note Created', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>This is confirmation that new credit note has just been created</p>\r\n\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td>\r\n                          <h3>Credit Note #{$invoice.id}</h3></td>\r\n                        <td>\r\n                          <h3 class=\"align-right\">{$invoice.total|price:$currency}</h3></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                            {foreach from=$invoiceitems item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description} {if $item.qty}{$item.qty} x {/if}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$invoice.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n                    \r\n                    \r\n\r\n\r\n', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\nCredit Note  #{$invoice.id} \r\nAMOUNT: {$invoice.total|price:$currency}\r\nGENERATED ON: {$invoice.date|dateformat:$date_format}.\r\n\r\nItems\r\n{foreach from=$invoiceitems item=item}\r\n {$item.description}  {if $item.qty}{$item.qty} x {/if}{$item.amount|price:$currency}\r\n{/foreach}\r\n\r\n', 1, 2, 1, 0, 0, 1),
(109, 'New Incoming Transaction', 'General', 'Admin', 1, 'Admin: New Incoming Transaction', '<h1>New transaction added!</h1>\r\n\r\n<p>\r\n    <b>Customer:</b> {$client.firstname} {$client.lastname}<br>\r\n    <b>Gateway:</b> {$transaction.gateway}<br>\r\n    <b>Amount:</b> {$transaction.in|price:$currency}<br>\r\n    <b>Transaction id:</b> {$transaction.trans_id}<br>\r\n</p>\r\n\r\n\r\n{if $transaction.invoice_id}\r\n<p>\r\n    <b>Related invoice id:</b> {$transaction.invoice_id}<br>\r\n    <b>Related invoice status:</b> {$invoice.status}<br>\r\n    </p>\r\n{/if}', 'New transaction just came in!\r\n\r\nCustomer: {$client.firstname} {$client.lastname}\r\nGateway: {$transaction.gateway}\r\nAmount: {$transaction.in|price:$currency}\r\nTransaction id: {$transaction.trans_id}\r\n\r\n{if $transaction.invoice_id}\r\nRelated invoice id: {$transaction.invoice_id}\r\nRelated invoice status: {$invoice.status}\r\n{/if}', 1, 2, 1, 0, 0, 1),
(110, 'Admin:Order Ownership Changed', 'General', 'Admin', 1, 'Admin:Order Ownership Changed', '\r\n<h1>Order ownership changed: {$order.id}</h1>\r\n\r\n<p>\r\n    Ownership for Order ID: {$order.id} has been  \r\n    {if $order.staff_member_id}changed to <b>{$order.admin_firstname} {$order.admin_lastname}</b>{else}<b>removed</b>{/if}\r\n</p>\r\n<h2>Order Info</h2>\r\n<p>\r\n    <b>Order ID:</b> {$order.id}<br>\r\n    <b>Order Number:</b> {$order.number}<br>\r\n    <b>Date Created:</b> {$order.date_created|dateformat:$date_format}<br>\r\n    <b>Invoice Number:</b> {$order.invoice_id}<br>\r\n    <b>Payment Method:</b> {$order.module}<br>\r\n    {if $order.fraudscore}<b>FraudModule risk score:</b> {$order.fraudscore}<br>{/if}\r\n    <b>IP:</b> {$ip_addr}<br>\r\n    <b>Host:</b> {$host_addr}<br>\r\n\r\n</p>\r\n\r\n\r\n<h2>Order Items</h2>\r\n{if $order_details}\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      \r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                           {foreach from=$order_details item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total (+tax):</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$order.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n{else}\r\n    <p>No items to list.</p>\r\n{/if}\r\n   \r\n   \r\n<h2>Client Info</h2>\r\n<p>\r\n    <b>ID:</b> {$client.id} <br>\r\n    <b>Name:</b> {$client.firstname} {$client.lastname} <br>\r\n    <b>Email:</b> {$client.email} <br>\r\n    <b>Company:</b> {$client.companyname} <br>\r\n    <b>Address 1:</b> {$client.address1} <br>\r\n    <b>Address 2:</b> {$client.address2} <br>\r\n    <b>City:</b> {$client.city} <br>\r\n    <b>State/Region:</b> {$client.state} <br>\r\n    <b>Zip Code:</b> {$client.postcode} <br>\r\n    <b>Country:</b> {$client.country} <br>\r\n    <b>Phone Number:</b> {$client.phonenumber} \r\n</p>\r\n', 'Ownership for Order ID: {$order.id} has been  {if $order.staff_member_id}changed to {$order.admin_firstname} {$order.admin_lastname}{else}removed{/if}\r\n\r\n---------------------------------------------------------------\r\nOrder Info\r\n---------------------------------------------------------------\r\n# Order ID: {$order.id}\r\n# Order Number: {$order.number}\r\n# Date Created: {$order.date_created|dateformat:$date_format}\r\n# Invoice Number: {$order.invoice_id}\r\n# Payment Method: {$order.module}\r\n{if $order.fraudscore}# FraudModule risk score: {$order.fraudscore}{/if}\r\n\r\n---------------------------------------------------------------\r\nClient Info\r\n---------------------------------------------------------------\r\n# ID: {$client.id}\r\n# Name: {$client.firstname} {$client.lastname}\r\n# Email: {$client.email}\r\n# Company: {$client.companyname}\r\n# Address 1: {$client.address1}\r\n# Address 2: {$client.address2}\r\n# City: {$client.city}\r\n# State/Region: {$client.state}\r\n# Zip Code: {$client.postcode}\r\n# Country: {$client.country}\r\n# Phone Number: {$client.phonenumber}\r\n\r\n---------------------------------------------------------------\r\nOrder Items\r\n---------------------------------------------------------------\r\n{if $order_details}\r\n{foreach from=$order_details item=item}\r\n #  {$item.amount|price:$currency} - {$item.description}\r\n{/foreach}\r\n\r\nTotal(+tax): {$order.total|price:$currency}\r\n{else}\r\nNo items to list.\r\n{/if}\r\n\r\n\r\n---------------------------------------------------------------\r\nIP: {$ip_addr}\r\nHost: {$host_addr}', 1, 2, 1, 0, 0, 1),
(111, 'Admin:Assigned Order Ownership', 'General', 'Admin', 1, 'Admin:Assigned Order Ownership', '<h1>You were assigned to Order ID: {$order.id}</h1>\r\n\r\n<h2>Order Info</h2>\r\n<p>\r\n    <b>Order ID:</b> {$order.id}<br>\r\n    <b>Order Number:</b> {$order.number}<br>\r\n    <b>Date Created:</b> {$order.date_created|dateformat:$date_format}<br>\r\n    <b>Invoice Number:</b> {$order.invoice_id}<br>\r\n    <b>Payment Method:</b> {$order.module}<br>\r\n    {if $order.fraudscore}<b>FraudModule risk score:</b> {$order.fraudscore}<br>{/if}\r\n    <b>IP:</b> {$ip_addr}<br>\r\n    <b>Host:</b> {$host_addr}<br>\r\n\r\n</p>\r\n\r\n\r\n<h2>Order Items</h2>\r\n{if $order_details}\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      \r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                           {foreach from=$order_details item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total (+tax):</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$order.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n{else}\r\n    <p>No items to list.</p>\r\n{/if}\r\n   \r\n   \r\n<h2>Client Info</h2>\r\n<p>\r\n    <b>ID:</b> {$client.id} <br>\r\n    <b>Name:</b> {$client.firstname} {$client.lastname} <br>\r\n    <b>Email:</b> {$client.email} <br>\r\n    <b>Company:</b> {$client.companyname} <br>\r\n    <b>Address 1:</b> {$client.address1} <br>\r\n    <b>Address 2:</b> {$client.address2} <br>\r\n    <b>City:</b> {$client.city} <br>\r\n    <b>State/Region:</b> {$client.state} <br>\r\n    <b>Zip Code:</b> {$client.postcode} <br>\r\n    <b>Country:</b> {$client.country} <br>\r\n    <b>Phone Number:</b> {$client.phonenumber} \r\n</p>\r\n', 'You were assigned to Order ID: {$order.id}\r\n\r\n---------------------------------------------------------------\r\nOrder Info\r\n---------------------------------------------------------------\r\n# Order ID: {$order.id}\r\n# Order Number: {$order.number}\r\n# Date Created: {$order.date_created|dateformat:$date_format}\r\n# Invoice Number: {$order.invoice_id}\r\n# Payment Method: {$order.module}\r\n{if $order.fraudscore}# FraudModule risk score: {$order.fraudscore}{/if}\r\n\r\n---------------------------------------------------------------\r\nClient Info\r\n---------------------------------------------------------------\r\n# ID: {$client.id}\r\n# Name: {$client.firstname} {$client.lastname}\r\n# Email: {$client.email}\r\n# Company: {$client.companyname}\r\n# Address 1: {$client.address1}\r\n# Address 2: {$client.address2}\r\n# City: {$client.city}\r\n# State/Region: {$client.state}\r\n# Zip Code: {$client.postcode}\r\n# Country: {$client.country}\r\n# Phone Number: {$client.phonenumber}\r\n\r\n---------------------------------------------------------------\r\nOrder Items\r\n---------------------------------------------------------------\r\n{if $order_details}\r\n{foreach from=$order_details item=item}\r\n #  {$item.amount|price:$currency} - {$item.description}\r\n{/foreach}\r\n\r\nTotal(+tax): {$order.total|price:$currency}\r\n{else}\r\nNo items to list.\r\n{/if}\r\n\r\n\r\n---------------------------------------------------------------\r\nIP: {$ip_addr}\r\nHost: {$host_addr}', 1, 2, 1, 0, 0, 1),
(112, 'ChargeFailed:ACH', 'General', 'Client', 1, 'Account/eCheck Charge Failed', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\n    This is notification that <b>we were <span style=\"color:red\">unable</span> to automatically charge your bank account ({$details.account}).</b>\r\n</p>\r\n<p>\r\n    Please verify bank details in our client section.\r\n</p>', 'Dear {$details.firstname} {$details.lastname},\r\n\r\n\r\nThis is notification that we were unable to automatically charge your bank account ({$details.account}).\r\nPlease verify bank details in our client section.', 1, 2, 1, 0, 0, 1),
(113, 'Order:FraudOrder', 'General', 'Client', 1, 'Your recent order #{$order.number} marked as Fraud', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Unfortunatelly our system has automatically classified your recent order as <b style=\"color:red\">Fraudulent</b></p>\r\n\r\n<p>Please contact us at your earliest convenience to resolve this case, please submit order number below for reference:<br>\r\n<b>ORDER NUMBER:</b> {$order.number}\r\n</p>', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\nUnfortunatelly your recent order was automatically marked as Fraud.\r\nPlease contact us to resolve this case.\r\n\r\nORDER NUMBER: {$order.number}\r\n\r\n\r\n ', 1, 2, 1, 0, 0, 1),
(114, 'Ticket:BouncePublic', 'Support', 'Client', 1, 'Your reply was not accepted', '<p>\r\nYour email to our support system could not be accepted as reply, because ticket you are sending it to is public / announcement ticket.<br/>\r\nTo reply please open new support ticket in our client portal<br/><br/>\r\n</p>', 'Your email to our support system could not be accepted as reply, because ticket you are sending it to is public / announcement ticket.\r\nTo reply please open new support ticket in our client portal', 1, 2, 1, 0, 0, 1),
(115, 'Account:Cancellation Request', 'General', 'Client', 1, 'Cancellation Request', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>This email is a confirmation that we have received your cancelation request</p>\r\n<p>If it was submitted by accident, make sure to contact with us as soon as possible to prevent service interruption</p>\r\n\r\n<p>\r\n    <b>Account ID:</b> {$details.acc_id}<br>\r\n    <b>Cancelation Type:</b> {$details.type}<br>\r\n    <b>Reason:</b> {$details.reason}\r\n</p>', 'Dear: {$client.firstname} {$client.lastname} \r\n\r\n# We have received following cancelation request: \r\n\r\n# Account ID: {$details.acc_id}\r\n# Type: {$details.type}\r\n# Reason: {$details.reason}', 1, 2, 1, 0, 0, 1),
(116, 'Clients:Password Forgotten', 'General', 'Admin', 1, 'Client #{$client.id} requested password reminder', '<h3>Client #{$client.id} {$client.firstname} {$client.lastname} Just requested his password reminder</h3>\r\n\r\n IP: {$ip_addr} \r\n Host: {$host_addr}', 'Client #{$client.id} {$client.firstname} {$client.lastname} Client #{$client.id} {$client.firstname} {$client.lastname} Just requested his password reminder \r\n\r\n IP: {$ip_addr} \r\n Host: {$host_addr}', 1, 2, 1, 0, 0, 1),
(117, 'ChargeFailed:Other', 'General', 'Client', 1, 'Charge Failed', 'Dear {$client.firstname} {$client.lastname},\r\n\r\n\r\nThis is notification that we were unable to automatically collect payment for invoice {$invoice|@invoice}\r\nPlease verify your payment details in our client section.', '', 1, 1, 1, 0, 0, 1),
(118, 'Account:ChangeOwner:OldOwner', 'General', 'Client', 1, 'Ownership change', 'Dear: {$oldclient.firstname} {$oldclient.lastname} \r\n\r\n{if $domain}{$domain.name}{else}{$service.domain}{/if} was pushed from your account {$oldclient.email} to new owner {$client.email}:\r\n\r\nThis push was completed on {$curdate|dateformat:$date_format}. Please keep this email for your records.\r\n', '', 1, 1, 1, 0, 0, 1),
(119, 'Account:ChangeOwner:NewOwner', 'General', 'Client', 1, 'Ownership change', 'Dear: {$client.firstname} {$client.lastname} \r\n\r\n{if $domain}{$domain.name}{else}{$service.domain}{/if} was pushed from account {$oldclient.email} to your account {$client.email}:\r\n\r\nThis push was completed on {$curdate|dateformat:$date_format}. Please keep this email for your records.\r\n', '', 1, 1, 1, 0, 0, 1),
(120, 'Details:Login', 'General', 'Client', 1, 'New login to billing portal', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nWith this e-mail we would like to welcome back to your  billing account!\n\n------------------------------------------------------------------\nLogin information:\n\nLogin ID: {$client.email}\nIP Address: {$session.ip_address},\nBrowser type: {$session.browser.name},\nOperating system/platform: {$session.browser.platform},\nFull User-Agent: {$session.browser.userAgent}', '', 0, 1, 1, 0, 0, 1),
(121, 'Mobile:Chat:Pending', 'Mobile', 'Admin', 1, 'New Pending Chat', 'Subject: {$chat.subject}\r\nSubmitter: {$chat.visitor_name} ', 'Subject: {$chat.subject}\r\nSubmitter: {$chat.visitor_name} ', 1, 1, 1, 0, 0, 1),
(122, 'Clients:Credit Added', 'General', 'Admin', 1, 'Client #{$client.id} Added Credit', '<h1>Client #{$client.id} - {$client.firstname} {$client.lastname} just added credit to his profile</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Credit before</b> {$credit.old_credit|price:$currency}<br>\r\n    <b>Credit added</b> {$credit.total|price:$currency}<br>\r\n    <b>Credit after</b> {$credit.new_credit|price:$currency}<br>\r\n</p>\r\n', 'Client #{$client.id} - {$client.firstname} {$client.lastname} just added credit to his profile\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Credit before: {$credit.old_credit|price:$currency}\r\n# Credit added: {$credit.credit|price:$currency}\r\n# Credit after: {$credit.new_credit|price:$currency}\r\n', 1, 2, 1, 1, 0, 1),
(123, 'Invoice:Chargeback', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Chargeback', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>\r\n    We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n    Related invoice: {$invoice.id} will be marked as Unpaid.\r\n</p>\r\n\r\n<p>\r\n    Please note: Leaving invoice in Unpaid state may result in related service suspension!\r\n</p>\r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\n We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n Related invoice: {$invoice.id} will be marked as Unpaid.\r\n\r\n Please note: Leaving invoice in Unpaid state may result in related service suspension!', 1, 2, 1, 0, 0, 1),
(124, 'Invoice:Chargeback', 'Invoice', 'Admin', 1, 'Invoice #{$invoice.id}: Chargeback', '<h1>Client: #{$client.id} {$client.firstname} {$client.lastname} - chargeback notice</h1>\r\n\r\n<p>\r\n    We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n    Related invoice: {$invoice.id} will be marked as Unpaid.\r\n</p>\r\n\r\n<p>\r\n    Please note: Leaving invoice in Unpaid state may result in related service suspension!\r\n</p>\r\n', 'Dear {$client.firstname} {$client.lastname},\r\n\r\n We\'ve just received chargeback for transaction <b>#{$refunded_transaction.trans_id}</b><br>\r\n Related invoice: {$invoice.id} will be marked as Unpaid.\r\n\r\n Please note: Leaving invoice in Unpaid state may result in related service suspension!', 1, 2, 1, 0, 0, 1),
(125, 'Details:Delete', 'General', 'Client', 1, 'Account delete request', 'Dear {$client.firstname} {$client.lastname},<br />\r\n<br />\r\nAs per your request we deactivated and marked your account for deletion.<br />\r\n{if $delay}<br />\r\nYour account will be permanently deleted after {$delay} days. If you change your mind before that time please contact us to reactivate it.<br />\r\n{/if}', '', 1, 1, 1, 0, 0, 1),
(126, 'Mobile:Ticket:New', 'Mobile', 'Client', 1, 'New Support Ticket', 'Dear client, thank you for your request, we will be in touch shortly.', '', 1, 1, 1, 0, 0, 1),
(127, 'Account:ChangeOwner:Request', 'General', 'Client', 1, 'Ownership change', 'Dear {$client.firstname} {$client.lastname} <br><br>{if $domain}Domain {$domain.name}{else}Account #{$service.id} - {$service.product_name} ({$service.domain}){/if} was sent to your account on {$curdate|dateformat:$date_format}<br><br><a style=\"color:blue;\" href=\"{$system_url}?cmd=clientarea&action=transfers\">Approve</a><br><br><a style=\"color:red;\" href=\"{$system_url}?cmd=clientarea&action=transfers\">Reject</a>', 'Dear {$client.firstname} {$client.lastname}, {if $domain}Domain {$domain.name}{else}Account #{$service.id} - {$service.product_name} ({$service.domain}){/if} was sent to your account on {$curdate|dateformat:$date_format}.\r\n\r\n Click on the next link to approve or reject \r\n\r\n {$system_url}?cmd=clientarea&action=transfers', 1, 2, 1, 0, 0, 1),
(128, 'Account:ChangeOwner:OldOwnerReject', 'General', 'Client', 1, 'Ownership change', 'Dear {$client.firstname} {$client.lastname} <br><br>{$transfer.new_client_email} rejected transfer of {if $domain}domain {$domain.name}{else}service #{$service.id} - {$service.product_name} ({$service.domain}){/if} to his account\r\n', 'Dear {$client.firstname} {$client.lastname}, \r\n\r\n {$transfer.new_client_email} rejected transfer of {if $domain}domain {$domain.name}{else}service #{$service.id} - {$service.product_name} ({$service.domain}){/if} to his account\r\n\r\n', 1, 2, 1, 0, 0, 1),
(129, 'Domain:EppCode', 'Domain', 'Client', 1, 'AuthInfo / EPP Code request for domain: {$domain.name}', 'Hello {$client.firstname} {$client.lastname},\r\n\r\nOn {$now|dateformat:$date_format} from computer with IP address: {$ip_address} epp code was requested using our system for one of your domains: {$domain.name}. You can find it below:\r\n\r\nDomain: {$domain.name}\r\nEPP code: {$domain.epp_code}', '', 1, 1, 1, 0, 0, 1),
(130, 'Order:Accept', 'General', 'Client', 1, 'New Order #{$order.number}', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>Thank you for your recent order!</p>\r\n<p>To complete the order you must accept the contracts. Use the link below to accept the contracts.</p>\r\n\r\n<a href=\"{$accept_contract_link}\" target=\"_blank\">{$accept_contract_link}</a>\r\n\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tr>\r\n                        <td><h2>Order  #{$order.number}</h2></td>\r\n                        <td></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                           {foreach from=$order_details item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$order.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n       \r\n<p>\r\n    We will activate your order as soon as possible after acceptance of the contract and accounting payment (if applies) for this order.\r\n</p>             \r\n\r\n\r\n ', 'DEAR {$client.firstname} {$client.lastname},\r\n\r\nThank you for your recent order!\r\nTo complete the order you must accept the contracts. Use the link below to accept the contract.\r\n\r\n{$accept_contract_link}\r\n\r\nORDER NUMBER: {$order.number}\r\n\r\n{foreach from=$order_details item=item}\r\n {$item.description} {$item.amount|price:$currency}\r\n{/foreach}\r\n\r\nWe will activate your order as soon as possible after acceptance of the contract and accounting payment (if applies) for this order.\r\n ', 1, 2, 1, 0, 0, 1),
(131, 'Invoice:Cancelled', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Cancelled', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br />\r\n<p>Your invoice #{$invoice.id} has been cancelled.</p>\r\n<br />\r\n<p><b>All invoices</b>: <a href=\"{$clientarea_url}\">{$clientarea_url}</a></p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYour invoice #{$invoice.id} has been cancelled.\r\nAll invoices: {$clientarea_url}', 1, 2, 1, 0, 0, 1),
(132, 'Order:Pending Review', 'General', 'Admin', 1, 'Order #{$order.id} is pending review', '<h1>Pending review: Order #{$order.id}</h1>\r\n\r\n<h2>Order Info</h2>\r\n<p>\r\n    <b>Order ID:</b> {$order.id}<br>\r\n    <b>Order Number:</b> {$order.number}<br>\r\n    <b>Date Created:</b> {$order.date_created|dateformat:$date_format}<br>\r\n    <b>Invoice Number:</b> {$order.invoice_id}<br>\r\n    <b>Payment Method:</b> {$order.module}<br>\r\n    {if $order.fraudscore}<b>FraudModule risk score:</b> {$order.fraudscore}<br>{/if}\r\n    <b>IP:</b> {$ip_addr}<br>\r\n    <b>Host:</b> {$host_addr}<br>\r\n\r\n</p>\r\n\r\n\r\n<h2>Order Items</h2>\r\n{if $order_details}\r\n<table class=\"invoice-wrapper\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      \r\n                      <tr>\r\n                        <td colspan=\"2\">\r\n                          <table class=\"invoice-table\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tr>\r\n                              <th>\r\n                                <p>Description</p>\r\n                              </th>\r\n                              <th>\r\n                                <p class=\"align-right\">Amount</p>\r\n                              </th>\r\n                            </tr>\r\n                           {foreach from=$order_details item=item}\r\n                            <tr>\r\n                              <td width=\"80%\">{$item.description}</td>\r\n                              <td class=\"align-right\" width=\"20%\">{$item.amount|price:$currency}</td>\r\n                            </tr>\r\n                            {/foreach}\r\n                            <tr>\r\n                              <td width=\"80%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p class=\"total-cell_label\">Total (+tax):</p>\r\n                              </td>\r\n                              <td width=\"20%\" class=\"total-cell\" valign=\"middle\">\r\n                                <p>{$order.total|price:$currency}</p>\r\n                              </td>\r\n                            </tr>\r\n                          </table>\r\n                        </td>\r\n                      </tr>\r\n                    </table>\r\n{else}\r\n    <p>No items to list.</p>\r\n{/if}\r\n   \r\n   \r\n<h2>Client Info</h2>\r\n<p>\r\n    <b>ID:</b> {$client.id} <br>\r\n    <b>Name:</b> {$client.firstname} {$client.lastname} <br>\r\n    <b>Email:</b> {$client.email} <br>\r\n    <b>Company:</b> {$client.companyname} <br>\r\n    <b>Address 1:</b> {$client.address1} <br>\r\n    <b>Address 2:</b> {$client.address2} <br>\r\n    <b>City:</b> {$client.city} <br>\r\n    <b>State/Region:</b> {$client.state} <br>\r\n    <b>Zip Code:</b> {$client.postcode} <br>\r\n    <b>Country:</b> {$client.country} <br>\r\n    <b>Phone Number:</b> {$client.phonenumber} \r\n</p>\r\n', '---------------------------------------------------------------\r\nOrder Info\r\n---------------------------------------------------------------\r\n# Order ID: {$order.id}\r\n# Order Number: {$order.number}\r\n# Date Created: {$order.date_created|dateformat:$date_format}\r\n# Invoice Number: {$order.invoice_id}\r\n# Payment Method: {$order.module}\r\n{if $order.fraudscore}# FraudModule risk score: {$order.fraudscore}{/if}\r\n\r\n---------------------------------------------------------------\r\nClient Info\r\n---------------------------------------------------------------\r\n# ID: {$client.id}\r\n# Name: {$client.firstname} {$client.lastname}\r\n# Email: {$client.email}\r\n# Company: {$client.companyname}\r\n# Address 1: {$client.address1}\r\n# Address 2: {$client.address2}\r\n# City: {$client.city}\r\n# State/Region: {$client.state}\r\n# Zip Code: {$client.postcode}\r\n# Country: {$client.country}\r\n# Phone Number: {$client.phonenumber}\r\n\r\n---------------------------------------------------------------\r\nOrder Items\r\n---------------------------------------------------------------\r\n{if $order_details}\r\n{foreach from=$order_details item=item}\r\n #  {$item.amount|price:$currency} - {$item.description}\r\n{/foreach}\r\n\r\nTotal(+tax): {$order.total|price:$currency}\r\n{else}\r\nNo items to list.\r\n{/if}\r\n\r\n\r\n---------------------------------------------------------------\r\nIP: {$ip_addr}\r\nHost: {$host_addr}', 1, 2, 1, 0, 0, 1),
(133, 'Mobile:Invoice:Paid', 'Mobile', 'Client', 1, 'Invoice Paid', 'Dear client, Your invoice #{$invoice.id} is now paid - thank you!', 'Dear client, Your invoice #{$invoice.id} is now paid - thank you!', 0, 1, 1, 0, 0, 1),
(134, 'Domain:BulkExpires', 'Domain', 'Client', 1, 'Your domains will expire soon', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\n{$domains_count} domain(s) are about to expire in your account with us:<br>\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name}, expires in {$domain.left}{if $domain.left < 2} day{else} days{/if} (on {$domain.expires|dateformat:$date_format}) - autorenew: {if $domain.autorenew}on{else}off{/if}<br>\r\n{/foreach}\r\n<br>\r\nLogin to our client portal to manage auto-renewal options or renew your domain(s) sooner', 'Dear {$client.firstname} {$client.lastname}\r\n\r\n{$domains_count} domain(s) are about to expire in your account with us:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name}, expires in {$domain.left}{if $domain.left < 2} day{else} days{/if} (on {$domain.expires|dateformat:$date_format}) - autorenew: {if $domain.autorenew}on{else}off{/if}\r\n\r\n{/foreach}\r\n\r\nLogin to our client portal to manage auto-renewal options or renew your domain(s) sooner', 1, 2, 1, 0, 0, 1),
(135, 'Domain:Registered:Bulk', 'Domain', 'Client', 1, 'Domains have been registered', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\n{$domains_count} domain(s) has been registered:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}<br>\r\n{/foreach}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\n{$domains_count} domain(s) has been registered:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}\r\n{/foreach}', 1, 2, 1, 0, 0, 1),
(136, 'Domain:Transferred:Bulk', 'Domain', 'Client', 1, 'Domains for which the transfer was initiated', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\nTransfer has been initiated for {$domains_count} domain(s):\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}<br>\r\n{/foreach}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\nTransfer has been initiated for {$domains_count} domain(s):\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - registration period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}\r\n{/foreach}', 1, 2, 1, 0, 0, 1),
(137, 'Domain:Renewed:Bulk', 'Domain', 'Client', 1, 'Domains have been renewed', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\n{$domains_count} domain(s) has been renewed:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - renewal period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}<br>\r\n{/foreach}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\n{$domains_count} domain(s) has been renewed:\r\n{foreach from=$domains item=domain}\r\n- #{$domain.id} {$domain.name} - renewal period: {$domain.period} year/s - next due date: {$domain.next_due|dateformat:$date_format} - amount: {$domain.firstpayment|price:$currency}\r\n{/foreach}', 1, 2, 1, 0, 0, 1),
(138, 'Domain:Register:Failed', 'Domain', 'Client', 1, 'Domain {$domain.name}: Registration failed', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\nAn error occurred while registering the domain {$domain.name}.\r\n\r\n{if $domain.error}Error: \"{$domain.error}\"{/if}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\nAn error occurred while registering the domain {$domain.name}.\r\n\r\n{if $domain.error}Error: \"{$domain.error}\"{/if}', 1, 2, 1, 0, 0, 1),
(139, 'Domain:Transfer:Failed', 'Domain', 'Client', 1, 'Domain {$domain.name}: Transfer failed', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\nAn error occurred while transferring the domain {$domain.name}.\r\n\r\n{if $domain.error}Error: \"{$domain.error}\"{/if}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\nAn error occurred while transferring the domain {$domain.name}.\r\n\r\n{if $domain.error}Error: \"{$domain.error}\"{/if}', 1, 2, 1, 0, 0, 1),
(140, 'Domain:Renew:Failed', 'Domain', 'Client', 1, 'Domain {$domain.name}: Renewal failed', '<h3>Dear {$client.firstname} {$client.lastname}</h3>\r\n\r\nAn error occurred while renewing domain {$domain.name}.\r\n\r\n{if $domain.error}Error: \"{$domain.error}\"{/if}', 'Dear {$client.firstname} {$client.lastname}\r\n\r\nAn error occurred while renewing domain {$domain.name}.\r\n\r\n{if $domain.error}Error: \"{$domain.error}\"{/if}', 1, 2, 1, 0, 0, 1),
(141, 'Invoice:Collections', 'Invoice', 'Client', 1, 'Invoice #{$invoice.id}: Moved to Collections', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n<br />\r\n<p>Your invoice #{$invoice.id} has been moved to Collections.</p>\r\n<br />\r\n<p><b>All invoices</b>: <a href=\"{$clientarea_url}\">{$clientarea_url}</a></p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYour invoice #{$invoice.id} has been moved to Collections.\r\nAll invoices: {$clientarea_url}', 1, 2, 1, 0, 0, 1),
(142, 'Invoice:Collections', 'Invoice', 'Admin', 1, 'Invoice #{$invoice.id}: Moved to Collections', '<h1>Invoice #{$invoice.id} has been moved to Collections.</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Invoice ID:</b> {$invoice.id}<br>\r\n    <b>Invoice URL:</b> {$invoice_url}<br>\r\n</p>\r\n', 'Invoice #{$invoice.id} has been moved to Collections.\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Invoice ID: {$invoice.id}\r\n# Invoice URL: {$invoice_url}\r\n', 1, 2, 1, 0, 0, 1),
(143, 'Reports:Auto-export', 'General', 'Admin', 1, 'Report Snapshot: #{$snapshot.name}: auto-export has been created', '<h1>Report Snapshot: #{$snapshot.name}: auto-export has been created</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Related report:</b> {$report.name}<br>\r\n    <b>Related snapshot:</b> {$snapshot.name}<br>\r\n    <b>Auto-export created at:</b> {$snapshot_data.created_at}<br>\r\n</p>\r\n', 'Report Snapshot: #{$snapshot.name}: auto-export has been created\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Related report: {$report.name}\r\n# Related snapshot: {$snapshot.name}\r\n# Auto-export created at: {$snapshot_data.created_at}', 1, 2, 1, 0, 0, 1),
(144, 'Account:Reminder', 'Product', 'Client', 1, 'The next due date is coming', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nService: {if !empty($service.domain)}{$service.domain}{else}#{$service.id}{/if} - Next due date {$account.next_due|dateformat:$date_format}.\r\n\r\nPay for the service:\r\n{$clientarea_url}', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nService: {if !empty($service.domain)}{$service.domain}{else}#{$service.id}{/if} - Next due date {$account.next_due|dateformat:$date_format}.\r\n\r\nPay for the service:\r\n{$clientarea_url}', 1, 2, 1, 0, 0, 1),
(145, 'Domain:Cancellation Request', 'General', 'Admin', 1, 'Domain #{$details.domain_id} Cancellation Request', '<h1>New cancellation request</h1>\r\n\r\n\r\n<p>\r\n    <b>Client ID:</b> {$client.id}  <br>\r\n    <b>Client Name:</b> {$client.firstname} {$client.lastname}  <br>\r\n</p>\r\n\r\n<p>\r\n    <b>Order ID:</b> {$order_id} <br>\r\n    <b>Domain ID:</b> {$details.domain_id} <br>\r\n    <b>Domain Name:</b> {$domain.name} <br>\r\n    <b>Type:</b> {$details.type} <br>\r\n    <b style=\"color:red\">Reason:</b> {$details.reason} <br> <br>\r\n</p>', 'Cancellation request has been submitted by:\r\n# Client ID: {$client.id} \r\n# Client Name: {$client.firstname} {$client.lastname} \r\n\r\n# Order ID: {$order_id}\r\n\r\n# Domain ID: {$details.domain_id}\r\n# Domain Name: {$domain.name}\r\n# Type: {$details.type}\r\n# Reason: {$details.reason}', 1, 2, 1, 0, 0, 1),
(146, 'Domain:Cancellation Request', 'General', 'Client', 1, 'Cancellation Request', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>This email is a confirmation that we have received your cancellation request</p>\r\n<p>If it was submitted by accident, make sure to contact with us as soon as possible to prevent service interruption</p>\r\n\r\n<p>\r\n    <b>Domain ID:</b> {$details.domain_id}<br>\r\n    <b>Domain Name:</b> {$domain.name}<br>\r\n    <b>Cancelation Type:</b> {$details.type}<br>\r\n    <b>Reason:</b> {$details.reason}\r\n</p>', 'Dear: {$client.firstname} {$client.lastname} \r\n\r\n# We have received following cancelation request: \r\n\r\n# Domain ID: {$details.domain_id}\r\n# Domain Name: {$domain.name}\r\n# Type: {$details.type}\r\n# Reason: {$details.reason}', 1, 2, 1, 0, 0, 1),
(147, 'Estimate:Accepted', 'Invoice', 'Admin', 1, 'Estimate #{$invoice.id}: Accepted', '<h1>Estimate #{$estimate.id} has been accepted by client</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Estimate ID:</b> {$estimate.id}<br>\r\n    <b>Estimate URL:</b> {$estimate_url}<br>\r\n    {if $estimate.invoice_id}\r\n        <b>Invoice ID:</b> {$estimate.invoice_id}<br>\r\n        <b>Invoice URL:</b> {$invoice_url}<br>\r\n    {/if}\r\n</p>', 'Estimate #{$estimate.id} has been accepted by client\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Estimate ID: {$estimate.id}\r\n# Estimate URL: {$estimate_url}\r\n{if $estimate.invoice_id}\r\n# Invoice ID: {$estimate.invoice_id}\r\n# Invoice URL: {$invoice_url}\r\n{/if}\r\n\r\n', 1, 2, 0, 0, 0, 1),
(148, 'Mobile:Invoice:Overdue', 'Mobile', 'Client', 1, 'Overdue invoice', 'Dear client, your invoice is now Overdue. To avoid service interruption, please submit payment at your earliest convenience.', '', 1, 1, 1, 0, 0, 1),
(149, 'MFA:Enabled', 'General', 'Client', 1, 'Two-factor authentication is on', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>You turned on two-factor authentication for your account. </p>\r\n<p>You can turn two-factor authentication off anytime through the security settings menu.</p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYou turned on two-factor authentication for your account. \r\nYou can turn two-factor authentication off anytime through the security settings menu.', 1, 2, 0, 0, 1, 1),
(150, 'MFA:Disabled', 'General', 'Client', 1, 'Two-factor authentication is off', '<h1>Dear {$client.firstname} {$client.lastname},</h1>\r\n\r\n<p>You turned off two-factor authentication for your account.</p>\r\n<p>You can turn two-factor authentication on anytime through the security settings menu.</p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nYou turned off two-factor authentication for your account. \r\nYou can turn two-factor authentication on anytime through the security settings menu.', 1, 2, 0, 0, 1, 1),
(151, 'MFA:Enabled', 'General', 'Admin', 1, 'Two-factor authentication is on', '<h1>Dear Staff Member,</h1>\r\n\r\n<p>You turned on two-factor authentication for your account. </p>\r\n<p>You can turn two-factor authentication off anytime through My Account settings.</p>', 'Dear Staff Member,\r\n\r\nYou turned on two-factor authentication for your account. \r\nYou can turn two-factor authentication off anytime through My Account settings.', 1, 2, 0, 0, 0, 1),
(152, 'MFA:Disabled', 'General', 'Admin', 1, 'Two-factor authentication is off', '<h1>Dear Staff Member,</h1>\r\n\r\n<p>You turned off two-factor authentication for your account.</p>\r\n<p>You can turn two-factor authentication on anytime through My Account settings.</p>', 'Dear Staff Member,\r\n\r\nYou turned off two-factor authentication for your account.\r\nYou can turn two-factor authentication on anytime through My Account settings.', 1, 2, 0, 0, 0, 1),
(153, 'Account:ChangePackage:Success', 'Product', 'Client', 1, 'Changing the package for the service', 'Dear {$client.firstname} {$client.lastname},<br>\r\n\r\n<p>Service: {if !empty($service.domain)}{$service.domain}{else}#{$service.id}{/if} - The package has been changed to {$product.name}.</p>', 'Dear {$client.firstname} {$client.lastname},\r\n\r\nService: {if !empty($service.domain)}{$service.domain}{else}#{$service.id}{/if} - The package has been changed to {$product.name}.', 1, 2, 1, 0, 0, 1),
(154, 'Account:ChangePackage:Success', 'Product', 'Admin', 1, 'The package change for the service was successful', '<h1>Account package changed</h1>\r\n\r\n<p>\r\n<b>Account: </b> {$service.id}<br>\r\n<b>Client: </b>  {$client.firstname} {$client.lastname}<br>\r\n<br>\r\n<b>Server Name:</b>  {$server.name}<br>\r\n<b>New Product:</b>  {$product.name}<br>\r\n<b>Username:</b>  {$service.username}<br>\r\n</p>', 'Account package changed\r\n\r\nAccount: {$service.id}\r\nClient: {$client.firstname} {$client.lastname}\r\n\r\nServer Name: {$server.name}\r\nNew Product: {$product.name}\r\nUsername: {$service.username}', 1, 2, 1, 0, 0, 1);
##########
INSERT INTO `hb_email_templates` (`id`, `tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`) VALUES
(155, 'Account:ChangePackage:Failed', 'Product', 'Admin', 1, 'The package change for the service has failed', '<h1>Account package change failed</h1>\r\n\r\n<p>\r\n<b>Account: </b> {$service.id}<br>\r\n<b>Client: </b>  {$client.firstname} {$client.lastname}<br>\r\n<br>\r\n<b>Server Name:</b>  {$server.name}<br>\r\n<b>New Product:</b>  {$product.name}<br>\r\n<b>Username:</b>  {$service.username}<br>\r\n<br><br>\r\n\r\n<b>Error:</b> {$error}</p>', 'Account package change failed\r\n\r\nAccount: {$service.id}\r\nClient: {$client.firstname} {$client.lastname}\r\n\r\nServer Name: {$server.name}\r\nNew Product: {$product.name}\r\nUsername: {$service.username}\r\n\r\nError: {$error}', 1, 2, 1, 0, 0, 1);
##########
CREATE TABLE `hb_enom_certs` (
  `account_id` int(11) NOT NULL,
  `cert_id` varchar(128) NOT NULL,
  `cert_oid` varchar(128) NOT NULL,
  `cert_status` varchar(128) NOT NULL DEFAULT '',
  `cert_type` varchar(32) NOT NULL DEFAULT 'Rapid',
  `cert_expires` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `csr` text NOT NULL,
  `contacts` text NOT NULL,
  `organization` text NOT NULL,
  `cert_email` text NOT NULL,
  `software` int(3) NOT NULL DEFAULT '1',
  `private_key` text,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_error_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `entry` text NOT NULL,
  `type` enum('Exception','PHP Error','Other') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_estimates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` enum('Draft','Sent','Accepted','Invoiced','Dead') NOT NULL,
  `subject` varchar(64) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date_created` date DEFAULT NULL,
  `date_expires` date DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `credit` decimal(10,2) NOT NULL,
  `tax` decimal(10,2) NOT NULL,
  `taxrate` decimal(10,2) NOT NULL,
  `tax2` decimal(10,2) NOT NULL,
  `taxrate2` decimal(10,2) NOT NULL,
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `currency_id` int(3) NOT NULL DEFAULT '0',
  `rate` decimal(10,4) NOT NULL DEFAULT '1.0000',
  `notes` text NOT NULL,
  `notes_private` text NOT NULL,
  `hash` varchar(32) NOT NULL,
  `invoice_id` int(11) DEFAULT '0',
  `options` int(5) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_estimate_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estimate_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT '0',
  `type` enum('Other','Product','Addon','Config') NOT NULL DEFAULT 'Other',
  `description` text NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `taxed` tinyint(1) NOT NULL,
  `tax_rate` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `qty` int(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `estid` (`estimate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_event_handles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(250) NOT NULL,
  `handle_type` enum('module','class') NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_event_handles` (`id`, `handle`, `handle_type`, `module_id`) VALUES
(37, 'adminwidget_dashboard_blocks', 'module', 1),
(38, 'readrss', 'module', 1),
(62, 'preupgradechecks', 'module', 2),
(63, 'getchecksum', 'module', 2),
(64, '_getcurrentversion', 'module', 2),
(65, 'before_controller', 'module', 2),
(66, 'getmynotification', 'module', 2),
(67, 'dismissmynotification', 'module', 2),
(68, 'getheaderjs', 'module', 2),
(69, 'getpatchinfo', 'module', 2),
(70, 'getplugins', 'module', 2),
(71, 'getpatches', 'module', 2),
(72, 'getlatestversion', 'module', 2),
(73, 'getexcludedplugins', 'module', 2),
(74, 'getupdateableplugins', 'module', 2),
(75, 'listpluginupdates', 'module', 2),
(76, 'getlistofpluginupdates', 'module', 2),
(77, 'getplugindetails', 'module', 2),
(78, 'performpluginupdate', 'module', 2),
(79, 'performpatch', 'module', 2),
(80, 'performupgrade', 'module', 2),
(81, 'downloadplugin', 'module', 2),
(82, 'downloadlatest', 'module', 2),
(83, 'downloadpatch', 'module', 2),
(84, 'extract', 'module', 2);
##########
CREATE TABLE `hb_file_access_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `person_type` enum('admin','client') NOT NULL,
  `person_id` int(11) NOT NULL,
  `file_type` enum('attachment','download') NOT NULL,
  `file_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `person` (`person_type`,`person_id`),
  KEY `file` (`file_type`,`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_fraud_output` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('Order','Client') NOT NULL DEFAULT 'Order',
  `rel_id` int(11) NOT NULL,
  `module` int(11) NOT NULL,
  `output` text NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `module` (`module`),
  KEY `type_rel_id` (`type`,`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_gateway_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `output` text NOT NULL,
  `result` enum('Successfull','Failure','Pending','Chargeback','Info') NOT NULL DEFAULT 'Info',
  PRIMARY KEY (`id`),
  KEY `module_id` (`module`),
  KEY `result` (`result`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_0` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_1` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_2` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_3` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_4` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_5` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_6` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_block_7` (
  `startIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `endIpNum` int(20) UNSIGNED NOT NULL DEFAULT '0',
  `locId` int(11) NOT NULL,
  KEY `locId` (`locId`),
  KEY `endIpNum` (`endIpNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_geoip_cities` (
  `locId` int(11) NOT NULL,
  `country` varchar(5) NOT NULL,
  `region` varchar(100) NOT NULL,
  `city` varchar(255) NOT NULL,
  `postalCode` varchar(100) NOT NULL,
  `latitude` varchar(100) NOT NULL,
  `longitude` varchar(100) NOT NULL,
  PRIMARY KEY (`locId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_graphs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_type` enum('Hosting','RackItem') NOT NULL DEFAULT 'Hosting',
  `rel_id` int(11) NOT NULL,
  `server_id` int(11) NOT NULL,
  `device_id` varchar(50) NOT NULL,
  `port_id` varchar(32) NOT NULL,
  `name` varchar(127) NOT NULL DEFAULT '',
  `show_client` tinyint(1) NOT NULL DEFAULT '1',
  `cache` text NOT NULL,
  `modified` datetime NOT NULL,
  `billed` tinyint(1) NOT NULL DEFAULT '1',
  `type` varchar(32) NOT NULL DEFAULT 'traffic',
  `metadata` text NOT NULL,
  `hash` varchar(32) NOT NULL DEFAULT '',
  `flags` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rel_type_rel_id_switch_id_port_id_server_id_hash` (`rel_type`,`rel_id`,`device_id`,`port_id`,`server_id`,`hash`),
  KEY `billed` (`billed`),
  KEY `switch_id_port_id_server_id` (`device_id`,`port_id`,`server_id`),
  KEY `server_id` (`server_id`),
  KEY `rel_type_rel_id` (`rel_type`,`rel_id`),
  KEY `show_client` (`show_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_infopages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(128) NOT NULL,
  `title` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `url` (`url`,`visible`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paid_id` varchar(64) NOT NULL DEFAULT '',
  `recurring_id` int(11) NOT NULL DEFAULT '0',
  `status` enum('Paid','Unpaid','Cancelled','Draft','Recurring','Refunded','Credited','Creditnote','CreditnoteDraft','Collections','Receiptunpaid','Receiptpaid','Chargeback') NOT NULL DEFAULT 'Draft',
  `client_id` int(11) NOT NULL,
  `contact_id` int(11) DEFAULT '0',
  `date` date DEFAULT NULL,
  `duedate` date DEFAULT NULL,
  `paybefore` date NOT NULL,
  `datepaid` datetime NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `credit` decimal(10,2) NOT NULL,
  `tax` decimal(10,2) NOT NULL,
  `taxrate` decimal(10,2) NOT NULL,
  `tax2` decimal(10,2) NOT NULL,
  `taxrate2` decimal(10,2) NOT NULL,
  `taxexempt` tinyint(4) NOT NULL DEFAULT '0',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `grandtotal` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payment_module` int(11) NOT NULL,
  `currency_id` int(3) NOT NULL DEFAULT '0',
  `rate` decimal(15,10) NOT NULL DEFAULT '1.0000000000',
  `rate2` decimal(15,10) NOT NULL DEFAULT '0.0000000000',
  `rate3` decimal(15,10) NOT NULL DEFAULT '1.0000000000',
  `notes` text NOT NULL,
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `metadata` text,
  `flags` int(11) NOT NULL DEFAULT '0',
  `sortid` bigint(11) UNSIGNED DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `client_id` (`client_id`),
  KEY `paid_id` (`paid_id`(32)),
  KEY `recurring_id` (`recurring_id`),
  KEY `flags` (`flags`),
  KEY `sortid` (`sortid`),
  KEY `contact_id` (`contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_invoices_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `who` varchar(32) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_id` (`invoice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_invoice_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `type` enum('Domain Register','Domain Renew','Domain Transfer','Hosting','Addon','Other','Upgrade','Invoice','Config','Credit','FieldUpgrade','Field','Discount','Support','Ticket','RefundedItem','OSLicense','LateFee') NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `description2` text NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `taxed` tinyint(1) NOT NULL,
  `tax_rate` decimal(10,2) DEFAULT NULL,
  `tax` decimal(10,2) DEFAULT NULL,
  `qty` decimal(10,2) NOT NULL DEFAULT '1.00',
  `position` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `invid` (`invoice_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_invoice_items_queue` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) NOT NULL,
  `rel_id` int(10) NOT NULL,
  `rel_type` varchar(50) NOT NULL,
  `item_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `note` text NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `taxed` tinyint(4) NOT NULL,
  `tax_rate` decimal(10,2) DEFAULT NULL,
  `qty` decimal(10,2) NOT NULL DEFAULT '1.00',
  `status` enum('Draft','Pending','Added','Cancelled') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `rel_id` (`rel_id`),
  KEY `item_id` (`item_id`),
  KEY `client_id_status` (`client_id`,`status`),
  KEY `rel_id_rel_type_status` (`rel_id`,`rel_type`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_invoice_numeration` (
  `counter` varchar(50) NOT NULL,
  `value` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_invoice_numeration` (`counter`, `value`, `updated_at`) VALUES
('CNoteNumerationPaid', 1, '2022-06-09 13:56:01'),
('InvoiceNumerationPaid', 1, '2022-06-09 13:56:01'),
('ReceiptNumeration', 1, '2022-06-09 13:56:01');
##########
CREATE TABLE `hb_knowledgebase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language_id` int(11) NOT NULL DEFAULT '1',
  `cat_id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `body` text NOT NULL,
  `registered` tinyint(1) NOT NULL,
  `options` tinyint(1) NOT NULL,
  `sort_order` int(11) NOT NULL,
  `views` int(11) NOT NULL,
  `slug` varchar(128) NOT NULL,
  `upvotes` int(11) DEFAULT '0',
  `downvotes` int(11) DEFAULT '0',
  PRIMARY KEY (`id`,`language_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_knowledgebase_cat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_cat` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `description` text,
  `sort_order` int(11) NOT NULL,
  `admin_only` tinyint(1) NOT NULL DEFAULT '0',
  `slug` varchar(128) NOT NULL,
  `options` int(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parent_cat` (`parent_cat`),
  KEY `admin_only` (`admin_only`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_knowledgebase_relations` (
  `parent_id` int(10) NOT NULL,
  `child_id` int(10) NOT NULL,
  PRIMARY KEY (`parent_id`,`child_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `target` enum('admin','user') NOT NULL DEFAULT 'admin',
  `name` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `direction` enum('ltr','rtl') NOT NULL DEFAULT 'ltr',
  `iso` varchar(4) DEFAULT NULL,
  `date_format` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  KEY `target` (`target`),
  KEY `status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_language` (`id`, `parent_id`, `target`, `name`, `status`, `direction`, `iso`, `date_format`) VALUES
(1, 0, 'admin', 'english', 1, 'ltr', 'en', ''),
(2, 0, 'user', 'english', 1, 'ltr', 'en', '');
##########
CREATE TABLE `hb_language_locales` (
  `language_id` int(11) NOT NULL,
  `section` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `keyword` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `value` text NOT NULL,
  `flags` int(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`language_id`,`section`,`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_localcloud` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `flag` int(11) UNSIGNED NOT NULL,
  `server_id` varchar(200) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id_server_id` (`account_id`,`server_id`),
  KEY `account_id` (`account_id`),
  KEY `account_id_flag` (`account_id`,`flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mettered_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `qty_max` int(11) NOT NULL,
  `price` decimal(25,5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_variable` (`variable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mettered_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_id` int(11) NOT NULL,
  `variable_id` int(11) NOT NULL,
  `type` enum('Admin','Client','Log','Report','Invoice') NOT NULL DEFAULT 'Log',
  `date_created` datetime NOT NULL,
  `output` text NOT NULL,
  `charge` decimal(25,5) NOT NULL,
  `currency_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `variable_id` (`variable_id`),
  KEY `account_id_variable_id` (`account_id`,`variable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mettered_summary` (
  `account_id` int(11) NOT NULL,
  `variable_id` int(11) NOT NULL,
  `type` enum('report','summary') NOT NULL,
  `last_value_id` int(11) NOT NULL,
  `date_start` date NOT NULL,
  `date_end` datetime NOT NULL,
  `usage` decimal(25,5) NOT NULL,
  `charge` decimal(25,5) NOT NULL,
  `recalc` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`account_id`,`variable_id`,`type`),
  KEY `account_id` (`account_id`),
  KEY `date_start` (`date_start`),
  KEY `variable_id` (`variable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mettered_sync` (
  `account_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `metadata` text,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mettered_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `currency_id` int(11) NOT NULL DEFAULT '0',
  `charge` decimal(25,5) NOT NULL,
  `qty` decimal(25,5) NOT NULL,
  `output` text NOT NULL,
  `rawoutput` text,
  PRIMARY KEY (`id`),
  KEY `fk_var` (`variable_id`),
  KEY `account_id` (`account_id`),
  KEY `variable_id_account_id` (`variable_id`,`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mettered_variables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `variable_name` varchar(45) NOT NULL,
  `unit_name` varchar(45) NOT NULL,
  `cycle` enum('Account','Hourly','Monthly') NOT NULL DEFAULT 'Account',
  `scheme` varchar(50) NOT NULL DEFAULT 'unit',
  `options` int(11) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`product_id`),
  KEY `variable` (`variable_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mfa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` enum('admin','client') NOT NULL,
  `user_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `data` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `module_id` (`module_id`),
  KEY `user_type` (`user_type`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_modules_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` varchar(128) NOT NULL,
  `type` enum('Hosting','Payment','Domain','Fraud','Other','Notification') NOT NULL,
  `config` text NOT NULL,
  `filename` varchar(128) NOT NULL,
  `version` varchar(32) NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `modname` varchar(100) NOT NULL,
  `subtype` tinyint(1) NOT NULL DEFAULT '0',
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `settings` text NOT NULL,
  `access` varchar(128) NOT NULL,
  `team_access` varchar(128) DEFAULT '',
  `remote` varchar(63) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type_active` (`type`,`active`),
  KEY `filename` (`filename`(32))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_modules_configuration` (`id`, `module`, `type`, `config`, `filename`, `version`, `active`, `modname`, `subtype`, `sort_order`, `settings`, `access`, `remote`) VALUES
(1, 'HBExtras', 'Other', 'a:0:{}', 'class.hbextras.php', '0.9', 1, 'HostBill Extras', 0, 0, '|haveadmin|havetpl|isobserver|', '', ''),
(2, 'AutoUpgrade', 'Other', 'a:0:{}', 'class.autoupgrade.php', '2.3', 1, 'HostBill Auto-Upgrade', 0, 100, '|haveadmin|havetpl|havecron|extras_menu|header_js|is_observer|isobserver|', '', ''),
(3, 'Ticket_Macro_Browser', 'Other', 'a:0:{}', 'class.ticket_macro_browser.php', '1.0', 1, 'Macro Browser', 3, 100, '|haveadmin|havetpl|', '', NULL);
##########
CREATE TABLE `hb_module_admin_acl` (
  `code` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `module_id` int(11) NOT NULL,
  PRIMARY KEY (`code`,`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_mod_rssfeeds` (
  `fetchdate` date NOT NULL,
  `pubDate` date NOT NULL,
  `title` varchar(128) NOT NULL,
  `link` varchar(256) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`title`(120))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_notes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `type` enum('client','account','domain','order','draft','admin','invoice','estimate','rackitem','contracts','workflow') NOT NULL DEFAULT 'client',
  `rel_id` int(10) NOT NULL DEFAULT '0',
  `admin_id` int(10) NOT NULL,
  `date` datetime NOT NULL,
  `note` text NOT NULL,
  `title` varchar(127) DEFAULT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `rel_id` (`rel_id`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_notifications` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `client_id` int(10) NOT NULL,
  `rel_type` varchar(127) NOT NULL DEFAULT 'none',
  `rel_id` int(10) NOT NULL DEFAULT '0',
  `seen` tinyint(1) NOT NULL DEFAULT '0',
  `subject` text,
  `body` text,
  `metadata` text,
  `type` enum('direct','broadcast') DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `date_seen` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rel_type` (`rel_type`),
  KEY `rel_id` (`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) NOT NULL,
  `payment_module` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `staff_member_id` int(11) NOT NULL DEFAULT '0',
  `invoice_id` int(11) NOT NULL DEFAULT '0',
  `total` decimal(10,2) NOT NULL,
  `currency_id` int(11) NOT NULL DEFAULT '-1',
  `date_created` datetime NOT NULL,
  `status` enum('Pending','Active','Cancelled','Fraud') NOT NULL,
  `order_ip` text NOT NULL,
  `notes` text,
  `metadata` text NOT NULL,
  `contract_accepted_date` datetime DEFAULT NULL,
  `contract_accepted_by` int(11) DEFAULT NULL,
  `commitment_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `number` (`number`),
  KEY `invoice_id` (`invoice_id`),
  KEY `client_id` (`client_id`),
  KEY `date_created` (`date_created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_order_contracts` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_id` int(11) UNSIGNED NOT NULL,
  `contract_id` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `contract_id` (`contract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_order_drafts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `payment_module` int(10) NOT NULL,
  `client_id` int(10) NOT NULL,
  `staff_member_id` int(11) NOT NULL DEFAULT '0',
  `affiliate_id` int(11) NOT NULL DEFAULT '0',
  `total` decimal(10,2) NOT NULL,
  `date_created` datetime NOT NULL,
  `options` int(4) NOT NULL DEFAULT '7',
  `scenario_id` int(11) NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `estimate_id` int(11) DEFAULT '0',
  `contract_id` int(11) UNSIGNED DEFAULT NULL,
  `commitment_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_order_drafts_items` (
  `draft_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) NOT NULL,
  `item_type` varchar(50) NOT NULL,
  `settings` text NOT NULL,
  PRIMARY KEY (`draft_id`,`item_id`,`item_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_order_items` (
  `order_id` int(11) NOT NULL,
  `type` enum('Domain Register','Domain Renew','Domain Transfer','Hosting','Addon','Other','Upgrade','FieldUpgrade') NOT NULL,
  `item_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`,`type`,`item_id`),
  KEY `type_item_id` (`type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_order_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT '',
  `entry` text NOT NULL,
  `who` varchar(127) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_order_scenarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(127) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_order_scenarios` (`id`, `name`) VALUES
(1, 'Default scenario');
##########
CREATE TABLE `hb_order_scenarios_steps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scenario_id` int(11) NOT NULL,
  `name` varchar(127) NOT NULL,
  `auto` tinyint(1) NOT NULL DEFAULT '1',
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `sort` int(2) NOT NULL,
  `config` text,
  PRIMARY KEY (`id`),
  KEY `scenario_id` (`scenario_id`),
  KEY `name` (`name`(16))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_order_scenarios_steps` (`id`, `scenario_id`, `name`, `auto`, `enabled`, `sort`, `config`) VALUES
(1, 1, 'FraudCheck', 1, 1, 1, 'a:1:{s:15:\"enabled_modules\";a:1:{i:0;s:3:\"all\";}}'),
(2, 1, 'SendInvoice', 1, 1, 3, NULL),
(3, 1, 'Authorize', 1, 1, 4, NULL),
(4, 1, 'Capture', 1, 1, 5, NULL),
(5, 1, 'Provision', 1, 1, 6, NULL),
(6, 1, 'FinalReview', 0, 0, 7, NULL),
(7, 1, 'AcceptContract', 1, 1, 2, NULL);
##########
CREATE TABLE `hb_order_steps` (
  `order_id` int(11) NOT NULL,
  `step_id` int(11) NOT NULL,
  `status` enum('Pending','Completed','Failed') NOT NULL DEFAULT 'Pending',
  `date_changed` datetime NOT NULL,
  `output` text NOT NULL,
  PRIMARY KEY (`order_id`,`step_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_oslicenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `account_id` int(11) DEFAULT NULL,
  `config_id` int(11) DEFAULT NULL,
  `template_id` varchar(255) DEFAULT NULL,
  `flag` tinyint(4) NOT NULL DEFAULT '0',
  `invoice_item` int(11) DEFAULT NULL,
  `meta` text,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_paid_addons` (
  `module` varchar(127) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`module`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
##########
CREATE TABLE `hb_prices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel` enum('Product','Addon','Config','Bundled','FResource') NOT NULL,
  `rel_id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rel_rel_id_type` (`rel`,`rel_id`,`type`),
  KEY `rel_rel_id` (`rel`,`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_price_update_profile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('tld','products') NOT NULL DEFAULT 'tld',
  `name` varchar(255) NOT NULL,
  `description` text,
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `server_id` int(11) NOT NULL,
  `default_product` int(11) NOT NULL,
  `default_margin_registration` decimal(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_renewal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_transfer` decimal(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_redemption` decimal(10,2) NOT NULL DEFAULT '0.00',
  `default_margin_type` enum('Percent','Fixed') NOT NULL DEFAULT 'Percent',
  `options` int(11) DEFAULT '0',
  `last_sync` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `server_id` (`server_id`),
  KEY `default_product` (`default_product`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_price_update_profile_items` (
  `profile_id` int(11) NOT NULL,
  `tld` varchar(255) NOT NULL,
  `margin_registration` decimal(10,2) NOT NULL DEFAULT '0.00',
  `margin_renewal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `margin_transfer` decimal(10,2) NOT NULL DEFAULT '0.00',
  `margin_redemption` decimal(10,2) NOT NULL DEFAULT '0.00',
  `margin_type` enum('Percent','Fixed') NOT NULL DEFAULT 'Percent',
  `options` int(11) DEFAULT '0',
  KEY `profile_id` (`profile_id`),
  KEY `tld` (`tld`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `type` tinyint(2) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `domain_options` tinyint(1) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `qty` int(1) NOT NULL DEFAULT '0',
  `autosetup` tinyint(1) NOT NULL DEFAULT '0',
  `subdomain` text NOT NULL,
  `owndomain` tinyint(1) NOT NULL DEFAULT '1',
  `owndomainwithus` tinyint(1) NOT NULL DEFAULT '0',
  `tax` tinyint(1) NOT NULL DEFAULT '0',
  `tax_group_id` int(11) NOT NULL DEFAULT '1',
  `upgrades` text NOT NULL,
  `sort_order` int(3) NOT NULL DEFAULT '0',
  `client_limit` int(10) NOT NULL DEFAULT '0',
  `hostname` tinyint(1) DEFAULT '0',
  `autohostname` varchar(255) DEFAULT '',
  `p_options` int(3) DEFAULT '0',
  `code` varchar(128) DEFAULT NULL,
  `contract_id` int(11) DEFAULT '0',
  `layout` varchar(255) DEFAULT 'left',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_products_freetlds` (
  `product_id` int(11) NOT NULL,
  `tlds` varchar(128) NOT NULL,
  `periods` varchar(256) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_products_modules` (
  `product_id` int(11) NOT NULL,
  `module` int(11) NOT NULL,
  `main` tinyint(1) NOT NULL DEFAULT '1',
  `server` varchar(128) NOT NULL DEFAULT '',
  `options` text NOT NULL,
  PRIMARY KEY (`product_id`,`module`),
  KEY `main` (`main`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_bundles` (
  `product_id` int(10) NOT NULL,
  `options` tinyint(4) NOT NULL,
  `valid_from` date NOT NULL,
  `valid_to` date NOT NULL,
  `draft` int(10) DEFAULT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_domains` (
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`category_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `product_id` int(11) NOT NULL,
  `admin_login` text NOT NULL,
  `change` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_log_diff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_metrics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `metric` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(255) NOT NULL,
  `limit` float DEFAULT '0',
  `trigger_period` int(11) NOT NULL,
  `flags` int(11) DEFAULT '0',
  `config_cat` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `module_id` (`module_id`),
  KEY `metric` (`metric`),
  KEY `limit` (`limit`),
  KEY `trigger_period` (`trigger_period`),
  KEY `flags` (`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(250) NOT NULL,
  `cartcode` blob NOT NULL,
  `status` tinyint(4) NOT NULL,
  `target` tinyint(4) NOT NULL,
  `cycle` enum('once','recurring') NOT NULL,
  `maxuse` int(11) NOT NULL,
  `conditions` blob NOT NULL,
  `offer` blob NOT NULL,
  `discount` decimal(12,2) NOT NULL DEFAULT '100.00',
  `expire_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `status_target` (`status`,`target`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_offer_usage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `offer_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `offer_id_client_id` (`offer_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_product_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_product_types` (`id`, `type`) VALUES
(10, 'bundles'),
(6, 'Colocation'),
(3, 'Dedicated'),
(9, 'DomainsType'),
(7, 'Marketing'),
(5, 'Other'),
(2, 'Reseller'),
(4, 'Server'),
(1, 'Shared'),
(11, 'ssltype');
##########
CREATE TABLE `hb_queue_status` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `rel_type` varchar(16) NOT NULL DEFAULT 'None',
  `rel_id` int(11) NOT NULL DEFAULT '0',
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `token` varchar(32) NOT NULL DEFAULT '',
  `status` int(2) NOT NULL DEFAULT '1',
  `added` datetime NOT NULL,
  `changed` datetime NOT NULL,
  `queue` varchar(32) NOT NULL DEFAULT '',
  `payload` longblob NOT NULL,
  `hash` varchar(32) NOT NULL,
  `description` text,
  `human_description` text NOT NULL,
  `env` longblob NOT NULL,
  `notify` blob,
  PRIMARY KEY (`id`),
  KEY `token` (`token`),
  KEY `rel_type` (`rel_type`,`rel_id`),
  KEY `hash` (`hash`),
  KEY `parent_id` (`parent_id`),
  KEY `status` (`status`),
  KEY `queue` (`queue`(16)),
  KEY `added` (`added`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_recurring_invoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `frequency` enum('1w','2w','4w','1m','em','2m','3m','6m','1y','2y') NOT NULL DEFAULT '1w',
  `start_from` date NOT NULL,
  `next_invoice` date NOT NULL,
  `duedays` tinyint(4) DEFAULT NULL,
  `paybefore` tinyint(4) DEFAULT NULL,
  `occurrences` int(11) NOT NULL DEFAULT '0',
  `invoices_left` int(11) NOT NULL DEFAULT '0',
  `recstatus` enum('Active','Stopped','Finished','Pending') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `occurrences` (`occurrences`),
  KEY `recstatus` (`recstatus`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL,
  `query` text NOT NULL,
  `options` int(10) NOT NULL,
  `handler` enum('php','sql') NOT NULL DEFAULT 'sql',
  `state` text NOT NULL,
  `columns` text NOT NULL,
  `displayname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75019 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`, `displayname`) VALUES
(1, 'Orders', 'Orders list in selected period', 'SELECT\r\n	o.id as `Order ID`,\r\n	o.number as `Order Number`,\r\n	COALESCE(m.modname,\'None\') AS `Payment Gateway`,\r\n	o.client_id AS `Client ID`,\r\n	ca.email AS `Client Email`,\r\n	CONCAT(cd.firstname,\' \',cd.lastname) AS `Client`,\r\n	hb_currency(o.total) AS `Order Total`,\r\n	o.order_ip AS `Order IP`,\r\n	hb_date(o.date_created) AS `Order Date`,\r\n	o.status AS `Current Status`,\r\n	COALESCE(cp.code,\'None\') AS `Promotional Coupon`,\r\n	COALESCE(clog.discount,\'0.00\') AS `Discount`\r\n\r\n\r\nFROM\r\n	hb_orders o JOIN\r\n	hb_modules_configuration m ON (m.id=o.payment_module) JOIN\r\n	hb_client_details cd ON (cd.id = o.client_id) JOIN\r\n	hb_client_access ca ON (ca.id=cd.id) LEFT JOIN\r\n	hb_coupons_log clog ON (clog.order_id=o.id) LEFT JOIN\r\n	hb_coupons cp ON (cp.id=clog.coupon_id)\r\nWHERE\r\n	o.date_created > :date_bottom	  AND\r\n	o.date_created < :date_top\r\n\r\n\r\nORDER BY\r\n	o.date_created ASC', 1, 'sql', '', '', 'Orders list in selected period'),
(2, 'Invoices', 'List of all invoices in given period', 'SELECT\r\ni.id AS `Invoice ID`,\r\nCONCAT(d.firstname,\' \',d.lastname) AS `Client`,\r\nhb_currency(i.total,i.currency_id,i.rate) AS `Invoice Total`,\r\ni.status AS `Invoice Status`,\r\nCASE WHEN hbc.value=\'eu\' THEN hb_date( i.datepaid) ELSE hb_date( i.date) END AS `Invoice Date`,\r\nhb_currency(i.credit,i.currency_id,i.rate) AS `Invoice Credit`,\r\nm.modname AS `Gateway Name`,\r\ntaxrate as `Tax1 rate`,\r\ntaxrate2 as `Tax2 rate`,\r\ntax as `Tax1 Amount`,\r\ntax2 as `Tax2 Amount`,\r\ni.rate AS `Exchange Rate`,\r\nhb_date(i.duedate) AS `Invoice Due Date`,\r\nhb_date(i.datepaid) AS `Invoice Paid Date`,\r\nt.trans_id AS `Related transaction`,\r\nca.email AS `Client Email`,\r\nd.phonenumber AS `Client Phone`,\r\nd.companyname  AS `Client Company`,\r\nd.city AS `Client City`,\r\nd.country AS `Client Country`,\r\nd.address1 AS `Client Address`,\r\nd.postcode AS `Client ZIP`\r\n\r\nFROM hb_invoices i\r\n    JOIN hb_client_details d ON (i.client_id=d.id)\r\n    JOIN hb_client_access ca ON (i.client_id=ca.id)\r\n    LEFT JOIN hb_modules_configuration m ON (m.id=i.payment_module)\r\n    LEFT JOIN hb_currencies c ON (c.id=i.currency_id)\r\n    LEFT JOIN hb_transactions t ON (t.invoice_id=i.id)\r\n    LEFT JOIN hb_configuration hbc ON hbc.setting=\'InvoiceModel\'\r\nWHERE\r\n    i.id NOT IN (\r\n        SELECT invoice_id\r\n        FROM hb_invoice_items\r\n        WHERE `type` = \'Invoice\'\r\n    ) \r\n    AND i.status NOT IN (\'Draft\',\'Recurring\')\r\n   AND ( (hbc.value!=\'eu\' AND i.`date`>=  :date_bottom AND i.`date`<= :date_top ) OR (hbc.value=\'eu\' AND i.`datepaid`>= :date_bottom AND i.`datepaid`<= :date_top) )\r\nORDER BY\r\n	i.id ASC', 1, 'sql', '', '', 'List of all invoices in given period'),
(3, 'Clients', 'Top 15 customers by income', 'SELECT\r\ncd.id AS `Client ID`,\r\nCONCAT(cd.firstname,\' \',cd.lastname) AS `Client`,\r\nhb_currency(SUM(t.`in`),cb.currency_id) AS `Total Income`\r\nFROM hb_client_details cd\r\nJOIN hb_client_billing cb ON (cb.client_id=cd.id)\r\nJOIN hb_transactions t ON (t.client_id=cd.id)\r\nGROUP BY cd.id\r\nORDER BY SUM(t.`in`) DESC\r\nLIMIT 15', 1, 'sql', '', '', 'Top 15 customers by income'),
(4, 'Support', 'Average number of ticket replies per department', 'SELECT\r\nd.name AS `Department`,\r\n(a.tot/COUNT(t.id)) AS `Average replies`\r\nFROM hb_ticket_departments d JOIN\r\n(\r\n SELECT COUNT(r.id) as tot, t.dept_id FROM hb_ticket_replies r JOIN hb_tickets t ON (t.id=r.ticket_id)\r\n GROUP BY t.dept_id\r\n) a ON (a.dept_id=d.id)\r\nJOIN hb_tickets t ON (t.dept_id=d.id)\r\nGROUP BY t.dept_id\r\n', 1, 'sql', '', '', 'Average number of ticket replies per department'),
(5, 'Support', 'Unresolved tickets count by staff member', 'SELECT aa.id AS `Staff ID` , CONCAT( ad.firstname, \' \', ad.lastname ) AS `Staff Member` , COUNT( t.id ) AS `Unresolved Tickets Count`\r\nFROM hb_admin_access aa\r\nJOIN hb_admin_details ad ON ( aa.id = ad.id )\r\nJOIN hb_tickets t ON ( t.owner_id = aa.id )\r\nWHERE t.status!=\'Closed\'\r\nGROUP BY t.owner_id', 1, 'sql', '', '', 'Unresolved tickets count by staff member'),
(6, 'Support', 'Unresolved tickets count by department member', 'SELECT d.id AS `Department ID` , d.name AS `Department Name` , COUNT( t.id ) AS `Unresolved Tickets Count`\r\nFROM hb_tickets t\r\nJOIN hb_ticket_departments d ON ( t.dept_id = d.id )\r\nWHERE t.status != \'Closed\'\r\nGROUP BY t.dept_id', 1, 'sql', '', '', 'Unresolved tickets count by department member'),
(7, 'Clients', 'List of clients that are Active, but dont have any active service', 'SELECT\r\ncd.id AS `Client ID`,\r\nCONCAT(cd.firstname,\' \',cd.lastname) AS `Client`\r\nFROM hb_client_details cd\r\nWHERE \r\ncd.parent_id=0 \r\nAND cd.id NOT IN (SELECT client_id FROM hb_accounts WHERE status=\'Active\')\r\nAND cd.id NOT IN (SELECT client_id FROM hb_domains WHERE status=\'Active\')\r\nAND cd.id NOT IN (SELECT a.client_id FROM hb_accounts a JOIN hb_accounts_addons ad ON (ad.account_id=a.id) WHERE ad.status=\'Active\')\r\nORDER BY cd.id ASC', 1, 'sql', '', '', 'List of clients that are Active, but dont have any active service'),
(8, 'Clients', 'List of clients with active services, with inactive profile (disabled login)', 'SELECT\ncd.id AS `Client ID`,\nCONCAT(cd.firstname,\' \',cd.lastname) AS `Client`\nFROM hb_client_details cd\nJOIN hb_client_access ca ON (ca.id=cd.id AND ca.status!=\'Active\')\n\nWHERE \n	cd.id IN (SELECT client_id FROM hb_accounts WHERE status=\'Active\')\n	OR cd.id IN (SELECT client_id FROM hb_domains WHERE status=\'Active\')\n	OR cd.id IN  (SELECT a.client_id FROM hb_accounts a JOIN hb_accounts_addons ad ON (ad.account_id=a.id) WHERE ad.status=\'Active\')\n\nORDER BY cd.id ASC', 1, 'sql', '', '', 'List of clients with active services, with inactive profile (disabled login)'),
(9, 'Clients', 'List of possible duplicates in client profiles', 'SELECT\r\ncd.id AS `Client ID`,\r\nCONCAT(cd.firstname,\' \',cd.lastname) AS `Client`,\r\nca.email AS `Client Email`\r\nFROM hb_client_details cd\r\nJOIN hb_client_access ca ON (ca.id=cd.id)\r\nINNER JOIN (\r\n SELECT firstname, lastname FROM hb_client_details GROUP BY firstname,lastname HAVING COUNT(id)>1\r\n) dup ON (dup.firstname=cd.firstname AND dup.lastname=cd.lastname)\r\nORDER BY cd.firstname,cd.lastname ASC', 1, 'sql', '', '', 'List of possible duplicates in client profiles'),
(10, 'Orders', 'Total transaction fees by gateway', 'SELECT\r\nm.modname AS `Gateway Name`,\r\nhb_currency(SUM(t.fee),t.currency_id,t.rate) AS `Total Fee`\r\nFROM hb_modules_configuration m\r\nJOIN hb_transactions t ON (t.module=m.id)\r\nGROUP BY t.module', 1, 'sql', '', '', 'Total transaction fees by gateway'),
(11, 'Orders', 'Total transactions count by gateway', 'SELECT\r\nm.modname AS `Gateway Name`,\r\nCOUNT(t.id) AS `Transactions count`\r\nFROM hb_modules_configuration m\r\nJOIN hb_transactions t ON (t.module=m.id)\r\nGROUP BY t.module', 1, 'sql', '', '', 'Total transactions count by gateway'),
(12, 'Support', 'List of tickets due today (based on SLA)', 'SELECT\r\nt.subject AS `Ticket Subject`,\r\nt.ticket_number AS `Ticket ID`,\r\nd.name AS `Department`,\r\nt.status AS `Ticket Status`,\r\nt.name AS `Submitter Name`,\r\nt.email AS `Submitter Email`,\r\nt.`date` AS `Ticket Date`,\r\nt.resolve_date AS `Ticket Due Date`\r\nFROM hb_tickets t\r\nJOIN hb_ticket_departments d ON ( t.dept_id = d.id )\r\nWHERE t.status != \'Closed\'\r\nAND\r\nt.resolve_date!=\'0000-00-00 00:00:00\'\r\nAND\r\nDATE(t.resolve_date)=DATE(NOW())', 1, 'sql', '', '', 'List of tickets due today (based on SLA)'),
(13, 'Support', 'List of overdue tickets (based on SLA)', 'SELECT\r\nt.subject AS `Ticket Subject`,\r\nt.ticket_number AS `Ticket ID`,\r\nd.name AS `Department`,\r\nt.status AS `Ticket Status`,\r\nt.name AS `Submitter Name`,\r\nt.email AS `Submitter Email`,\r\nt.`date` AS `Ticket Date`,\r\nt.resolve_date AS `Ticket Due Date`\r\nFROM hb_tickets t\r\nJOIN hb_ticket_departments d ON ( t.dept_id = d.id )\r\nWHERE t.status != \'Closed\'\r\nAND\r\nt.resolve_date!=\'0000-00-00 00:00:00\'\r\nAND\r\nt.resolve_date < NOW()', 1, 'sql', '', '', 'List of overdue tickets (based on SLA)'),
(14, 'Support', 'List of tickets rated less than 3 points this month', 'SELECT\r\nt.subject AS `Ticket Subject`,\r\nt.ticket_number AS `Ticket ID`,\r\nd.name AS `Department`,\r\nt.status AS `Ticket Status`,\r\nt.name AS `Submitter Name`,\r\nt.email AS `Submitter Email`,\r\nt.`date` AS `Ticket Date`\r\nFROM hb_tickets t\r\nJOIN hb_ticket_departments d ON ( t.dept_id = d.id )\r\nWHERE t.id IN (\r\n    SELECT r.ticket_id FROM hb_ticket_replies r JOIN  `hb_ticket_replies_rating` rate ON (rate.reply_id=r.id)\r\n    WHERE rate.rating<3\r\n)\r\nORDER BY t.date ASC', 1, 'sql', '', '', 'List of tickets rated less than 3 points this month'),
(15, 'Invoices', 'List of overdue invoices', '\r\nSELECT\r\ni.id AS `Invoice ID`,\r\nCONCAT(d.firstname,\' \',d.lastname) AS `Client`,\r\nhb_currency(i.total,i.currency_id,i.rate) AS `Invoice Total`,\r\ni.status AS `Invoice Status`,\r\ni.duedate AS `Invoice Due Date`,\r\nm.modname AS `Gateway Name`,\r\ntaxrate as `Tax1 rate`,\r\ntaxrate2 as `Tax2 rate`,\r\ntax as `Tax1 Amount`,\r\ntax2 as `Tax2 Amount`,\r\ni.rate AS `Exchange Rate`,\r\ni.date AS `Invoice Date`,\r\nca.email AS `Client Email`,\r\nd.phonenumber AS `Client Phone`,\r\nd.companyname  AS `Client Company`,\r\nd.city AS `Client City`,\r\nd.country AS `Client Country`,\r\nd.address1 AS `Client Address`,\r\nd.postcode AS `Client ZIP`,\r\nd.id AS `Client ID`\r\n\r\nFROM hb_invoices i\r\n    JOIN hb_client_details d ON (i.client_id=d.id)\r\n    JOIN hb_client_access ca ON (i.client_id=ca.id)\r\n    LEFT JOIN hb_modules_configuration m ON (m.id=i.payment_module)\r\n    LEFT JOIN hb_currencies c ON (c.id=i.currency_id)\r\nWHERE\r\n    i.id NOT IN (\r\n        SELECT invoice_id\r\n        FROM hb_invoice_items\r\n        WHERE `type` = \'Invoice\'\r\n    )\r\n    AND i.status IN (\'Unpaid\')\r\n    AND i.duedate >= NOW()\r\n\r\nORDER BY\r\n	i.id ASC', 1, 'sql', '', '', 'List of overdue invoices'),
(16, 'Staff', 'Hours spent online by staff this week', '\r\nSELECT\r\nl.admin_id AS `Staff ID`,\r\nCONCAT( ad.firstname, \' \', ad.lastname ) AS `Staff Member`,\r\nSUM(TIME_TO_SEC(TIMEDIFF(l.logout,l.login)))/3600 as `Hours Online`\r\nFROM hb_admin_log l \r\nJOIN hb_admin_details ad ON (ad.id=l.admin_id)\r\nWHERE\r\n YEARWEEK(l.login) = YEARWEEK(NOW())\r\n GROUP BY admin_id', 1, 'sql', '', '', 'Hours spent online by staff this week'),
(17, 'Staff', 'Hours spent online by staff this month', '\r\nSELECT\r\nl.admin_id AS `Staff ID`,\r\nCONCAT( ad.firstname, \' \', ad.lastname ) AS `Staff Member`,\r\nSUM(TIME_TO_SEC(TIMEDIFF(l.logout,l.login)))/3600 as `Hours Online`\r\nFROM hb_admin_log l\r\nJOIN hb_admin_details ad ON (ad.id=l.admin_id)\r\nWHERE\r\n MONTH(l.login) = MONTH(NOW())\r\nAND\r\n YEAR(l.login) = YEAR(NOW())\r\n GROUP BY admin_id', 1, 'sql', '', '', 'Hours spent online by staff this month'),
(18, 'Support', 'Number of support ticket opened per service in given period', 'SELECT\r\nc.name AS `Product Category`,\r\np.name AS `Product Name`,\r\nCOUNT(t.id) AS `Tickets count`\r\nFROM hb_products p\r\nJOIN hb_categories c ON (c.id=p.category_id)\r\nJOIN hb_accounts a ON (a.product_id=p.id)\r\nJOIN hb_tickets t ON (t.client_id=a.client_id)\r\nWHERE\r\n    t.date >= :date_bottom\r\n    AND t.date <= :date_top\r\nGROUP BY p.id\r\n', 1, 'sql', '', '', 'Number of support ticket opened per service in given period'),
(19, 'Invoices', 'Income from manually created invoices in given period', 'SELECT\r\n hb_currency(SUM(t.`in`),t.currency_id,t.rate) AS `Total Income`\r\nFROM\r\n hb_transactions t\r\n JOIN hb_invoices i ON (t.invoice_id=i.id)\r\n WHERE\r\n i.id IN (SELECT invoice_id FROM hb_invoice_items WHERE  `type`=\'Other\')\r\n AND\r\n    t.date >= :date_bottom\r\n    AND t.date <= :date_top\r\n', 1, 'sql', '', '', 'Income from manually created invoices in given period'),
(20, 'Invoices', 'List of overdue but non-terminated recurring accounts', 'SELECT\r\n a.id AS `Account ID`,\r\n c.name AS `Category Name`,\r\n p.name AS `Product Name`,\r\n a.status AS `Account Status`,\r\n a.next_due AS `Account next due date`\r\n\r\nFROM hb_accounts a\r\n JOIN hb_products p ON (p.id=a.product_id)\r\n JOIN hb_categories c ON (c.id=p.category_id)\r\nWHERE\r\n a.status NOT IN (\'Terminated\',\'Cancelled\',\'Fraud\',\'Pending\')\r\nAND\r\n a.billingcycle NOT IN (\'Free\',\'One Time\')\r\nAND\r\n a.id IN (\r\n SELECT it.item_id FROM hb_invoice_items it JOIN hb_invoices i ON (i.id=it.invoice_id)\r\n WHERE it.type=\'Hosting\' AND i.status=\'Unpaid\'\r\n)', 1, 'sql', '', '', 'List of overdue but non-terminated recurring accounts'),
(21, 'Invoices', 'Total sales tax liability in selected period', 'SELECT hb_currency(SUM(i.tax),i.currency_id) as `Total Tax L1`,\r\n hb_currency(SUM(i.tax2),i.currency_id) as `Total Tax L2`,\r\n hb_currency(SUM(i.total),i.currency_id) as `Invoice totals`,\r\n hb_currency(SUM(i.subtotal),i.currency_id) as `Invoice subtotals`,\r\n hb_currency(SUM(i.credit),i.currency_id) as `Invoice credits` \r\nFROM hb_invoices i \r\nWHERE\r\n i.status = \'Paid\' \r\nAND i.datepaid >= :date_bottom \r\nAND i.datepaid <= :date_top \r\nAND i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nGROUP BY i.currency_id', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:21:\"{$current_year_start}\";s:9:\":date_top\";s:20:\"{$current_month_end}\";}s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:5:{i:0;s:12:\"Total Tax L1\";i:1;s:12:\"Total Tax L2\";i:2;s:14:\"Invoice totals\";i:3;s:17:\"Invoice subtotals\";i:4;s:15:\"Invoice credits\";}', 'Total sales tax liability in selected period'),
(22, 'Invoices', 'Sales tax liability in selected period - list of invoices', 'SELECT i.id as `Invoice ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n hb_currency(i.total,i.currency_id) as `Invoice Subtotal`,\r\n hb_currency(i.credit,i.currency_id) as `Invoice Credit`,\r\n hb_currency(i.tax,i.currency_id) as `Invoice Tax L1`,\r\n hb_currency(i.tax2,i.currency_id) as `Invoice Tax L2`,\r\n hb_currency(i.total,i.currency_id) as `Invoice Total`,\r\n hb_date(i.datepaid) as `Invoice Paid Date`,\r\n hb_date(i.date) as `Invoice Date`,\r\n m.modname as `Gateway Name` \r\nFROM hb_invoices i \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nWHERE\r\n i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nAND i.status IN (\'Paid\') \r\nAND i.datepaid >= :date_bottom \r\nAND i.datepaid <= :date_top \r\n\r\nORDER BY i.id ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:21:\"{$current_year_start}\";s:9:\":date_top\";s:20:\"{$current_month_end}\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:10:{i:0;s:10:\"Invoice ID\";i:1;s:14:\"Invoice Tax L2\";i:2;s:13:\"Invoice Total\";i:3;s:6:\"Client\";i:4;s:17:\"Invoice Paid Date\";i:5;s:12:\"Invoice Date\";i:6;s:12:\"Gateway Name\";i:7;s:16:\"Invoice Subtotal\";i:8;s:14:\"Invoice Credit\";i:9;s:14:\"Invoice Tax L1\";}', 'Sales tax liability in selected period - list of invoices'),
(23, 'Support', '15 clients with highest number of tickets', 'SELECT\r\n t.client_id AS `Client ID`,\r\n COUNT(t.id) AS `Total tickets`,\r\n CONCAT(cd.firstname,\' \',cd.lastname) AS `Client`,\r\n cd.datecreated AS `Client since`\r\nFROM hb_tickets t JOIN\r\n hb_client_details cd ON (cd.id=t.client_id)\r\n\r\nGROUP BY t.client_id\r\nORDER BY `Total tickets` DESC\r\nLIMIT 15', 1, 'sql', '', '', '15 clients with highest number of tickets'),
(24, 'Clients', 'List all suspended accounts with their suspension dates', 'SELECT\r\n a.id AS `Account ID`,\r\n MAX(s.`date`) AS `Suspension Date`,\r\n a.client_id AS `Client ID`,\r\n CONCAT(cd.firstname,\' \',cd.lastname) AS `Client`,\r\n a.`domain` AS `Account Domain`,\r\n a.date_created AS `Creation date`,\r\n a.billingcycle AS `Billing cycle`,\r\n a.username AS `Username`\r\nFROM\r\n     hb_accounts a JOIN\r\n     hb_client_details cd ON (cd.id=a.client_id) JOIN\r\n     `hb_account_logs` s ON (s.account_id=a.id)\r\nWHERE\r\n     a.status=\'Suspended\'\r\n    AND s.`event`=\'AccountSuspend\' \r\n    AND s.`result`=\'1\'\r\nGROUP BY a.id\r\nORDER BY `Suspension Date` DESC', 1, 'sql', '', '', 'List all suspended accounts with their suspension dates'),
(25, 'Orders', 'All transactions informations in given period with purchased items details', 'SELECT t.trans_id AS `Transaction ID`, t.date AS `Transaction Date`, hb_currency(t.`in`,t.`currency_id`,t.rate) AS `Amount In`, it.description AS `Invoice Item`, hb_currency(t.`fee`,t.`currency_id`,t.rate) AS `Transaction Fees`, CONCAT(d.firstname,\' \',d.lastname) AS `Client`, t.description AS `Transaction Description`, hb_currency(t.`out`,t.`currency_id`,t.rate) AS `Amount Out`, t.client_id AS `Client ID`, t.invoice_id AS `Invoice ID`, m.modname AS `Payment Gateway` FROM hb_transactions t JOIN hb_invoices i ON (i.id=t.invoice_id) JOIN hb_invoice_items it ON (it.invoice_id=i.id) JOIN hb_client_details d ON (d.id=t.client_id) JOIN hb_modules_configuration m ON (m.id=t.`module`) WHERE t.date>= :date_bottom AND t.date<= :date_top ORDER BY t.date DESC', 1, 'sql', '', '', 'All transactions informations in given period with purchased items details'),
(26, 'Support', 'Weekend support by staff member in given period', '\r\nSELECT COUNT(DISTINCT t.`id`) AS `Tickets answered`,  r.name AS `Staff Name`\r\nFROM hb_tickets t\r\nJOIN hb_ticket_replies r ON (r.ticket_id=t.id)\r\nWHERE\r\n r.type=\'Admin\'\r\n AND\r\n r.`date` > :date_bottom\r\nAND\r\n r.`date` < :date_top\r\n AND\r\n DAYOFWEEK(r.`date`) IN (1,7)\r\nGROUP BY\r\nr.replier_id\r\n)\r\n', 1, 'sql', '', '', 'Weekend support by staff member in given period'),
(27, 'Support', 'Number of tickets closed per staff member in given period', 'SELECT SUBSTRING_INDEX(l.`action`,\'member\',\'-1\') AS `Staff member`, COUNT(t.`id`) AS `Total closed`, DATE(l.`date`) AS `Date` FROM `hb_tickets` t JOIN `hb_tickets_log` l ON (l.ticket_id=t.id) WHERE l.date>= :date_bottom AND l.date<= :date_top AND t.status=\'Closed\' AND l.action LIKE \'%to \"Closed\" by%\' GROUP BY `Date`, `Staff member`', 1, 'sql', '', '', 'Number of tickets closed per staff member in given period'),
(28, 'Support', 'Detailed list of all tickets in given period', 'SELECT t.subject AS `Ticket Subject`, t.ticket_number AS `Ticket ID`, d.`name` AS `Department`, t.status AS `Ticket Status`, t.`name` AS `Submitter Name`, t.email AS `Submitter Email`, t.`date` AS `Ticket Date`, COALESCE(CONCAT(a.firstname,\' \',a.lastname),\'-\') AS `Assigned Admin`, COALESCE(r.`rep`,\'0\') AS `Number of Replies`, t.`lastreply` AS `Last Reply Date`, t.`priority` AS `Priority Level` FROM `hb_tickets` t JOIN `hb_ticket_departments` d ON ( t.dept_id = d.id ) LEFT JOIN (SELECT r.`ticket_id`, COUNT(r.`id`) AS `rep` FROM `hb_ticket_replies` r WHERE r.`status`!=\'Draft\' GROUP BY r.`ticket_id`) r ON (r.ticket_id=t.id) LEFT JOIN `hb_admin_details` a ON (a.id=t.owner_id) WHERE t.`date`>= :date_bottom AND t.`date`<= :date_top ', 1, 'sql', '', '', 'Detailed list of all tickets in given period'),
(29, 'Orders', 'Income per product in given period', 'SELECT p.name AS `Product Name`, SUM(it.`amount`) AS `Product Income`, p.id AS `Product ID` FROM hb_invoices i JOIN hb_invoice_items it ON (it.invoice_id=i.id) JOIN hb_accounts a ON (a.id=it.item_id AND it.type=\'Hosting\') JOIN hb_products p ON (p.id=a.product_id) WHERE i.status=\'Paid\' AND i.`datepaid`>= :date_bottom AND i.`datepaid`<= :date_top GROUP BY p.id ORDER BY `Product Income` DESC', 1, 'sql', '', '', 'Income per product in given period'),
(30, 'Orders', 'Number of sales per product in given period', 'SELECT c.name as `Category Name`,\r\np.name as `Product Name`,\r\nCOUNT(a.id) as `Items Sold`,\r\np.id as `Product ID` \r\nFROM hb_invoices `i` \r\nINNER JOIN hb_invoice_items `it` ON (it.invoice_id = i.id) \r\nINNER JOIN hb_accounts `a` ON (a.id = it.item_id \r\nAND it.type = \'Hosting\') \r\nINNER JOIN hb_products `p` ON (a.product_id = p.id) \r\nINNER JOIN hb_categories `c` ON (c.id = p.category_id) \r\nWHERE\r\n i.status = \'Paid\' \r\nAND i.datepaid > :date_bottom \r\nAND i.datepaid < :date_top \r\nAND i.id IN (SELECT invoice_id \r\nFROM hb_orders) \r\nGROUP BY p.id \r\n\r\nORDER BY `Items Sold` DESC', 1, 'sql', '', '', 'Number of sales per product in given period'),
(31, 'Custom', 'Revenue per product type', 'report.revenuepertype.php', 0, 'php', '', '', 'Revenue per product type'),
(32, 'Support', 'Top 30 tickets-posting countries', 'SELECT cd.country AS  `Client Country` , COUNT( t.id ) AS  `Tickets Count` \r\n    FROM hb_tickets t\r\n    JOIN hb_client_details cd ON ( cd.id = t.client_id ) \r\n    GROUP BY cd.country\r\n    ORDER BY  `Tickets Count` DESC \r\n    LIMIT 30', 1, 'sql', '', '', 'Top 30 tickets-posting countries'),
(33, 'Orders', 'Total transaction fees by gateway, sort by period', 'SELECT m.modname as `Gateway Name`,\r\nhb_currency(SUM(t.fee) ,\r\nt.currency_id,t.rate) as `Total Fee` \r\nFROM hb_modules_configuration `m` \r\nINNER JOIN hb_transactions `t` ON (t.module = m.id) \r\nWHERE\r\n t.date > :date_bottom \r\nAND t.date < :date_top \r\nGROUP BY t.module', 1, 'sql', '', '', 'Total transaction fees by gateway, sort by period'),
(34, 'Orders', 'Total transactions count by gateway, sort by period', 'SELECT m.modname as `Gateway Name`,\r\nCOUNT(t.id) as `Transactions count` \r\nFROM hb_modules_configuration `m` \r\nINNER JOIN hb_transactions `t` ON (t.module = m.id) \r\nWHERE\r\n t.date > :date_bottom \r\nAND t.date < :date_top \r\nGROUP BY t.module', 1, 'sql', '', '', 'Total transactions count by gateway, sort by period'),
(35, 'Orders', 'Discounts by promocode', 'SELECT \r\nc.code as `Promotional coupon`,\r\nSUM(l.discount) AS `Total Discount`,\r\nCOUNT(l.id) AS `Times Used`,\r\nCOALESCE(cx.iso,\'Main Currency\') AS `Currency`\r\nFROM \r\nhb_coupons c\r\nJOIN\r\nhb_coupons_log l ON (l.coupon_id=c.id)\r\nJOIN \r\nhb_client_billing b ON b.client_id=l.client_id\r\nLEFT JOIN hb_currencies cx \r\nON cx.id=b.currency_id\r\nWHERE\r\nl.date>:date_bottom\r\nAND\r\nl.date<:date_top\r\n\r\n\r\nGROUP BY b.currency_id,c.id', 1, 'sql', '', '', 'Discounts by promocode'),
(36, 'Clients', 'List of credits applied to client accounts in given period', 'SELECT l.date AS `Date`,\nl.`in` AS `Credit Applied`,\nl.`admin_id` AS `Staff ID`,\nCONCAT( ad.firstname, \' \', ad.lastname ) AS `Staff Member`,\nCOALESCE(mc.modname,\'None\') AS `Gateway`,\nCOALESCE(cx.iso,\'Main Currency\') AS `Currency`,\nl.client_id AS `Client Id`,\nCONCAT(cd.firstname,\' \',cd.lastname) AS `Client name`\nFROM hb_client_credit_log l\nJOIN hb_client_details cd ON cd.id =l.client_id\nJOIN hb_client_billing b ON b.client_id=l.client_id\nLEFT JOIN hb_transactions t ON t.id=l.transaction_id\nLEFT JOIN hb_modules_configuration mc ON mc.id=t.module\nLEFT JOIN hb_currencies cx ON cx.id=b.currency_id\nLEFT JOIN hb_admin_details ad ON ad.id=l.admin_id\n\nWHERE l.date>:date_bottom\nAND l.date<:date_top\nAND l.`in`>0\nORDER BY l.date ASC', 1, 'sql', '', '', 'List of credits applied to client accounts in given period'),
(37, 'Clients', 'Amount of credit applied to client accounts in given period by gateway', 'SELECT\r\nSUM(l.`in`) AS `Credit Applied`,\r\nCOALESCE(mc.modname,\'None\') AS `Gateway`,\r\nCOALESCE(cx.iso,\'Main Currency\') AS `Currency`\r\nFROM\r\nhb_client_credit_log l\r\nJOIN\r\nhb_client_details cd ON cd.id =l.client_id\r\nJOIN\r\nhb_client_billing b ON b.client_id=l.client_id\r\nLEFT JOIN hb_transactions t ON t.id=l.transaction_id\r\nLEFT JOIN hb_modules_configuration mc ON mc.id=t.module\r\n\r\nLEFT JOIN hb_currencies cx ON cx.id=b.currency_id\r\n\r\nWHERE\r\nl.date>:date_bottom\r\nAND\r\nl.date<:date_top\r\nAND\r\nl.`in`>0\r\n\r\nGROUP BY b.currency_id,t.module', 1, 'sql', '', '', 'Amount of credit applied to client accounts in given period by gateway'),
(38, 'Clients', 'Amount of credit applied to client accounts in given period by staff member', 'SELECT SUM(l.`in`) AS `Credit Applied`,\nCOALESCE(cx.iso,\'Main Currency\') AS `Currency`,\nl.admin_id AS `Staff ID`,\nCONCAT( ad.firstname, \' \', ad.lastname ) AS `Staff Member`\nFROM hb_client_credit_log l\nJOIN hb_client_details cd ON cd.id =l.client_id\nJOIN hb_client_billing b ON b.client_id=l.client_id\nLEFT JOIN hb_transactions t ON t.id=l.transaction_id\nLEFT JOIN hb_modules_configuration mc ON mc.id=t.module\nLEFT JOIN hb_currencies cx ON cx.id=b.currency_id\nLEFT JOIN hb_admin_details ad ON ad.id=l.admin_id\nWHERE l.date>:date_bottom\nAND l.date<:date_top\nAND\nl.`in`>0\nGROUP BY b.currency_id, l.admin_id', 1, 'sql', '', '', 'Amount of credit applied to client accounts in given period by staff member'),
(39, 'Invoices', 'EU: Detailed VAT MOSS report', 'SELECT CONCAT(cd.firstname,\' \',cd.lastname) as `Customer Name`,\r\n CONCAT(cd.address1,\' \',cd.address2,\' \',cd.postcode,\' \',cd.city) as `Customer Address`,\r\n cd.country as `Country Code`,\r\n cd.id as `Customer ID`,\r\n i.paid_id as `Final Invoice ID`,\r\n DATE(i.datepaid) as `Date Paid`,\r\n i.total as `Total invoiced (Inc. VAT)`,\r\n i.subtotal as `Total invoiced (Excl. VAT)`,\r\n i.tax as `Total VAT collected`,\r\n i.taxrate as `Tax Rate`,\r\n GROUP_CONCAT(it.description) as `Invoiced items`,\r\n ca.ip as `Customer IP Address`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency Code` \r\nFROM hb_invoices i \r\nINNER JOIN hb_invoice_items it ON it.invoice_id = i.id \r\nINNER JOIN hb_client_details cd ON cd.id = i.client_id \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = i.currency_id \r\nLEFT JOIN hb_client_access ca ON ca.id = cd.id \r\nLEFT JOIN hb_orders o ON o.invoice_id = i.id \r\nWHERE\r\n i.paid_id != \'\' \r\nAND i.status = \'Paid\' \r\nAND YEAR(i.datepaid) = :year \r\nAND QUARTER(i.datepaid) = :quarter_number \r\nAND i.tax > 0 \r\nGROUP BY i.id \r\n\r\nORDER BY i.datepaid ASC', 1, 'sql', '', '', 'EU: Detailed VAT MOSS report'),
(40, 'Invoices', 'EU: List final invoices in given period', 'SELECT i.paid_id as `Final Invoice ID`,\r\n DATE(i.datepaid) as `Invoice Date Paid`,\r\n i.client_id as `Client ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client Name`,\r\n d.companyname as `Client Company Name`,\r\n v.value as `VAT ID`,\r\n d.country as `Client Country`,\r\n i.taxrate as `Tax1 rate`,\r\n i.tax as `Tax1 Amount`,\r\n i.subtotal as `Invoice Total without VAT`,\r\n i.total as `Invoice Total with VAT`,\r\n i.credit as `Invoice Credit`,\r\n i.status as `Invoice Status`,\r\n m.modname as `Gateway Name`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency Code` \r\nFROM hb_invoices i \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nINNER JOIN hb_client_fields_values v ON v.client_id = i.client_id \r\nINNER JOIN hb_client_fields f ON f.code = \'vateu\' \r\nAND v.field_id = f.id \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = i.currency_id \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nLEFT JOIN hb_currencies c ON (c.id = i.currency_id) \r\nLEFT JOIN hb_transactions t ON (t.invoice_id = i.id) \r\nWHERE\r\n i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nAND i.status NOT IN (\'Draft\', \'Creditnote\', \'Recurring\') \r\nAND i.`datepaid` >= :date_bottom \r\nAND i.`datepaid` <= :date_top \r\nAND i.paid_id != \'\' \r\n\r\nORDER BY i.datepaid ASC', 1, 'sql', '', '', 'EU: List final invoices in given period'),
(41, 'Invoices', 'EU: List refunded invoices with Credit Notes', 'SELECT i.paid_id as `Final Invoice ID`,\r\n c.paid_id as `Credit note ID`,\r\n DATE(i.datepaid) as `Invoice Date Paid`,\r\n DATE(c.date) as `Invoice Refund Date`,\r\n i.client_id as `Client ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client Name`,\r\n d.companyname as `Client Company Name`,\r\n v.value as `VAT ID`,\r\n d.country as `Client Country`,\r\n i.taxrate as `Tax1 rate`,\r\n i.tax as `Tax1 Amount`,\r\n c.subtotal as `Credit Note Total without VAT`,\r\n c.total as `Credit Note Total with VAT`,\r\n i.credit as `Invoice Credit`,\r\n i.status as `Invoice Status`,\r\n m.modname as `Gateway Name`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency Code` \r\nFROM hb_invoices i \r\nINNER JOIN hb_creditnotes cr ON cr.invoice_id = i.id \r\nINNER JOIN hb_invoices c ON c.id = cr.credit_note_id \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nINNER JOIN hb_client_fields_values v ON v.client_id = i.client_id \r\nINNER JOIN hb_client_fields f ON f.code = \'vateu\' \r\nAND v.field_id = f.id \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = i.currency_id \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nWHERE\r\n i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nAND i.status NOT IN (\'Draft\', \'Recurring\', \'Creditnote\') \r\nAND i.paid_id != \'\' \r\nAND i.`datepaid` >= :date_bottom \r\nAND i.`datepaid` <= :date_top \r\n\r\nORDER BY c.date ASC', 1, 'sql', '', '', 'EU: List refunded invoices with Credit Notes'),
(42, 'Clients', 'List of customers with positive credit balance', 'SELECT DISTINCT cb.client_id as `Client ID`,\r\n cb.credit as `Credit Balance`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency Code`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client Name` \r\nFROM hb_client_details d \r\nINNER JOIN hb_client_billing cb ON cb.client_id = d.id \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = cb.currency_id \r\nWHERE\r\n cb.credit > 0 \r\n\r\nORDER BY cb.credit DESC', 1, 'sql', '', '', 'List of customers with positive credit balance'),
(43, 'Invoices', 'Number of invoices generated per billing cycle in given period', 'SELECT COUNT(i.id) as `Invoice Count`,\r\n a.billingcycle as `Billing Cycle` \r\nFROM hb_invoices i \r\nINNER JOIN hb_invoice_items it ON it.invoice_id = i.id \r\nINNER JOIN hb_accounts a ON (a.id = it.item_id \r\nAND it.type = \'Hosting\') \r\nWHERE\r\n i.date >= :date_bottom \r\nAND i.date <= :date_top \r\nGROUP BY `Billing Cycle`', 1, 'sql', '', '', 'Number of invoices generated per billing cycle in given period'),
(44, 'Invoices', 'Detailed list of all invoices in given period - only hosting accounts', 'SELECT DISTINCT i.id as `Invoice ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n i.total as `Invoice Total`,\r\n i.status as `Invoice Status`,\r\n CASE WHEN hbc.value = \'eu\' THEN DATE(i.datepaid) ELSE DATE(i.date) END as `Invoice Date`,\r\n i.credit as `Invoice Credit`,\r\n m.modname as `Gateway Name`,\r\n taxrate as `Tax1 rate`,\r\n taxrate2 as `Tax2 rate`,\r\n tax as `Tax1 Amount`,\r\n tax2 as `Tax2 Amount`,\r\n i.rate as `Exchange Rate`,\r\n DATE(i.duedate) as `Invoice Due Date`,\r\n DATE(i.datepaid) as `Invoice Paid Date`,\r\n t.trans_id as `Related transaction`,\r\n ca.email as `Client Email`,\r\n d.phonenumber as `Client Phone`,\r\n d.companyname as `Client Company`,\r\n d.city as `Client City`,\r\n d.country as `Client Country`,\r\n d.address1 as `Client Address`,\r\n d.postcode as `Client ZIP`,\r\n a.billingcycle as `Billing Frequency`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency`,\r\n a.date_created as `Start Date`,\r\n DATE(COALESCE(cr.date,\'0000-00-00\')) as `End Date`,\r\n COALESCE(l.total,\'0.00\') as `Last Bill Amount` \r\nFROM hb_invoices i \r\nINNER JOIN hb_invoice_items it ON (it.invoice_id = i.id \r\nAND it.type = \'Hosting\') \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nINNER JOIN hb_accounts a ON (a.id = it.item_id) \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = i.currency_id \r\nLEFT JOIN (SELECT ii.total, aa.id as account_id \r\nFROM hb_invoices ii \r\nINNER JOIN hb_invoice_items iit ON (iit.invoice_id = ii.id \r\nAND iit.type = \'Hosting\') \r\nINNER JOIN hb_accounts aa ON aa.id = iit.item_id \r\nWHERE\r\n ii.date < :date_bottom \r\n\r\nORDER BY ii.id DESC) l ON a.id = l.account_id \r\nLEFT JOIN hb_cancel_requests cr ON a.id = cr.account_id \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nLEFT JOIN hb_transactions t ON (t.invoice_id = i.id) \r\nLEFT JOIN hb_configuration hbc ON hbc.setting = \'InvoiceModel\' \r\nWHERE\r\n i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nAND i.status NOT IN (\'Draft\', \'Recurring\', \'Creditnote\') \r\nAND ((hbc.value != \'eu\' \r\nAND i.`date` >= :date_bottom \r\nAND i.`date` <= :date_top) \r\nOR (hbc.value = \'eu\' \r\nAND i.`datepaid` >= :date_bottom \r\nAND i.`datepaid` <= :date_top)) \r\n\r\nORDER BY i.id ASC', 1, 'sql', '', '', 'Detailed list of all invoices in given period - only hosting accounts'),
(45, 'Invoices', 'List of invoices with Paid status but with unpaid balance', 'SELECT DISTINCT i.id as `Invoice ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n i.credit as `Invoice Credit`,\r\n i.total as `Invoice Total`,\r\n COALESCE(SUM(t.`in`),\'0.00\') as `Amount Paid`,\r\n CASE WHEN hbc.value = \'eu\' THEN DATE(i.datepaid) ELSE DATE(i.date) END as `Invoice Date`,\r\n m.modname as `Gateway Name`,\r\n taxrate as `Tax1 rate`,\r\n taxrate2 as `Tax2 rate`,\r\n tax as `Tax1 Amount`,\r\n tax2 as `Tax2 Amount`,\r\n i.rate as `Exchange Rate`,\r\n DATE(i.duedate) as `Invoice Due Date`,\r\n DATE(i.datepaid) as `Invoice Paid Date`,\r\n ca.email as `Client Email`,\r\n d.phonenumber as `Client Phone`,\r\n d.companyname as `Client Company`,\r\n d.city as `Client City`,\r\n d.country as `Client Country`,\r\n d.address1 as `Client Address`,\r\n d.postcode as `Client ZIP`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency` \r\nFROM hb_invoices i \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = i.currency_id \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nLEFT JOIN hb_transactions t ON (t.invoice_id = i.id) \r\nLEFT JOIN hb_configuration hbc ON hbc.setting = \'InvoiceModel\' \r\nWHERE\r\n i.status IN (\'Paid\') \r\nAND ((hbc.value != \'eu\' \r\nAND i.`date` >= :date_bottom \r\nAND i.`date` <= :date_top) \r\nOR (hbc.value = \'eu\' \r\nAND i.`datepaid` >= :date_bottom \r\nAND i.`datepaid` <= :date_top)) \r\nGROUP BY i.id \r\nHAVING i.total > COALESCE(SUM(t.`in`),0) \r\n\r\nORDER BY i.id ASC', 1, 'sql', '', '', 'List of invoices with Paid status but with unpaid balance'),
(46, 'Clients', 'List of all customers with their statistics', 'SELECT cd.id as `Client ID`,\r\n cd.firstname as `First Name`,\r\n cd.lastname as `Last Name`,\r\n cd.city as `City`,\r\n ca.status as `Status`,\r\n cd.datecreated as `Signup Date`,\r\n COALESCE(a.cnt,0) as `Active Services Count`,\r\n COALESCE(i.dt,\'0000-00-00\') as `Date of Last Invoice`,\r\n COALESCE(i.cnt,0) as `Invoices Paid Total`,\r\n COALESCE(t.cnt,0) as `Transaction Income`,\r\n COALESCE(cur.code,sub.main_currency) as `Currency`,\r\n COALESCE(cur.rate,1) as `Currency Rate` \r\nFROM hb_client_details cd \r\nINNER JOIN hb_client_access ca ON ca.id = cd.id \r\nINNER JOIN hb_client_billing cb ON cb.client_id = cd.id \r\nINNER JOIN (SELECT value as main_currency, 0 as currency_id \r\nFROM hb_configuration \r\nWHERE\r\n setting = \'CurrencyCode\') sub ON sub.currency_id = 0 \r\nLEFT JOIN hb_currencies cur ON cur.id = cb.currency_id \r\nLEFT JOIN (SELECT COUNT(id) as cnt, client_id \r\nFROM hb_accounts \r\nGROUP BY client_id) a ON a.client_id = cd.id \r\nLEFT JOIN (SELECT MAX(date) as dt, SUM(total) as cnt, client_id \r\nFROM hb_invoices \r\nWHERE\r\n status = \'Paid\' \r\nGROUP BY client_id) i ON i.client_id = cd.id \r\nLEFT JOIN (SELECT SUM(`in`) as cnt, client_id \r\nFROM hb_transactions \r\nGROUP BY client_id) t ON t.client_id = cd.id \r\n\r\nORDER BY cd.id DESC', 1, 'sql', '', '', 'List of all customers with their statistics'),
(1000, 'Invoices', 'Daily income', 'SELECT r.range as `Day`,\n COALESCE(SUM((t.`in`  - t.`out`) / t.`rate`),0) as `Income` \nFROM hb_reports_day_range r \nLEFT JOIN hb_transactions t ON (r.range = DAY(t.date) \nAND DATE(t.date) >= :date_bottom \nAND DATE(t.date) <= :date_top) \nWHERE\n r.range < 32 \nGROUP BY `Day`,\n DAY(t.date) \n\nORDER BY `Day` ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', NULL),
(1001, 'Invoices', 'Monthly income', 'SELECT r.month as `Month`,\n COALESCE(SUM((t.`in` - t.`out`) / t.`rate`),0) as `Income` \nFROM hb_reports_day_range r \nLEFT JOIN hb_transactions t ON (r.range = MONTH(t.date) \nAND DATE(t.date) >= :date_bottom\nAND DATE(t.date) <= :date_top ) \nWHERE\n r.range < 13 \nGROUP BY `Month`,\n MONTH(t.date) \n\nORDER BY r.range ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:18:\"current-year-start\";s:9:\":date_top\";s:16:\"current-year-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', NULL),
(1002, 'Support', 'New tickets monthly', 'SELECT r.month as `Month`,\n COUNT(t.id) as `Tickets` \nFROM hb_reports_day_range r \nLEFT JOIN hb_tickets t ON (r.range = MONTH(t.date) \nAND DATE(t.date) >= :date_bottom\nAND DATE(t.date) <= :date_top ) \nWHERE\n r.range < 13 \nGROUP BY `Month`,\n MONTH(t.date) \n\nORDER BY r.range ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:18:\"current-year-start\";s:9:\":date_top\";s:16:\"current-year-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:5:\"Month\";i:1;s:7:\"Tickets\";}', 'New tickets monthly'),
(1003, 'Support', 'New tickets daily', 'SELECT r.range as `Day`,\n COUNT(t.id) as `Tickets` \nFROM hb_reports_day_range r \nLEFT JOIN hb_tickets t ON (r.range = DAY(t.date) \nAND DATE(t.date) >= :date_bottom\nAND DATE(t.date) <= :date_top ) \nWHERE\n r.range < 32 \nGROUP BY `Day`,\n DAY(t.date) \n\nORDER BY r.range ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:3:\"Day\";i:1;s:7:\"Tickets\";}', 'New tickets daily'),
(2000, 'Invoices', 'Monthly cumulative income', 'SELECT r.month as `Month`,\r\n @total := @total + COALESCE(t.income,0) as `Income` \r\nFROM hb_reports_day_range r \r\nLEFT JOIN (SELECT MONTH(date) as date, COALESCE(SUM((`in` -  `out`) / `rate`),0) as income \r\nFROM hb_transactions \r\nWHERE\r\n DATE(date) >= :date_bottom \r\nAND DATE(date) <= :date_top \r\nGROUP BY MONTH(date)) as t ON (r.range = t.date) \r\nINNER JOIN (SELECT @total := 0) as tx \r\nWHERE\r\n r.range < 13 \r\nGROUP BY `Month` \r\n\r\nORDER BY r.range ASC', 1, 'sql', '', '', NULL),
(2001, 'Invoices', 'Daily cumulative income', 'SELECT r.range as `Day`,\r\n@total := @total +  COALESCE(t.income,0) as `Income` \r\nFROM hb_reports_day_range r \r\nJOIN (SELECT @total := 0) as tx \r\nLEFT JOIN (SELECT DAY(date) as date, COALESCE(SUM((`in` - `out`) / `rate`),0) as income \r\nFROM hb_transactions \r\nWHERE\r\n DATE(date) >= :date_bottom\r\nAND DATE(date) <=  :date_top\r\nGROUP BY DAY(date) ORDER BY date ASC) as t ON (r.range = t.date) \r\nWHERE\r\n r.range < 31\r\nGROUP BY `Day` \r\nORDER BY r.range ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', NULL),
(2002, 'Invoices', 'All transactions in given period', 'SELECT t.trans_id as `Transaction ID`,\r\n t.date as `Transaction Date`,\r\n t.`in` as `Amount In`,\r\n t.`fee` as `Transaction Fees`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n t.description as `Transaction Description`,\r\n t.`out` as `Amount Out`,\r\n t.client_id as `Client ID`,\r\n t.rate as `Currency Conversion Rate`,\r\n t.invoice_id as `Invoice ID`,\r\n COALESCE(cx.iso,\'Main Currency\') as `Currency`,\r\n m.modname as `Payment Gateway` \r\nFROM hb_transactions t \r\nINNER JOIN hb_client_details d ON (d.id = t.client_id) \r\nINNER JOIN hb_modules_configuration m ON (m.id = t.`module`) \r\nLEFT JOIN hb_currencies cx ON cx.id = t.currency_id \r\nWHERE\r\n t.date >= :date_bottom \r\nAND t.date <= :date_top \r\n\r\nORDER BY t.date DESC', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:10:{i:0;s:14:\"Transaction ID\";i:1;s:16:\"Transaction Date\";i:2;s:9:\"Amount In\";i:3;s:16:\"Transaction Fees\";i:4;s:10:\"Amount Out\";i:5;s:6:\"Client\";i:6;s:9:\"Client ID\";i:7;s:8:\"Currency\";i:8;s:24:\"Currency Conversion Rate\";i:9;s:15:\"Payment Gateway\";}', 'All transactions in given period'),
(2003, 'Orders', 'Number of cancelations per customer in given period', 'SELECT cd.id as `Client ID`, CONCAT(cd.firstname,\' \',cd.lastname) as `Client`, COUNT(c.id) as `Cancellations Count`  FROM hb_cancel_requests c  INNER JOIN hb_accounts a ON a.id = c.item_id  INNER JOIN hb_client_details cd ON cd.id = a.client_id  WHERE c.item_type = \'Account\' AND c.date >= :date_bottom  AND c.date <= :date_top   GROUP BY cd.id', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:3:{i:0;s:9:\"Client ID\";i:1;s:6:\"Client\";i:2;s:19:\"Cancellations Count\";}', 'Number of cancelations per customer in given period'),
(2004, 'Orders', 'Number of cancelations per product in given period', 'SELECT cd.id as `Product ID`, cd.name as `Product Name`, cat.name as `Category Name`, COUNT(c.id) as `Cancellations Count` FROM hb_cancel_requests c INNER JOIN hb_accounts a ON a.id = c.item_id INNER JOIN hb_products cd ON cd.id = a.product_id INNER JOIN hb_categories cat ON cat.id = cd.category_id WHERE c.item_type = \'Account\' AND c.date >= :date_bottom AND c.date <= :date_top GROUP BY cd.id', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:4:{i:0;s:10:\"Product ID\";i:1;s:12:\"Product Name\";i:2;s:13:\"Category Name\";i:3;s:19:\"Cancellations Count\";}', 'Number of cancelations per product in given period'),
(2005, 'Invoices', 'Statement of account per customer', 'SELECT i.id as `Invoice ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n i.total as `Invoice Total`,\r\n i.status as `Invoice Status`,\r\n CASE WHEN hbc.value = \'eu\' THEN DATE(i.datepaid) ELSE DATE(i.date) END as `Invoice Date`,\r\n i.credit as `Invoice Credit`,\r\n m.modname as `Gateway Name`,\r\n taxrate as `Tax1 rate`,\r\n taxrate2 as `Tax2 rate`,\r\n tax as `Tax1 Amount`,\r\n tax2 as `Tax2 Amount`,\r\n i.rate as `Exchange Rate`,\r\n DATE(i.duedate) as `Invoice Due Date`,\r\n DATE(i.datepaid) as `Invoice Paid Date`,\r\n t.trans_id as `Related transaction`,\r\n i.client_id as `Client ID`,\r\n ca.email as `Client Email`,\r\n d.phonenumber as `Client Phone`,\r\n d.companyname as `Client Company`,\r\n d.city as `Client City`,\r\n d.country as `Client Country`,\r\n d.address1 as `Client Address`,\r\n d.postcode as `Client ZIP` \r\nFROM hb_invoices i \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nLEFT JOIN hb_currencies c ON (c.id = i.currency_id) \r\nLEFT JOIN hb_transactions t ON (t.invoice_id = i.id) \r\nLEFT JOIN hb_configuration hbc ON hbc.setting = \'InvoiceModel\' \r\nWHERE\r\n i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nAND i.status NOT IN (\'Draft\', \'Recurring\') \r\nAND i.`date` >= :date_bottom \r\nAND i.`date` <= :date_top \r\nAND i.client_id = :client_id \r\n\r\nORDER BY i.id ASC', 1, 'sql', '', '', 'Statement of account per customer'),
(2006, 'Invoices', 'Aging Invoices', 'SELECT cd.id as `Client ID`,\r\n cd.companyname as `Organization`,\r\n CONCAT(cd.firstname,\' \',cd.lastname) as `Primary Contact`,\r\n ca.email as `Email`,\r\n cd.phonenumber as `Phone`,\r\n COALESCE(SUM(CASE WHEN i.duedate < CURDATE() \r\nAND i.duedate >= DATE_SUB(CURDATE(),INTERVAL 30 DAY) THEN i.total END),0) as `Aged Over 1-30`,\r\n COALESCE(SUM(CASE WHEN i.duedate < DATE_SUB(CURDATE(),INTERVAL 30 DAY) \r\nAND i.duedate >= DATE_SUB(CURDATE(),INTERVAL 60 DAY) THEN i.total END),0) as `Aged Over 31-60`,\r\n COALESCE(SUM(CASE WHEN i.duedate < DATE_SUB(CURDATE(),INTERVAL 60 DAY) \r\nAND i.duedate >= DATE_SUB(CURDATE(),INTERVAL 90 DAY) THEN i.total END),0) as `Aged Over 61-90`,\r\n COALESCE(SUM(CASE WHEN i.duedate < DATE_SUB(CURDATE(),INTERVAL 90 DAY) THEN i.total END),0) as `Aged Over 90`,\r\n SUM(i.total) as `Total Due` \r\nFROM hb_client_details cd \r\nINNER JOIN hb_client_access ca ON (ca.id = cd.id) \r\nINNER JOIN hb_invoices i ON i.client_id = ca.id \r\nWHERE\r\n i.status = \'Unpaid\' \r\nAND i.duedate < CURDATE() \r\nAND i.total > 0 \r\nGROUP BY i.client_id \r\n\r\nORDER BY `Total Due` DESC', 1, 'sql', 'a:3:{s:6:\"params\";N;s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:10:{i:0;s:9:\"Client ID\";i:1;s:12:\"Organization\";i:2;s:15:\"Primary Contact\";i:3;s:5:\"Email\";i:4;s:5:\"Phone\";i:5;s:14:\"Aged Over 1-30\";i:6;s:15:\"Aged Over 31-60\";i:7;s:15:\"Aged Over 61-90\";i:8;s:12:\"Aged Over 90\";i:9;s:9:\"Total Due\";}', 'Aging Invoices'),
(2007, 'Invoices', 'Metric: EU: Income minus tax', 'report.incomeoffvattax.php', 0, 'php', 'a:3:{s:6:\"params\";N;s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:3:{i:0;s:9:\"This Year\";i:1;s:10:\"This Month\";i:2;s:5:\"Today\";}', 'Metric: EU: Income minus tax'),
(75000, 'Custom', 'Daily performance', 'SELECT r.range as `Day`,\r\n (SELECT count(i.id) \r\nFROM hb_invoices i \r\nWHERE\r\n r.range = DAY(i.date) \r\nAND DATE(i.date) >= :date_bottom \r\nAND DATE(i.date) <= :date_top) as `Invoices`,\r\n (SELECT count(p.id) \r\nFROM hb_invoices p \r\nWHERE\r\n r.range = DAY(p.date) \r\nAND DATE(p.date) >= :date_bottom \r\nAND DATE(p.date) <= :date_top \r\nAND p.status IN (\'Paid\')) as `Paid Invoices`,\r\n (SELECT count(o.id) \r\nFROM hb_orders o \r\nWHERE\r\n r.range = DAY(o.date_created) \r\nAND DATE(o.date_created) >= :date_bottom \r\nAND DATE(o.date_created) <= :date_top) as `New orders`,\r\n (SELECT count(t.id) \r\nFROM hb_tickets t \r\nWHERE\r\n r.range = DAY(t.date) \r\nAND DATE(t.date) >= :date_bottom \r\nAND DATE(t.date) <= :date_top) as `Ticked opened`,\r\n (SELECT count(tr.id) \r\nFROM hb_ticket_replies tr \r\nWHERE\r\n r.range = DAY(tr.date) \r\nAND DATE(tr.date) >= :date_bottom \r\nAND DATE(tr.date) <= :date_top) as `Ticked responses`,\r\n (SELECT count(c.id) \r\nFROM hb_cancel_requests c \r\nWHERE\r\n r.range = DAY(c.date) \r\nAND DATE(c.date) >= :date_bottom \r\nAND DATE(c.date) <= :date_top) as `Cancelation requests`,\r\n (SELECT count(a.id) \r\nFROM hb_accounts a \r\nWHERE\r\n r.range = DAY(a.date_created) \r\nAND DATE(a.date_created) >= :date_bottom \r\nAND DATE(a.date_created) <= :date_top) as `Accounts added`,\r\n (SELECT count(d.id) \r\nFROM hb_domains d \r\nWHERE\r\n r.range = DAY(d.date_created) \r\nAND DATE(d.date_created) >= :date_bottom \r\nAND DATE(d.date_created) <= :date_top) as `Domains added` \r\nFROM hb_reports_day_range r \r\nWHERE\r\n r.range < 32 \r\n\r\nORDER BY `Day` ASC', 0, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"previous- MONTH- START\";s:9:\":date_top\";s:17:\"previous- MONTH- END\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:1:{i:0;s:3:\" DAY\";}', 'Daily Perfomance Report');
##########
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`, `displayname`) VALUES
(75001, 'Invoices', 'Monthly Turnover by Client', 'SELECT  cd.id as `Client ID`, CONCAT(cd.firstname, , cd.lastname) as `Client`, sql_currency(COALESCE(ac.ac_total,0) + COALESCE(ad.ad_total,0) + COALESCE(am.am_total,0),cb.currency_id,0) as `TOTAL`, COALESCE(ac.ac_count_services,0) + COALESCE(ad.ad_count_services,0) + COALESCE(am.am_count_services,0) as `Active Services` FROM hb_client_details cd LEFT JOIN hb_client_billing cb on (cd.id=cb.client_id) LEFT JOIN ( SELECT 1ac.client_id, count(1ac.id) as ac_count_services, SUM(COALESCE(case  when 1ac.billingcycle = \"Monthly\" then 1ac.`total` when 1ac.billingcycle = \"Quarterly\" then 1ac.`total` / 3 when 1ac.billingcycle = \"Semi-Annually\" then 1ac.`total` / 6 when 1ac.billingcycle = \"Annually\" then 1ac.`total` / 12 when 1ac.billingcycle = \"Biennially\" then 1ac.`total` / 24 when 1ac.billingcycle = \"Triennially\" then 1ac.`total` / 36 when 1ac.billingcycle = \"Quadrennially\" then 1ac.`total` / 48 when 1ac.billingcycle = \"Quinquennially\" then 1ac.`total` / 60 when 1ac.billingcycle = \"Daily\" then 1ac.`total` * 30 when 1ac.billingcycle = \"Weekly\" then 1ac.`total` / 7 * 30 when 1ac.billingcycle = \"Hourly\" then 1ac.`total` * 24 * 30	 end,0)) as ac_total FROM hb_accounts 1ac LEFT JOIN hb_client_billing 1cb on (1ac.client_id=1cb.client_id) WHERE 1ac.client_id = :client_id AND 1ac.status = \'Active\' AND 1ac.billingcycle NOT IN (\'Free\', \'One Time\') GROUP BY 1ac.client_id) ac  ON (ac.client_id = cd.id OR ac.client_id IS NULL) LEFT JOIN ( SELECT 2ac.client_id, count(2ad.id) as ad_count_services, SUM(COALESCE(case  when 2ad.billingcycle = \"Monthly\" then 2ad.recurring_amount when 2ad.billingcycle = \"Quarterly\" then 2ad.recurring_amount / 3 when 2ad.billingcycle = \"Semi-Annually\" then 2ad.recurring_amount / 6 when 2ad.billingcycle = \"Annually\" then 2ad.recurring_amount / 12 when 2ad.billingcycle = \"Biennially\" then 2ad.recurring_amount / 24 when 2ad.billingcycle = \"Triennially\" then 2ad.recurring_amount / 36 when 2ad.billingcycle = \"Quadrennially\" then 2ad.recurring_amount / 48 when 2ad.billingcycle = \"Quinquennially\" then 2ad.recurring_amount / 60 when 2ad.billingcycle = \"Daily\" then 2ad.recurring_amount * 30 when 2ad.billingcycle = \"Weekly\" then 2ad.recurring_amount / 7 * 30 when 2ad.billingcycle = \"Hourly\" then 2ad.recurring_amount * 24 * 30	 end,0)) as ad_total FROM hb_accounts_addons 2ad INNER JOIN hb_accounts 2ac on (2ac.id = 2ad.account_id) LEFT JOIN hb_client_billing 2cb on (2ac.client_id=2cb.client_id) WHERE 2ac.client_id = :client_id  AND 2ac.status = \'Active\' AND 2ac.billingcycle NOT IN (\'Free\', \'One Time\') GROUP BY 2ac.client_id) ad  ON (ad.client_id = cd.id OR ad.client_id IS NULL) LEFT JOIN ( SELECT 3am.client_id, count(3am.id) as am_count_services, COALESCE(3am.recurring_amount/3am.period/12,0) as am_total FROM hb_domains 3am LEFT JOIN hb_client_billing 3cb on (3am.client_id=3cb.client_id) WHERE 3am.client_id = :client_id  AND 3am.status = \'Active\' GROUP BY 3am.client_id) am  ON (am.client_id = cd.id OR am.client_id IS NULL) WHERE cd.id = :client_id', 1, 'sql', '', '', 'Monthly Turnover by Client'),
(75002, 'Invoices', 'Monthly Turnover for all clients, normalized  by currency', 'SELECT cd.id as `Client ID`,  CONCAT(cd.firstname, \' \', cd.lastname) as `Client`,  sql_currency(COALESCE(ac.ac_total,0) + COALESCE(ad.ad_total,0) + COALESCE(am.am_total,0),cb.currency_id,0) as `Total value (Client currency)`,  sql_normalize_currency(COALESCE(ac.ac_total,0) + COALESCE(ad.ad_total,0) + COALESCE(am.am_total,0),cb.currency_id,:currency,1) as `Total value (Normalized currency)`,  COALESCE(ac.ac_count_services,0) + COALESCE(ad.ad_count_services,0) + COALESCE(am.am_count_services,0) as `Active Services`  FROM hb_client_details cd  LEFT JOIN hb_client_billing cb on (cd.id=cb.client_id)  LEFT JOIN ( SELECT 1ac.client_id, count(1ac.id) as ac_count_services,  SUM(COALESCE(case   when 1ac.billingcycle = \"Monthly\" then 1ac.`total`  when 1ac.billingcycle = \"Quarterly\" then 1ac.`total` / 3  when 1ac.billingcycle = \"Semi-Annually\" then 1ac.`total` / 6  when 1ac.billingcycle = \"Annually\" then 1ac.`total` / 12  when 1ac.billingcycle = \"Biennially\" then 1ac.`total` / 24  when 1ac.billingcycle = \"Triennially\" then 1ac.`total` / 36  when 1ac.billingcycle = \"Quadrennially\" then 1ac.`total` / 48  when 1ac.billingcycle = \"Quinquennially\" then 1ac.`total` / 60  when 1ac.billingcycle = \"Daily\" then 1ac.`total` * 30  when 1ac.billingcycle = \"Weekly\" then 1ac.`total` / 7 * 30  when 1ac.billingcycle = \"Hourly\" then 1ac.`total` * 24 * 30	  end,0)) as ac_total  FROM hb_accounts 1ac  LEFT JOIN hb_client_billing 1cb on (1ac.client_id=1cb.client_id)  WHERE 1ac.status = \'Active\' AND 1ac.billingcycle NOT IN (\'Free\', \'One Time\')  GROUP BY 1ac.client_id) ac  ON (ac.client_id = cd.id OR ac.client_id IS NULL)  LEFT JOIN ( SELECT 2ac.client_id, count(2ad.id) as ad_count_services,  SUM(COALESCE(case   when 2ad.billingcycle = \"Monthly\" then 2ad.recurring_amount  when 2ad.billingcycle = \"Quarterly\" then 2ad.recurring_amount / 3  when 2ad.billingcycle = \"Semi-Annually\" then 2ad.recurring_amount / 6  when 2ad.billingcycle = \"Annually\" then 2ad.recurring_amount / 12  when 2ad.billingcycle = \"Biennially\" then 2ad.recurring_amount / 24  when 2ad.billingcycle = \"Triennially\" then 2ad.recurring_amount / 36  when 2ad.billingcycle = \"Quadrennially\" then 2ad.recurring_amount / 48  when 2ad.billingcycle = \"Quinquennially\" then 2ad.recurring_amount / 60  when 2ad.billingcycle = \"Daily\" then 2ad.recurring_amount * 30  when 2ad.billingcycle = \"Weekly\" then 2ad.recurring_amount / 7 * 30  when 2ad.billingcycle = \"Hourly\" then 2ad.recurring_amount * 24 * 30	  end,0)) as ad_total  FROM hb_accounts_addons 2ad INNER JOIN hb_accounts 2ac on (2ac.id = 2ad.account_id)  LEFT JOIN hb_client_billing 2cb on (2ac.client_id=2cb.client_id)  WHERE 2ac.status = \'Active\' AND 2ac.billingcycle NOT IN (\'Free\', \'One Time\')  GROUP BY 2ac.client_id) ad  ON (ad.client_id = cd.id OR ad.client_id IS NULL)  LEFT JOIN ( SELECT 3am.client_id, count(3am.id) as am_count_services,  COALESCE(3am.recurring_amount/3am.period/12,0) as am_total  FROM hb_domains 3am  LEFT JOIN hb_client_billing 3cb on (3am.client_id=3cb.client_id)  WHERE 3am.status = \'Active\'  GROUP BY 3am.client_id) am  ON (am.client_id = cd.id OR am.client_id IS NULL)  ORDER BY cast(sql_normalize_currency(COALESCE(ac.ac_total,0) + COALESCE(ad.ad_total,0) + COALESCE(am.am_total,0),cb.currency_id,:currency,0) as decimal) DESC,  `Active Services` DESC LIMIT :limit', 1, 'sql', '', '', 'Monthly Turnover for all clients, normalized  by currency'),
(75003, 'Knowledgebase', '100 most viewed articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n\nFROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`views` DESC LIMIT 100', 1, 'sql', '', '', '100 most viewed articles'),
(75004, 'Knowledgebase', '100 Most upvoted articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n\nFROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`upvotes` DESC LIMIT 100', 1, 'sql', '', '', '100 Most upvoted articles'),
(75005, 'Knowledgebase', '100 Most downvoted articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n\nFROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`downvotes` DESC LIMIT 100', 1, 'sql', '', '', '100 Most downvoted articles'),
(75006, 'Knowledgebase', '100 least viewed articles', 'SELECT\r\n k.`title` as `Article name`,\r\n c.`name` as `Article category`,\r\n k.`views` as `View count`,\r\n k.`upvotes` as `Upvotes`,\r\n k.`downvotes` as `Downvotes`\r\n\nFROM hb_knowledgebase k\r\n JOIN hb_knowledgebase_cat c ON (c.id = k.cat_id)\r\n GROUP BY k.`id` ORDER BY k.`views` ASC LIMIT 100', 1, 'sql', '', '', '100 least viewed articles'),
(75007, 'Affiliates', 'Top affiliate visits within a period', ' SELECT a.id as `Affiliate ID`, concat(c.firstname,\' \',c.lastname) as `Affiliate name`, COUNT(al.id) as `Visits count`  FROM hb_aff_logs al  LEFT JOIN hb_aff a ON (al.aff_id = a.id)  LEFT JOIN hb_client_details c ON (a.client_id = c.id)  WHERE al.date >= :date_bottom  AND al.date <= :date_top  AND al.type = \'Visit\'  GROUP BY a.id  ORDER BY COUNT(al.id) DESC', 1, 'sql', '', '', NULL),
(75008, 'Affiliates', 'Top affiliate signups within a period', ' SELECT a.id as `Affiliate ID`, concat(c.firstname,\' \',c.lastname) as `Affiliate name`, COUNT(al.id) as `Signups count`  FROM hb_aff_logs al  LEFT JOIN hb_aff a ON (al.aff_id = a.id)  LEFT JOIN hb_client_details c ON (a.client_id = c.id)  WHERE al.date >= :date_bottom  AND al.date <= :date_top  AND al.type = \'Singup\'  GROUP BY a.id  ORDER BY COUNT(al.id) DESC', 1, 'sql', '', '', NULL),
(75009, 'Affiliates', '100 Top affiliates', ' SELECT a.id as `Affiliate ID`, concat(c.firstname,\' \',c.lastname) as `Affiliate name`, sql_currency(a.total_commissions,cb.currency_id,0) as `Total commissions`, sql_currency(a.total_withdrawn,cb.currency_id,0) as `Total withdrawn`, a.visits as `Total visits`  FROM hb_aff a  LEFT JOIN hb_client_details c ON (c.id = a.client_id)  LEFT JOIN hb_client_billing cb ON (c.id = cb.client_id)  WHERE c.id IS NOT NULL  ORDER BY a.id ASC', 1, 'sql', '', '', NULL),
(75010, 'Hidden', 'AffiliateWidget__Recent visits', ' SELECT r.range as `Day`, COALESCE(COUNT((t.id)),0) as `Total visits`  FROM hb_reports_day_range r  LEFT JOIN hb_aff_logs t ON (r.range = DAY(t.date) AND t.type = \"Visit\" AND t.aff_id = :affiliate_id  AND t.date >= :date_bottom  AND t.date <= :date_top)  WHERE r.range < 32 GROUP BY `Day`, DAY(t.date)  ORDER BY `Day` ASC', 1, 'sql', '', 'a:2:{i:0;s:3:\"Day\";i:1;s:12:\"Total visits\";}', NULL),
(75011, 'Hidden', 'AffiliateWidget__Recent signups', ' SELECT r.range as `Day`, COALESCE(COUNT((t.id)),0) as `Total signups`  FROM hb_reports_day_range r  LEFT JOIN hb_aff_logs t ON (r.range = DAY(t.date) AND t.type = \"Singup\" AND t.aff_id = :affiliate_id  AND t.date >= :date_bottom  AND t.date <= :date_top)  WHERE r.range < 32 GROUP BY `Day`, DAY(t.date)  ORDER BY `Day` ASC', 1, 'sql', '', 'a:2:{i:0;s:3:\"Day\";i:1;s:13:\"Total signups\";}', NULL),
(75012, 'Invoices', 'MOSS Summary Report', 'SELECT cd.country as `Country code`,\r\n i.taxrate as `VAT rate %`,\r\n COUNT(i.id) as `Invoices`,\r\n sql_currency(SUM(i.subtotal),:currency,0) as `Net amount`,\r\n sql_currency(SUM(i.tax),:currency,0) as `VAT collected` \r\nFROM hb_invoices i \r\nLEFT JOIN hb_client_details cd ON i.client_id = cd.id \r\nWHERE\r\n i.taxrate > 0 \r\nAND i.tax > 0 \r\nAND i.date > :date_bottom \r\nAND i.date < :date_top \r\nAND cd.country IN (\"BE\", \"BG\", \"CZ\", \"DK\", \"DE\", \"EE\", \"IE\", \"EL\", \"ES\", \"FR\", \"HR\", \"IT\", \"CY\", \"LV\", \"LT\", \"LU\", \"HU\", \"MT\", \"NL\", \"AT\", \"PL\", \"PT\", \"RO\", \"SI\", \"SK\", \"FI\", \"SE\") \r\nAND i.currency_id = :currency \r\nGROUP BY cd.country, i.taxrate \r\n\r\nORDER BY cd.country ASC, i.taxrate ASC', 0, 'sql', '', '', NULL),
(75013, 'Support', 'Time tracking entries', 'SELECT i.id AS `Entry ID`, i.admin AS `Admin`, t.ticket_number AS `Ticket Number`, i.`date` AS `Date Added`, i.`start` AS `Date Started`,\ni.`end` AS `Date Finished`, b.name AS `Rate Name`, i.`type` AS `Rate Type`, i.rate AS `Rate`,\nCASE\nWHEN  i.`status` = 0 THEN \"Draft\"\nWHEN  i.`status` = 1 THEN \"Billed\"\nWHEN  i.`status` = 2 THEN \"Pending\"\nWHEN  i.`status` = 3 THEN \"Cancelled\"\nWHEN  i.`status` = 4 THEN \"Billed External\"\nEND AS `Status`\nFROM hb_ticket_billing_items i\nJOIN hb_ticket_billing b ON (b.id = i.rate_id)\nLEFT JOIN hb_tickets t ON (t.id = i.ticket_id)\nWHERE i.`date`>= :date_bottom AND i.`date`<= :date_top', 1, 'sql', '', '', NULL),
(75014, 'Invoices', 'List of all invoices in given period for certain client group', 'SELECT i.id as `Invoice ID`,\r\n CONCAT(d.firstname,\' \',d.lastname) as `Client`,\r\n hb_currency(i.total,i.currency_id,i.rate) as `Invoice Total`,\r\n i.status as `Invoice Status`,\r\n CASE WHEN hbc.value = \'eu\' \r\nAND i.status = \'Paid\' THEN hb_date(i.datepaid) ELSE hb_date(i.date) END as `Invoice Date`,\r\n hb_currency(i.credit,i.currency_id,i.rate) as `Invoice Credit`,\r\n m.modname as `Gateway Name`,\r\n i.taxrate as `Tax1 rate`,\r\n i.taxrate2 as `Tax2 rate`,\r\n i.tax as `Tax1 Amount`,\r\n i.tax2 as `Tax2 Amount`,\r\n i.rate as `Exchange Rate`,\r\n hb_date(i.duedate) as `Invoice Due Date`,\r\n hb_date(i.datepaid) as `Invoice Paid Date`,\r\n t.trans_id as `Related transaction`,\r\n ca.email as `Client Email`,\r\n d.phonenumber as `Client Phone`,\r\n d.companyname as `Client Company`,\r\n d.city as `Client City`,\r\n d.country as `Client Country`,\r\n d.address1 as `Client Address`,\r\n d.postcode as `Client ZIP` \r\nFROM hb_invoices i \r\nINNER JOIN hb_client_details d ON (i.client_id = d.id) \r\nINNER JOIN hb_client_access ca ON (i.client_id = ca.id) \r\nLEFT JOIN hb_modules_configuration m ON (m.id = i.payment_module) \r\nLEFT JOIN hb_currencies c ON (c.id = i.currency_id) \r\nLEFT JOIN hb_transactions t ON (t.invoice_id = i.id) \r\nLEFT JOIN hb_configuration hbc ON hbc.setting = \'InvoiceModel\' \r\nWHERE\r\n ca.group_id = :group_id \r\nAND i.id NOT IN (SELECT invoice_id \r\nFROM hb_invoice_items \r\nWHERE\r\n `type` = \'Invoice\') \r\nAND i.status NOT IN (\'Draft\', \'Recurring\') \r\nAND i.`date` >= :date_bottom \r\nAND i.`date` <= :date_top \r\n\r\nORDER BY i.id ASC', 1, 'sql', 'a:3:{s:6:\"params\";a:3:{s:9:\":group_id\";s:1:\"0\";s:12:\":date_bottom\";s:21:\"{$current_year_start}\";s:9:\":date_top\";s:20:\"{$current_month_end}\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:7:{i:0;s:10:\"Invoice ID\";i:1;s:12:\"Gateway Name\";i:2;s:6:\"Client\";i:3;s:13:\"Invoice Total\";i:4;s:14:\"Invoice Status\";i:5;s:12:\"Invoice Date\";i:6;s:11:\"Client City\";}', 'List of all invoices in given period for certain client group'),
(75015, 'Invoices', 'Estimated Income This Month', 'report.estimatedincomethismonth.php', 0, 'php', 'a:3:{s:6:\"params\";N;s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:2:{i:0;s:8:\"Currency\";i:1;s:16:\"Estimated Income\";}', 'Estimated Income This Month'),
(75016, 'Invoices', 'Billable Products & their configuration items', 'report.billableproductsandconfigs.php', 0, 'php', 'a:3:{s:6:\"params\";N;s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:23:{i:0;s:4:\"Type\";i:1;s:2:\"id\";i:2;s:4:\"Name\";i:3;s:16:\"Belongs to: type\";i:4;s:14:\"Belongs to: id\";i:5;s:16:\"Belongs to: name\";i:6;s:6:\"status\";i:7;s:12:\"Billing type\";i:8;s:1:\"m\";i:9;s:7:\"m_setup\";i:10;s:9:\"m_upgrade\";i:11;s:1:\"q\";i:12;s:7:\"q_setup\";i:13;s:9:\"q_upgrade\";i:14;s:1:\"a\";i:15;s:7:\"a_setup\";i:16;s:9:\"a_upgrade\";i:17;s:1:\"b\";i:18;s:7:\"b_setup\";i:19;s:9:\"b_upgrade\";i:20;s:1:\"t\";i:21;s:7:\"t_setup\";i:22;s:9:\"t_upgrade\";}', 'Billable Products & their configuration items'),
(75017, 'Orders', 'Domain Contracts', 'SELECT cd.id as `Client ID`,\r\n cd.firstname as `Firstname`,\r\n cd.lastname as `Lastname`,\r\n cd.companyname as `Company`,\r\n o.id as `Order ID`,\r\n ct.id as `Contract Id`,\r\n ct.number as `Contract number`,\r\n ct.created_at as `Contract date`,\r\n ct.accepted_at as `Accepted at`,\r\n ct.expires as `Contract Expires`,\r\n ct.status as `Contract Status`,\r\n o.status as `Order Status`,\r\n ct.public_notes as `Contract Notes`,\r\n t.name as `Contract template name`,\r\n CONCAT(ccd.firstname,\' \',ccd.lastname) as `Accepted by`,\r\n d.id as `Domain ID`,\r\n d.name as `Domain`,\r\n d.status as `Domain Status`,\r\n p.name as `TLD`,\r\n c.name as `Orderpage name` \r\nFROM hb_order_contracts oc \r\nINNER JOIN hb_client_contracts ct ON oc.contract_id = ct.id \r\nINNER JOIN hb_contracts t ON t.id = ct.template_id \r\nINNER JOIN hb_orders o ON o.id = oc.order_id \r\nINNER JOIN hb_client_details cd ON cd.id = ct.client_id \r\nINNER JOIN hb_domains d ON d.order_id = o.id \r\nINNER JOIN hb_products p ON p.id = d.tld_id \r\nINNER JOIN hb_categories c ON c.id = p.category_id \r\nLEFT JOIN hb_client_details ccd ON ccd.id = ct.accepted_by \r\nWHERE\r\n ct.created_at >= :date_bottom \r\nAND ct.created_at <= :date_top', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:22:\"{$current_month_start}\";s:9:\":date_top\";s:20:\"{$current_month_end}\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:20:{i:0;s:9:\"Client ID\";i:1;s:9:\"Firstname\";i:2;s:8:\"Lastname\";i:3;s:7:\"Company\";i:4;s:8:\"Order ID\";i:5;s:11:\"Contract Id\";i:6;s:15:\"Contract number\";i:7;s:13:\"Contract date\";i:8;s:11:\"Accepted at\";i:9;s:16:\"Contract Expires\";i:10;s:15:\"Contract Status\";i:11;s:12:\"Order Status\";i:12;s:14:\"Contract Notes\";i:13;s:22:\"Contract template name\";i:14;s:11:\"Accepted by\";i:15;s:9:\"Domain ID\";i:16;s:3:\"TLD\";i:17;s:6:\"Domain\";i:18;s:13:\"Domain Status\";i:19;s:14:\"Orderpage name\";}', 'Domain Contracts'),
(75018, 'Orders', 'Account Contracts', 'SELECT cd.id as `Client ID`,\r\n cd.firstname as `Firstname`,\r\n cd.lastname as `Lastname`,\r\n cd.companyname as `Company`,\r\n o.id as `Order ID`,\r\n ct.id as `Contract Id`,\r\n ct.number as `Contract number`,\r\n ct.created_at as `Contract date`,\r\n ct.accepted_at as `Accepted at`,\r\n ct.expires as `Contract Expires`,\r\n ct.status as `Contract Status`,\r\n o.status as `Order Status`,\r\n ct.public_notes as `Contract Notes`,\r\n t.name as `Contract template name`,\r\n CONCAT(ccd.firstname,\' \',ccd.lastname) as `Accepted by`,\r\n a.id as `Account ID`,\r\n a.status as `Account Status`,\r\n p.id as `Product ID`,\r\n p.name as `Product Name`,\r\n c.name as `Orderpage name` \r\nFROM hb_order_contracts oc \r\nINNER JOIN hb_client_contracts ct ON oc.contract_id = ct.id \r\nINNER JOIN hb_contracts t ON t.id = ct.template_id \r\nINNER JOIN hb_orders o ON o.id = oc.order_id \r\nINNER JOIN hb_client_details cd ON cd.id = ct.client_id \r\nINNER JOIN hb_accounts a ON a.order_id = o.id \r\nINNER JOIN hb_products p ON p.id = a.product_id \r\nINNER JOIN hb_categories c ON c.id = p.category_id \r\nLEFT JOIN hb_client_details ccd ON ccd.id = ct.accepted_by \r\nWHERE\r\n ct.created_at >= :date_bottom \r\nAND ct.created_at <= :date_top', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:22:\"{$current_month_start}\";s:9:\":date_top\";s:20:\"{$current_month_end}\";}s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:20:{i:0;s:9:\"Client ID\";i:1;s:9:\"Firstname\";i:2;s:8:\"Lastname\";i:3;s:7:\"Company\";i:4;s:8:\"Order ID\";i:5;s:11:\"Contract Id\";i:6;s:15:\"Contract number\";i:7;s:13:\"Contract date\";i:8;s:11:\"Accepted at\";i:9;s:16:\"Contract Expires\";i:10;s:15:\"Contract Status\";i:11;s:12:\"Order Status\";i:12;s:14:\"Contract Notes\";i:13;s:22:\"Contract template name\";i:14;s:11:\"Accepted by\";i:15;s:10:\"Account ID\";i:16;s:14:\"Account Status\";i:17;s:10:\"Product ID\";i:18;s:14:\"Orderpage name\";i:19;s:12:\"Product Name\";}', 'Account Contracts');
##########
CREATE TABLE `hb_reports_day_range` (
  `range` int(11) NOT NULL,
  `month` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`range`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_reports_day_range` (`range`, `month`) VALUES
(1, 'January'),
(2, 'February'),
(3, 'March'),
(4, 'April'),
(5, 'May'),
(6, 'June'),
(7, 'July'),
(8, 'August'),
(9, 'September'),
(10, 'October'),
(11, 'November'),
(12, 'December'),
(13, ''),
(14, ''),
(15, ''),
(16, ''),
(17, ''),
(18, ''),
(19, ''),
(20, ''),
(21, ''),
(22, ''),
(23, ''),
(24, ''),
(25, ''),
(26, ''),
(27, ''),
(28, ''),
(29, ''),
(30, ''),
(31, '');
##########
CREATE TABLE `hb_reports_snapshots` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT 'default',
  `frequency` enum('Demand','Daily','Weekly','Monthly') NOT NULL DEFAULT 'Demand',
  `day` int(11) DEFAULT NULL,
  `time` tinytext,
  `target` enum('None','Filesystem','Email') NOT NULL DEFAULT 'None',
  `target_ids` text NOT NULL,
  `data_to_retain` int(11) NOT NULL DEFAULT '0',
  `state` text NOT NULL,
  `columns` text NOT NULL,
  `generated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_reports_snapshots_data` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `snapshot_id` int(11) NOT NULL,
  `data` longtext,
  `email_sent` int(1) NOT NULL DEFAULT '0',
  `attachment` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `snapshot_id` (`snapshot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_reports_widget` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `report_id` int(11) NOT NULL,
  `name` varchar(127) NOT NULL DEFAULT '',
  `type` varchar(127) NOT NULL DEFAULT '',
  `cache` int(3) NOT NULL DEFAULT '1',
  `cache_unit` enum('minutes','hours','days') NOT NULL DEFAULT 'hours',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=21002 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_reports_widget` (`id`, `report_id`, `name`, `type`, `cache`, `cache_unit`) VALUES
(1, 1000, 'Daily income', 'line-chart', 1, 'hours'),
(2, 1001, 'Monthly income', 'bar-chart', 1, 'hours'),
(4, 1002, 'New tickets monthly', 'bar-chart', 1, 'hours'),
(5, 1003, 'New tickets daily', 'bar-chart', 1, 'hours'),
(6, 30, 'Product sales', 'bar-chart', 1, 'hours'),
(50, 2000, 'Monthly cumulative income', 'bar-chart', 1, 'hours'),
(51, 2001, 'Daily cumulative income', 'line-chart', 1, 'hours'),
(52, 2007, 'EU: Income minus tax', 'metric', 1, 'hours'),
(21000, 75000, 'Past month performance', 'line-chart', 1, 'hours'),
(21001, 75000, 'Current month performance', 'line-chart', 1, 'hours');
##########
CREATE TABLE `hb_reports_widget_series` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `reports_widget_id` int(11) NOT NULL,
  `state` text NOT NULL,
  `columns` text NOT NULL,
  `name` varchar(127) NOT NULL DEFAULT 'default',
  `sort_order` int(3) DEFAULT '0',
  `color` varchar(10) DEFAULT NULL,
  `snapshot_data_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_widget_id` (`reports_widget_id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_reports_widget_series` (`id`, `reports_widget_id`, `state`, `columns`, `name`, `sort_order`, `color`, `snapshot_data_id`) VALUES
(1, 1, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:18:\"previous-month-end\";s:12:\":date_bottom\";s:20:\"previous-month-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Previous month', 1, NULL, NULL),
(2, 1, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:17:\"current-month-end\";s:12:\":date_bottom\";s:19:\"current-month-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Current month', 2, NULL, NULL),
(3, 2, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:17:\"previous-year-end\";s:12:\":date_bottom\";s:19:\"previous-year-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'Last Year', 3, NULL, NULL),
(4, 2, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:16:\"current-year-end\";s:12:\":date_bottom\";s:18:\"current-year-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'This Year', 4, NULL, NULL),
(5, 6, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:12:\"Product Name\";i:1;s:10:\"Items Sold\";}', 'Last month', 5, NULL, NULL),
(6, 6, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:12:\"Product Name\";i:1;s:10:\"Items Sold\";}', 'This month', 6, NULL, NULL),
(7, 4, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:17:\"previous-year-end\";s:12:\":date_bottom\";s:19:\"previous-year-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:7:\"Tickets\";}', 'Last Year', 7, NULL, NULL),
(8, 4, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:16:\"current-year-end\";s:12:\":date_bottom\";s:18:\"current-year-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:7:\"Tickets\";}', 'This Year', 8, NULL, NULL),
(9, 5, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:18:\"previous-month-end\";s:12:\":date_bottom\";s:20:\"previous-month-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:7:\"Tickets\";}', 'Last month', 9, NULL, NULL),
(10, 5, 'a:3:{s:6:\"params\";a:2:{s:9:\":date_top\";s:17:\"current-month-end\";s:12:\":date_bottom\";s:19:\"current-month-start\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:7:\"Tickets\";}', 'This month', 10, NULL, NULL),
(100, 51, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Previous Month', 100, NULL, NULL),
(101, 51, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:6:\"Income\";}', 'Current Month', 101, NULL, NULL),
(102, 50, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"previous-year-start\";s:9:\":date_top\";s:17:\"previous-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'Last Year', 102, NULL, NULL),
(103, 50, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:18:\"current-year-start\";s:9:\":date_top\";s:16:\"current-year-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:5:\"Month\";i:1;s:6:\"Income\";}', 'This Year', 103, NULL, NULL),
(104, 52, 'a:3:{s:6:\"params\";N;s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:3:{i:0;s:9:\"This Year\";i:1;s:10:\"This Month\";i:2;s:5:\"Today\";}', 'EU: Daily income minus tax', 104, NULL, NULL),
(105, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:10:\"New orders\";}', 'New orders', 105, NULL, NULL),
(106, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:8:\"Invoices\";}', 'Invoices', 106, NULL, NULL),
(107, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:13:\"Paid Invoices\";}', 'Paid invoices', 107, NULL, NULL),
(108, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:13:\"Ticked opened\";}', 'Ticked opened', 108, NULL, NULL),
(109, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:16:\"Ticked responses\";}', 'Ticked responses', 109, NULL, NULL),
(110, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:20:\"Cancelation requests\";}', 'Cancelation requests', 110, NULL, NULL),
(111, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:14:\"Accounts added\";}', 'Accounts added', 111, NULL, NULL),
(112, 21000, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:20:\"previous-month-start\";s:9:\":date_top\";s:18:\"previous-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:13:\"Domains added\";}', 'Domains added', 112, NULL, NULL),
(113, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:10:\"New orders\";}', 'New orders', 113, NULL, NULL),
(114, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:8:\"Invoices\";}', 'Invoices', 114, NULL, NULL),
(115, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:13:\"Paid Invoices\";}', 'Paid invoices', 115, NULL, NULL),
(116, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:13:\"Ticked opened\";}', 'Ticked opened', 116, NULL, NULL),
(117, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:16:\"Ticked responses\";}', 'Ticked responses', 117, NULL, NULL),
(118, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:20:\"Cancelation requests\";}', 'Cancelation requests', 118, NULL, NULL),
(119, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:14:\"Accounts added\";}', 'Accounts added', 119, NULL, NULL),
(120, 21001, 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:19:\"current-month-start\";s:9:\":date_top\";s:17:\"current-month-end\";}s:10:\"conditions\";a:1:{i:0;a:3:{s:6:\"column\";s:0:\"\";s:8:\"operator\";s:1:\">\";s:8:\"constant\";s:0:\"\";}}s:6:\"output\";N;}', 'a:2:{i:0;s:3:\"Day\";i:1;s:13:\"Domains added\";}', 'Domains added', 120, NULL, NULL);
##########
CREATE TABLE `hb_report_groups` (
  `name` varchar(60) NOT NULL,
  `access` varchar(60) NOT NULL,
  `customize` varchar(60) NOT NULL,
  `options` int(3) DEFAULT '1',
  `sort_order` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_report_groups` (`name`, `access`, `customize`, `options`, `sort_order`) VALUES
('Affiliates', 'accessReportsAffiliates', 'customizeReportsAffiliates', 0, 1),
('Clients', 'accessReportsClients', 'customizeReportsClients', 0, 2),
('Custom', 'accessReportsCustom', 'customizeReportsCustom', 0, 0),
('Invoices', 'accessReportsInvoices', 'customizeReportsInvoices', 0, 3),
('Knowledgebase', 'accessReportsKnowledgebase', 'customizeReportsKnowledgebase', 0, 4),
('Orders', 'accessReportsOrders', 'customizeReportsOrders', 0, 5),
('Staff', 'accessReportsStaff', 'customizeReportsStaff', 0, 6),
('Support', 'accessReportsSupport', 'customizeReportsSupport', 0, 7);
##########
CREATE TABLE `hb_security_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rule` varchar(128) NOT NULL,
  `action` enum('allow','deny') NOT NULL DEFAULT 'allow',
  `target` enum('admin','user') NOT NULL DEFAULT 'admin',
  `target_id` int(11) NOT NULL,
  `options` tinyint(4) NOT NULL DEFAULT '0',
  `description` text,
  PRIMARY KEY (`id`),
  KEY `reule` (`rule`),
  KEY `target_id` (`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_servers` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `default` tinyint(1) NOT NULL DEFAULT '0',
  `name` text NOT NULL,
  `username` varchar(128) NOT NULL,
  `password` text NOT NULL,
  `ip` text NOT NULL,
  `host` text NOT NULL,
  `status_url` text NOT NULL,
  `ns1` varchar(128) NOT NULL,
  `ns2` varchar(128) NOT NULL,
  `ns3` varchar(128) NOT NULL,
  `ns4` varchar(128) NOT NULL,
  `ns5` varchar(128) DEFAULT NULL,
  `ns6` varchar(128) DEFAULT NULL,
  `ns7` varchar(128) DEFAULT NULL,
  `ns8` varchar(128) DEFAULT NULL,
  `ns9` varchar(128) DEFAULT NULL,
  `ns10` varchar(128) DEFAULT NULL,
  `ip1` varchar(128) NOT NULL,
  `ip2` varchar(128) NOT NULL,
  `ip3` varchar(128) NOT NULL,
  `ip4` varchar(128) NOT NULL,
  `ip5` varchar(128) DEFAULT NULL,
  `ip6` varchar(128) DEFAULT NULL,
  `ip7` varchar(128) DEFAULT NULL,
  `ip8` varchar(128) DEFAULT NULL,
  `ip9` varchar(128) DEFAULT NULL,
  `ip10` varchar(128) DEFAULT NULL,
  `max_accounts` int(11) NOT NULL DEFAULT '0',
  `default_module` int(11) NOT NULL,
  `hash` text NOT NULL,
  `secure` tinyint(1) NOT NULL DEFAULT '0',
  `enable` tinyint(1) NOT NULL DEFAULT '1',
  `field1` text NOT NULL,
  `field2` text NOT NULL,
  `custom` text NOT NULL,
  `monthly_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `def` (`default_module`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_server_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL DEFAULT '',
  `module` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_sign_agreement` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` int(11) UNSIGNED NOT NULL,
  `cart` varchar(127) NOT NULL DEFAULT '',
  `hash` varchar(32) NOT NULL DEFAULT '',
  `type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `type_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `agree` tinyint(1) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `metadata` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hash` (`hash`),
  KEY `client_id` (`client_id`),
  KEY `type` (`type`,`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ssh_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `key` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_subproducts` (
  `product_id` int(11) NOT NULL,
  `subproduct_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`subproduct_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_subscription_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subscr_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `type` enum('Hosting','Addon','Other') NOT NULL,
  `description` text NOT NULL,
  `next_date` date NOT NULL,
  `period` int(2) NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `invoice_id` int(11) NOT NULL,
  `gateway_subid` text NOT NULL,
  `gateway_name` text NOT NULL,
  `gateway_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subscr_id` (`subscr_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `client_id` (`client_id`),
  KEY `gateway_id` (`gateway_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_system_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `what` text NOT NULL,
  `who` varchar(128) NOT NULL,
  `type` varchar(32) NOT NULL DEFAULT 'none',
  `item_id` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag` varchar(128) NOT NULL,
  `color` varchar(8) DEFAULT '#03a9f4',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag` (`tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tags_items` (
  `tag_id` int(11) NOT NULL,
  `rel` enum('Product','Account','Domain','Knowledgebase') NOT NULL DEFAULT 'Product',
  `rel_id` int(11) NOT NULL,
  PRIMARY KEY (`tag_id`,`rel`,`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_task_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task` varchar(128) NOT NULL,
  `when` enum('before','after') NOT NULL DEFAULT 'before',
  `event` varchar(128) NOT NULL,
  `interval` int(11) NOT NULL DEFAULT '0',
  `interval_type` enum('DAY','HOUR','MINUTE') NOT NULL DEFAULT 'DAY',
  `rel_type` enum('Hosting','Addon','Ticket','Domain','SingleHosting','SingleDomain') NOT NULL DEFAULT 'Hosting',
  `rel_id` int(11) NOT NULL DEFAULT '0',
  `action_config` text NOT NULL,
  `conditions` text,
  PRIMARY KEY (`id`),
  KEY `when` (`when`,`event`,`interval`),
  KEY `rel_type` (`rel_type`,`rel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_task_list` (`id`, `task`, `when`, `event`, `interval`, `interval_type`, `rel_type`, `rel_id`, `action_config`, `conditions`) VALUES
(1, 'nan', 'before', 'AccountSuspend', 0, 'DAY', 'Hosting', 0, '', NULL),
(2, 'nan', 'before', 'AccountTerminate', 0, 'DAY', 'Hosting', 0, '', NULL);
##########
CREATE TABLE `hb_task_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `task_id` int(11) NOT NULL,
  `rel_type` enum('Hosting','Addon','Domain','SingleHosting','SingleDomain') NOT NULL DEFAULT 'Hosting',
  `rel_id` int(11) NOT NULL,
  `date_created` datetime NOT NULL,
  `date_execute` datetime NOT NULL,
  `status` enum('Pending','OK','Failed','Canceled','Expired','Archived') NOT NULL DEFAULT 'Pending',
  `log` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`,`status`),
  KEY `rel_type` (`rel_type`,`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rate` decimal(10,2) NOT NULL DEFAULT '0.00',
  `type` enum('L1','L2') NOT NULL,
  `name` varchar(128) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `state` text NOT NULL,
  `country` varchar(2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `country` (`country`),
  KEY `state` (`state`(2)),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tax_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_tax_group` (`id`, `name`, `description`) VALUES
(1, 'Standard', 'Default group');
##########
CREATE TABLE `hb_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `target` enum('admin','user','invoice','estimate','creditnote','creditreceipt','contract','attachment','accountstatement') NOT NULL DEFAULT 'invoice',
  `metadata` text,
  `created` datetime NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `KEY` (`parent_id`),
  KEY `KEY2` (`name`),
  KEY `KEY3` (`target`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_templates` (`id`, `parent_id`, `name`, `target`, `metadata`, `created`, `updated`) VALUES
(1, 0, 'Default', 'invoice', NULL, '2011-12-06 00:00:00', '2011-12-06 00:00:00'),
(100, 0, 'EU Invoicing', 'invoice', NULL, '2013-05-16 03:30:01', '2013-05-16 03:30:01'),
(101, 0, 'Default', 'estimate', NULL, '2013-05-21 00:00:00', '2013-05-21 00:00:00'),
(102, 0, 'Default', 'creditnote', NULL, '2013-10-17 10:25:44', '2013-10-17 10:25:44'),
(103, 0, 'Default', 'creditreceipt', NULL, '2022-06-09 08:55:16', '2022-06-09 08:55:16'),
(104, 0, 'GDPRDetails', 'admin', NULL, '2022-06-09 08:55:28', '2022-06-09 08:55:28'),
(105, 0, 'Order Summary', 'attachment', NULL, '2022-06-09 08:56:10', '2022-06-09 08:56:10'),
(106, 0, 'Default Account Statement', 'accountstatement', NULL, '2022-06-09 08:56:36', '2022-06-09 08:56:36');
##########
CREATE TABLE `hb_template_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `content` longtext NOT NULL,
  `checksum` varchar(32) NOT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `KEY` (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_template_content` (`id`, `template_id`, `name`, `content`, `checksum`, `updated`) VALUES
(1, 1, 'Default', '<style type=\"text/css\">\r\n    body {\r\n        font-family: Arial;\r\n    }\r\n</style>\r\n<div style=\"padding:40px;font-family: Arial;\" id=\"invoice-table\">\r\n    <table border=\"0\" cellspacing=\"0\" width=\"100%\">\r\n        <tbody>\r\n            <tr id=\"invoice-header\">\r\n                <td width=\"66%\" valign=\"middle\" align=\"left\" colspan=\"2\" style=\"padding-left:10px\">\r\n                    <span style=\"font-size:18px;font-weight:bold;color:#484740;\">{$companylogo}</span>\r\n                    <span style=\"font-size:18px;font-weight:bold;color:#A4A4A4\">{$invoice.number}</span>\r\n                </td>\r\n                \r\n                <td valign=\"middle\" align=\"right\">\r\n                    <table cellpadding=\"2\"  cellspacing=\"0\" border=\"0\">\r\n                        <tr>\r\n                            <td align=\"right\"><span style=\"font-size:12px;font-weight:bold\">{$lang.invoice}</span></td>\r\n                            <td align=\"left\"><span style=\"font-size:12px\">{$invoice.id}</span></td>\r\n                        </tr>\r\n                        <tr>\r\n                            <td align=\"right\"><span style=\"font-size:12px;font-weight:bold\">{$lang.invoice_date}</span></td>\r\n                            <td align=\"left\"><span style=\"font-size:12px\">{$invoice.date}</span></td>\r\n                        </tr>\r\n                        <tr>\r\n                            <td align=\"right\"><span style=\"font-size:12px;font-weight:bold\">{$lang.invoice_due}</span></td>\r\n                            <td align=\"left\"><span style=\"font-size:12px\">{$invoice.duedate}</span></td>\r\n                        </tr>\r\n                    </table>\r\n\r\n                </td>\r\n            </tr>\r\n\r\n\r\n            <tr id=\"invoice-details\">\r\n                <td valign=\"top\" style=\"padding-top:40px\" width=\"33%\">\r\n                    <span style=\"font-size:12px;font-weight:bold;\">{$lang.invoice_to}</span><br/>\r\n                    <span style=\"font-size:11px\">{$client.companyname}<br/>\r\n                        {$client.firstname} {$client.lastname}<br />\r\n                        {$client.address1} <br />\r\n                        {$client.address2}<br />\r\n                        {$client.city}, {$client.state}{$client.postcode}<br />\r\n                        {$client.country}\r\n                    </span>\r\n\r\n                </td>\r\n                <td valign=\"top\"  style=\"padding-top:40px\" width=\"33%\">\r\n                    <span style=\"font-size:12px;font-weight:bold;\">{$lang.invoice_from}</span><br/>\r\n                    <span style=\"font-size:11px\">{$invoicefrom}</span>\r\n                </td>\r\n                <td valign=\"top\"  style=\"padding-top:40px\" align=\"left\"  width=\"33%\">\r\n                    <table cellpadding=\"2\"  cellspacing=\"0\" border=\"0\">\r\n                        <tr>\r\n                            <td align=\"right\"><span style=\"font-size:12px;font-weight:bold;\">{$lang.status}:</span></td>\r\n                            <td align=\"left\"><span style=\"font-size:12px;font-weight:bold;\">{$invoice.status}</span></td>\r\n                        </tr>\r\n                        <tr>\r\n                            <td align=\"right\"><span style=\"font-size:12px;font-weight:bold;\">{$lang.balance}:</span></td>\r\n                            <td align=\"left\"><span style=\"font-size:12px;font-weight:bold;\">{$transbalance}</span></td>\r\n                        </tr>\r\n                    </table>\r\n                </td>\r\n            </tr>\r\n\r\n        </tbody>\r\n    </table>\r\n\r\n\r\n\r\n    <table class=\"invoice-table\" width=\"100%\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\" style=\"margin-top:50px;width:100%;\">\r\n        <tbody>\r\n            <tr>\r\n                <td  align=\"left\" bgcolor=\"#f0f0f0\"  valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.invoice_desc}</span></td>\r\n                <td style=\"width:7%\"  align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.invoice_tax}</span></td>\r\n                <td style=\"width:15%\"  align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.unitcost}</span></td>\r\n                <td style=\"width:7%\"  align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.qty}</span></td>\r\n                <td style=\"width:15%\"  align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.price}</span></td>\r\n            </tr>\r\n\r\n\r\n            <tr>\r\n                <td style=\"border-bottom: 1px solid #F0F0F0;\"  valign=\"middle\" ><span style=\"font-size:11px\">{$item.description}</span></td>\r\n                <td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\"  valign=\"middle\" ><span style=\"font-size:11px\">{$item.taxed}</span></td>\r\n                <td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\"  valign=\"middle\" ><span style=\"font-size:11px\">{$item.amount}</span></td>\r\n                <td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\"  valign=\"middle\" ><span style=\"font-size:11px\">{$item.qty}</span></td>\r\n                <td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\"  valign=\"middle\" ><span style=\"font-size:11px\">{$item.linetotal}</span></td>\r\n            </tr>\r\n\r\n            <tr>\r\n                <td class=\"\"></td>\r\n                <td align=\"right\" colspan=\"2\"  valign=\"middle\" ><span style=\"font-size:12px;font-weight:bold;\">{$lang.subtotal}</span></td>\r\n                <td align=\"right\" colspan=\"2\"   valign=\"middle\" ><span style=\"font-size:12px\">{$invoice.subtotal}</span></td>\r\n            </tr>\r\n            <tr>\r\n                <td class=\"\"></td>\r\n                <td align=\"right\" colspan=\"2\"  valign=\"middle\" ><span style=\"font-size:12px;font-weight:bold;\">{$lang.credit}</span></td>\r\n                <td align=\"right\" colspan=\"2\"   valign=\"middle\" ><span style=\"font-size:12px\">{$invoice.credit}</span></td>\r\n            </tr>\r\n\r\n            <tr>\r\n                <td class=\"\"></td>\r\n                <td align=\"right\" colspan=\"2\"  valign=\"middle\" ><span style=\"font-size:12px;font-weight:bold;\">{$lang.tax} ({$invoice.taxrate}%)</span></td>\r\n                <td align=\"right\" colspan=\"2\"  valign=\"middle\" ><span style=\"font-size:12px\">{$invoice.tax}</span></td>\r\n            </tr>\r\n\r\n            <tr>\r\n                <td class=\"\"></td>\r\n                <td align=\"right\" colspan=\"2\"   valign=\"middle\" ><span style=\"font-size:12px;font-weight:bold;\">{$lang.tax} ({$invoice.taxrate2}%)</span></td>\r\n                <td align=\"right\" colspan=\"2\"  valign=\"middle\" ><span style=\"font-size:12px\">{$invoice.tax2}</span></td>\r\n            </tr>\r\n\r\n\r\n            <tr>\r\n                <td class=\"\"></td>\r\n                <td align=\"right\" colspan=\"2\"  valign=\"middle\" ><span style=\"font-size:14px; font-weight:bold;\">{$lang.total}</span></td>\r\n                <td align=\"right\" colspan=\"2\"   valign=\"middle\" ><span style=\"font-size:14px; font-weight:bold;\">{$invoice.total}</span></td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n\r\n\r\n    <table  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  style=\"margin-top:50px;\">\r\n        <tr><td align=\"left\"  valign=\"middle\" style=\"width:100%\">\r\n                <span style=\"font-size:11px;\"><em>{$invoice.notes}</em></span>\r\n            </td></tr>\r\n    </table>\r\n\r\n\r\n\r\n    <table class=\"invoice-table-transaction\" width=\"100%\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\" style=\"margin-top:50px;\">\r\n        <tbody>\r\n            <tr>\r\n                <td colspan=\"4\" style=\"width:100%\">\r\n                    <span style=\"font-size:11px;font-weight:bold;\">{$lang.related_trans}</span>\r\n                </td>\r\n            </tr>\r\n            <tr>\r\n                <td   bgcolor=\"#f0f0f0\" align=\"left\"   valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.trans_date}</span></td>\r\n                <td  align=\"center\" bgcolor=\"#f0f0f0\"   valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.trans_gtw}</span></td>\r\n                <td  align=\"center\" bgcolor=\"#f0f0f0\"   valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.trans_id}</span></td>\r\n                <td  align=\"right\" bgcolor=\"#f0f0f0\"   valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold\">{$lang.trans_amount}</span></td>\r\n            </tr>\r\n            <tr>\r\n                <td align=\"left\"  valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size:11px\">{$transaction.date}</span></td>\r\n                <td align=\"center\"   valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size:11px\">{$transaction.module}</span></td>\r\n                <td align=\"center\"   valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size:11px\">{$transaction.trans_id}</span></td>\r\n                <td align=\"right\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size:11px\">{$transaction.amount}</span></td>\r\n            </tr>\r\n            <tr>\r\n                <td class=\"\" ></td>\r\n                <td class=\"\"></td>\r\n                <td align=\"right\"   valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold;\">{$lang.balance}</span></td>\r\n                <td  align=\"right\"   valign=\"middle\" ><span style=\"font-size:11px;font-weight:bold;\">{$transbalance}</span></td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n\r\n\r\n    <table  width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  style=\"margin-top:50px;\">\r\n        <tr><td align=\"center\" style=\"border-top:1px solid #F0F0F0;padding-top:10px;width:100%\">\r\n                <span style=\"font-size:11px;color:#A4A4A4\">{$invoiceFooter}</span>\r\n            </td></tr>\r\n    </table>\r\n</div>', 'd41d8cd98f00b204e9800998ecf8427e', '2011-12-06 00:00:00'),
(100, 100, 'EU Invoicing', '<style type=\"text/css\"><!--\r\n    body {\r\n        font-family: Verdana, Arial, Helvetica;\r\n    }\r\n    #invoice-content #invoice-table {\r\n        padding-top:40px !important;\r\n    }\r\n    .fs_11 {\r\n        font-size:11px;\r\n    }\r\n    #invoice-items-table{\r\n        border-collapse: collapse;\r\n    }\r\n    .fullborder {\r\n        border:solid 1px #000;\r\n    }\r\n    .rowspace td {\r\n        height:2px;padding:0px;\r\n    }\r\n    .doubleborder {\r\n        border:solid 2px #000; font-weight:bold;\r\n    }\r\n    .noborder {\r\n        border:none;\r\n    }\r\n--></style>\r\n<div id=\"invoice-table\" style=\"padding: 20px; font-family: Verdana, Arial, Helvetica;\">\r\n<table style=\"width: 100%; margin-bottom: 20px;\" border=\"0\" cellspacing=\"0\">\r\n<tbody>\r\n<tr id=\"invoicetitle\">\r\n<td style=\"border-bottom: solid 1px #000;\" colspan=\"3\" align=\"right\" valign=\"middle\" width=\"66%\"><em style=\"font-size: 18px; font-weight: bold;\">{$invoice.number}</em></td>\r\n</tr>\r\n<tr id=\"invoice-dateinfo\">\r\n<td class=\"fs_11\" colspan=\"3\" align=\"right\">{$lang.original}<br />{$lang.invoice_date}: {$invoice.date}</td>\r\n</tr>\r\n<tr id=\"invoice-spacer\">\r\n<td colspan=\"3\">&nbsp;</td>\r\n</tr>\r\n<tr id=\"invoice-details\">\r\n<td style=\"border: solid 1px #000;\" valign=\"top\" width=\"45%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_from}</span></td>\r\n<td align=\"left\" valign=\"top\" width=\"10%\">&nbsp;</td>\r\n<td style=\"border: solid 1px #000;\" valign=\"top\" width=\"45%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_to}</span> <br /> <span style=\"font-size: 11px;\">{if $client.companyname}{$client.companyname}, {/if}{$client.firstname} {$client.lastname}<br /> {$client.address1} {if $client.address2}, {$client.address2}{/if}{if $client.postcode}, {$client.postcode}{/if} {$client.city} {if $client.country}, {$client.country}{/if}{if $client.vateu}<br />{$lang.vateu}: {$client.vateu}{/if}</span></td>\r\n</tr>\r\n<tr id=\"invoice-spacer\">\r\n<td colspan=\"3\">&nbsp;</td>\r\n</tr>\r\n<tr id=\"invoice-payinfo\">\r\n<td class=\"fs_11\" colspan=\"3\" align=\"left\">{$lang.paymethod}: {$invoice.paymentgw}<br /> {$lang.dateofsale}: {$invoice.date}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<span style=\"font-size: 11px;\">{foreach from=$transactions item=trans}{$lang.trans_id} {$trans.trans_id}{break}{/foreach}</span>{if $invoice.notes}{/if}\r\n<table id=\"invoice-items-table\" class=\"invoice-table\" style=\"width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"6\">\r\n<tbody>\r\n<tr>\r\n<td class=\"fullborder\" align=\"left\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_desc}</span></td>\r\n<td class=\"fullborder\" style=\"width: 8%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.qty}</span></td>\r\n<td class=\"fullborder\" style=\"width: 11%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.unitcost}</span></td>\r\n<td class=\"fullborder\" style=\"width: 11%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.netprice}</span></td>\r\n<td class=\"fullborder\" style=\"width: 8%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.tax}</span></td>\r\n<td class=\"fullborder\" style=\"width: 11%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.taxamount}</span></td>\r\n<td class=\"fullborder\" style=\"width: 11%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.grossprice}</span></td>\r\n</tr>\r\n<tr>\r\n<td class=\"fullborder\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.description}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.qty}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.amount}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.linetotal}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{if !$item.tax_rate}{$lang.nottaxed}{else}{$item.tax_rate}%{/if}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.tax_amount}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.linetaxed}</span></td>\r\n</tr>\r\n<tr>\r\n<td colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoicedue}: {$invoice.total}</span></td>\r\n<td align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.total}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$invoice.subtotal}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\">&nbsp;</td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$invoice.tax}</span></td>\r\n<td class=\"doubleborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$invoice.total}</span></td>\r\n</tr>\r\n<tr class=\"rowspace\">\r\n<td colspan=\"7\">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td colspan=\"2\" valign=\"middle\">&nbsp;</td>\r\n<td align=\"right\" valign=\"middle\">{if $smarty.foreach.taxloop.first}<span style=\"font-size: 12px; font-weight: bold;\">{$lang.including}</span>{/if}</td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$taxitm.subtotal}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{if !$taxitm.name}{$lang.nottaxed}{else}{$taxitm.name}{/if}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$taxitm.tax}</span></td>\r\n<td class=\"fullborder\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$taxitm.total}</span></td>\r\n</tr>\r\n<tr>\r\n<td style=\"font-size: 12px;\" colspan=\"3\" valign=\"middle\">{$lang.Paid}: {$totalpaid}<br /> {$lang.leftunpaid}: {$transbalance}</td>\r\n<td colspan=\"4\" valign=\"middle\">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td colspan=\"3\" valign=\"middle\">&nbsp;</td>\r\n<td style=\"font-size: 11px; border: solid 1px #000;\" colspan=\"4\" valign=\"middle\">{$lang.notes}<br />{$invoice.notes}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 100%;\" align=\"left\" valign=\"middle\"><span style=\"font-size: 11px;\">{$lang.pdfagreement}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"border-top: 1px solid #F0F0F0; padding-top: 10px; width: 100%;\" align=\"right\"><span style=\"font-size: 11px; color: #a4a4a4;\">Invoice footer text</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>', 'b3d83359bb9fd7290243d07b6a9a8176', '2013-05-16 13:04:47'),
(101, 101, 'Default', '<style type=\"text/css\"><!--\r\n        body {\r\n            font-family: Arial;\r\n        }\r\n--></style>\r\n<div id=\"invoice-table\" style=\"padding: 40px; font-family: Arial;\">\r\n<table style=\"width: 100%;\" border=\"0\" cellspacing=\"0\">\r\n<tbody>\r\n<tr id=\"invoice-header\">\r\n<td style=\"padding-left: 10px;\" colspan=\"2\" align=\"left\" valign=\"middle\" width=\"66%\"><span style=\"font-size: 18px; font-weight: bold; color: #484740;\">{$companylogo}</span> <span style=\"font-size: 18px; font-weight: bold; color: #a4a4a4;\">{$lang.customerquote}</span></td>\r\n<td align=\"right\" valign=\"middle\">\r\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">\r\n<tbody>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.estimate_id}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">#{$estimate.id}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.status}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$estimate.status}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.estimate_date}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$estimate.date_created}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.expirydate}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$estimate.date_expires}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr id=\"invoice-details\">\r\n<td style=\"padding-top: 40px;\" valign=\"top\" width=\"33%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.customer}</span> <br /> <span style=\"font-size: 11px;\">{$client.companyname} <br /> {$estimate.client.firstname} {$estimate.client.lastname} <br /> {$estimate.client.address1} <br /> {$estimate.client.address2} <br /> {$estimate.client.city}, {$estimate.client.state} {$estimate.client.postcode} <br /> {$estimate.client.country} </span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table class=\"invoice-table\" style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"6\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_desc}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_tax}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.unitcost}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.qty}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.price}</span></td>\r\n</tr>\r\n<tr>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.description}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.taxed}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.amount}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.qty}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.linetotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.subtotal}</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px;\">{$estimate.subtotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.credit}</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px;\">{$estimate.credit}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$estimate.taxrate}%)</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px;\">{$estimate.tax}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$estimate.taxrate2}%)</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px;\">{$estimate.tax2}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$lang.total}</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$estimate.total}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n{if $estimate.notes!=\'\'}\r\n<table style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 100%;\" align=\"left\" valign=\"middle\"><span style=\"font-size: 11px;\" lang=\"\">{$estimate.notes}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n{/if}\r\n<table style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"border-top: 1px solid #F0F0F0; padding-top: 10px; width: 100%;\" align=\"center\">&nbsp;</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>', '015fee79efd5c71bccdd403649591410', '2013-05-21 00:00:00'),
(102, 102, 'Default', '<style type=\"text/css\"><!--\r\n    body {\r\n        font-family: Arial;\r\n    }\r\n--></style>\r\n<div id=\"invoice-table\" style=\"padding: 40px; font-family: Arial;\">\r\n<table style=\"width: 100%;\" border=\"0\" cellspacing=\"0\">\r\n<tbody>\r\n<tr id=\"invoice-header\">\r\n<td style=\"padding-left: 10px;\" colspan=\"2\" align=\"left\" valign=\"middle\" width=\"66%\"><span style=\"font-size: 18px; font-weight: bold; color: #484740;\">{$companylogo}</span> <span style=\"font-size: 18px; font-weight: bold; color: #a4a4a4;\">{$invoice.number}</span></td>\r\n<td align=\"right\" valign=\"middle\">\r\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">\r\n<tbody>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.creditnote}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.id}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.creditnote_date}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.date}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr id=\"invoice-details\">\r\n<td style=\"padding-top: 40px;\" valign=\"top\" width=\"33%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_to}</span><br /> <span style=\"font-size: 11px;\">{$client.companyname}<br /> {$client.firstname} {$client.lastname}<br /> {$client.address1} <br /> {$client.address2}<br /> {$client.city}, {$client.state}{$client.postcode}<br /> {$client.country} </span></td>\r\n<td style=\"padding-top: 40px;\" valign=\"top\" width=\"33%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_from}</span><br /> <span style=\"font-size: 11px;\">HostBill Demo</span></td>\r\n<td style=\"padding-top: 40px;\" align=\"left\" valign=\"top\" width=\"33%\">\r\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"2\">\r\n<tbody>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.balance}:</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px; font-weight: bold;\">{$transbalance}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<!--{if $invoice.related_invoice_number}--><span style=\"font-size: 11px; font-weight: bold;\">{$lang.related_invoice} {$invoice.related_invoice_number} {$lang.from} {$invoice.related_invoice_date}</span><!--{/if}-->\r\n<table class=\"invoice-table\" style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"6\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_desc}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_tax}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.unitcost}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.qty}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" valign=\"middle\" bgcolor=\"#f0f0f0\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.price}</span></td>\r\n</tr>\r\n<tr>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.description}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.taxed}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.amount}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.qty}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.linetotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.subtotal}</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.subtotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$invoice.taxrate}%)</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.tax}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$invoice.taxrate2}%)</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.tax2}</span></td>\r\n</tr>\r\n<tr>\r\n<td>&nbsp;</td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$lang.total}</span></td>\r\n<td colspan=\"2\" align=\"right\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$invoice.total}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"width: 100%;\" align=\"left\" valign=\"middle\"><span style=\"font-size: 11px;\"><em>{$invoice.notes}</em></span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table style=\"margin-top: 50px; width: 100%;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td style=\"border-top: 1px solid #F0F0F0; padding-top: 10px; width: 100%;\" align=\"center\"><span style=\"font-size: 11px; color: #a4a4a4;\">Invoice footer text</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>', '93fc76301bc84500e071b1b69a73f098', '2013-10-17 10:25:44'),
(103, 103, 'Default', '<style type=\"text/css\"><!--\r\n    body {\r\n        font-family: Arial;\r\n    }\r\n--></style>\r\n<div style=\"padding: 40px; font-family: Arial;\" id=\"invoice-table\">\r\n<table border=\"0\" cellspacing=\"0\" style=\"width: 100%;\">\r\n<tbody>\r\n<tr id=\"invoice-header\">\r\n<td width=\"66%\" valign=\"middle\" align=\"left\" colspan=\"2\" style=\"padding-left: 10px;\"><span style=\"font-size: 18px; font-weight: bold; color: #484740;\">{$companylogo}</span> <span style=\"font-size: 18px; font-weight: bold; color: #a4a4a4;\">{$invoice.number}</span></td>\r\n<td valign=\"middle\" align=\"right\">\r\n<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.creditreceipt}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.number}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_date}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.date}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_due}</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px;\">{$invoice.duedate}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr id=\"invoice-details\">\r\n<td valign=\"top\" style=\"padding-top: 40px;\" width=\"33%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_to}</span><br /> <span style=\"font-size: 11px;\">{$client.companyname}<br /> {$client.firstname} {$client.lastname}<br /> {$client.address1} <br /> {$client.address2}<br /> {$client.city}, {$client.state}{$client.postcode}<br /> {$client.country} </span></td>\r\n<td valign=\"top\" style=\"padding-top: 40px;\" width=\"33%\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.invoice_from}</span><br /> <span style=\"font-size: 11px;\">HostBill Demo</span></td>\r\n<td valign=\"top\" style=\"padding-top: 40px;\" align=\"left\" width=\"33%\">\r\n<table cellpadding=\"2\" cellspacing=\"0\" border=\"0\">\r\n<tbody>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.status}:</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px; font-weight: bold;\">{$invoice.status}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"right\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.balance}:</span></td>\r\n<td align=\"left\"><span style=\"font-size: 12px; font-weight: bold;\">{$transbalance}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table class=\"invoice-table\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_desc}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.invoice_tax}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.unitcost}</span></td>\r\n<td style=\"width: 7%;\" align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.qty}</span></td>\r\n<td style=\"width: 15%;\" align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.price}</span></td>\r\n</tr>\r\n<tr>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.description}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.taxed}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.amount}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"center\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.qty}</span></td>\r\n<td style=\"border-bottom: 1px solid #F0F0F0;\" align=\"right\" valign=\"middle\"><span style=\"font-size: 11px;\">{$item.linetotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.subtotal}</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.subtotal}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$invoice.taxrate}%)</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.tax}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px; font-weight: bold;\">{$lang.tax} ({$invoice.taxrate2}%)</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 12px;\">{$invoice.tax2}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$lang.total}</span></td>\r\n<td align=\"right\" colspan=\"2\" valign=\"middle\"><span style=\"font-size: 14px; font-weight: bold;\">{$invoice.total}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td align=\"left\" valign=\"middle\" style=\"width: 100%;\"><span style=\"font-size: 11px;\"><em>{$invoice.notes}</em></span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table class=\"invoice-table-transaction\" border=\"0\" cellpadding=\"6\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td colspan=\"4\" style=\"width: 100%;\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.related_trans}</span></td>\r\n</tr>\r\n<tr>\r\n<td bgcolor=\"#f0f0f0\" align=\"left\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_date}</span></td>\r\n<td align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_gtw}</span></td>\r\n<td align=\"center\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_id}</span></td>\r\n<td align=\"right\" bgcolor=\"#f0f0f0\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.trans_amount}</span></td>\r\n</tr>\r\n<tr>\r\n<td align=\"left\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.date}</span></td>\r\n<td align=\"center\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.module}</span></td>\r\n<td align=\"center\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.trans_id}</span></td>\r\n<td align=\"right\" valign=\"middle\" style=\"border-bottom: 1px solid #F0F0F0;\"><span style=\"font-size: 11px;\">{$transaction.amount}</span></td>\r\n</tr>\r\n<tr>\r\n<td></td>\r\n<td></td>\r\n<td align=\"right\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$lang.balance}</span></td>\r\n<td align=\"right\" valign=\"middle\"><span style=\"font-size: 11px; font-weight: bold;\">{$transbalance}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"margin-top: 50px; width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td align=\"center\" style=\"border-top: 1px solid #F0F0F0; padding-top: 10px; width: 100%;\"><span style=\"font-size: 11px; color: #a4a4a4;\">Invoice footer text</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</div>', '552c31955d634b1557d63af42bf1b1c4', '2022-06-09 08:55:17'),
(104, 104, 'GDPRDetails', '<style type=\"text/css\"><!--\r\nbody {\r\n    font-family: Arial;\r\n}\r\n--></style>\r\n<div style=\"padding: 40px; font-size: 18px;\">\r\n<table style=\"width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td><strong style=\"font-size: 18px;\">{$business_name}</strong></td>\r\n<td align=\"right\"><span style=\"font-size: 18px;\">{$report.date|dateformat:$date_format}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p align=\"center\" style=\"padding: 20px;\"><strong>Information about the content of the data filing system</strong></p>\r\n<div style=\"padding-bottom: 10px;\">In response to your request of {$report.requester} for information related to the  personal data processed by {$business_name}, we inform you that our company process your personal data.</div>\r\n<div style=\"padding-bottom: 10px;\">The data filing system of {$business_name} contains the following information about your person:\r\n<ul>{foreach from=$report.data item=data}\r\n<li><strong>{$data.name}: </strong> <span>{$data.value}</span></li>\r\n{/foreach}</ul>\r\n</div>\r\n<div style=\"padding-bottom: 10px;\">We inform you additionally that:<ol>\r\n<li>Your personal data are processed for the purpose of billing for services you’ve ordered from us.</li>\r\n<li>Your personal data will be stored for the period of ENTER PERIOD HERE.</li>\r\n<li>{if !$report.previous} Your personal data have not been disclosed to any recipient {else} Your personal data have been / will be disclosed to {$report.previous.name} on its request of {$report.previous.purpose} on the day of {$report.previous.date} {/if}</li>\r\n<li>You have the right to request rectification or erasure of your personal data or restriction of processing of your personal data or to object to such processing.</li>\r\n<li>If you consider that our processing of your personal information infringes data protection laws you are entitled to complain to the Supervisory Authority competent for your habitual residence, your place of work or the place of the alleged infringement.</li>\r\n</ol></div>\r\n</div>', 'bb8d3923c2b43d831b1aa7890f15f7e8', '2022-06-09 08:55:28'),
(105, 105, 'Order Summary', '<style type=\"text/css\"><!--\r\nbody {\r\n    font-family: Arial;\r\n}\r\n--></style>\r\n<div style=\"padding: 40px; font-size: 18px;\">\r\n<table style=\"width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td><strong style=\"font-size: 18px;\">{$business_name}</strong></td>\r\n<td align=\"right\"><span style=\"font-size: 18px;\">Order  #{$order.number}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p align=\"center\" style=\"padding: 20px;\"><strong>Thank you for your recent order!</strong></p>\r\n<div style=\"padding-bottom: 10px;\">This email is confirmation we\'ve received your order</div>\r\n<div style=\"padding-bottom: 10px;\">Following items were ordered:\r\n<ul>{foreach from=$order_details item=item}\r\n<li><strong> {$item.description} </strong> <span> {$item.amount|price:$currency}</span></li>\r\n{/foreach}</ul>\r\n</div>\r\n<div style=\"padding-bottom: 10px;\">We inform you additionally that:<ol>\r\n<li>We will activate your order as soon as possible after accounting payment (if applies) for this order</li>\r\n</ol></div>\r\n</div>', 'e6f207c899a726152e1b68187e407785', '2022-06-09 08:56:10'),
(106, 106, 'Default Account Statement', '<style>\r\n    body {\r\n        font-size:13px;\r\n        font-family: Verdana, Arial, Helvetica;\r\n    }\r\n    div {\r\n        padding:15px;\r\n    }\r\n    table {\r\n        border-collapse: collapse;\r\n        width: 100%;\r\n        border: 1px solid #dddddd;\r\n    }\r\n    th, td {\r\n        padding: 8px;\r\n        text-align: left;\r\n        border-bottom: 1px solid #ddd;\r\n    }\r\n    .background {\r\n        background-color:#efefef;\r\n    }\r\n</style>\r\n<div>\r\n    <table style=\"border:none;\">\r\n        <tr>\r\n            <td width=80% style=\"text-align:left;\"><h2>{$business_name} - {$lang.account_statement}</h2></td>\r\n            <td width=20% style=\"text-align:right;\">{$date}</td>\r\n        </tr>\r\n    </table>\r\n    <p>\r\n        <span style=\"font-size: 12px;\">\r\n            {$client.companyname}<br /> \r\n            {$client.firstname} {$client.lastname}<br /> \r\n            {$client.address1} <br /> \r\n            {$client.address2}<br /> \r\n            {$client.city}, {$client.state}{$client.postcode}<br /> \r\n            {$client.country} \r\n        </span> \r\n    </p>\r\n    <table>\r\n        <thead>\r\n            <tr class=\"background\">\r\n                <th>{$lang.type}</th>\r\n                <th>{$lang.date}</th>\r\n                <th>{$lang.Description}</th>\r\n                <th>{$lang.credits}</th>\r\n                <th>{$lang.debits}</th>\r\n                <th>{$lang.balance}</th>\r\n            </tr>\r\n        </thead>\r\n        <tbody>\r\n            {foreach from=$statement item=item}\r\n                <tr>\r\n                    <td>{$item.type}</td>\r\n                    <td>{$item.date}</td>\r\n                    <td>{$item.description}</td>\r\n                    <td>{$item.credits}</td>\r\n                    <td>{$item.debits}</td>\r\n                    <td>{$item.balance}</td>\r\n                </tr>\r\n            {/foreach}\r\n            <tr class=\"background\">\r\n                <td colspan=2></td>\r\n                <td>{$lang.ending_balance}</td>\r\n                <td>{$ending.credits}</td>\r\n                <td>{$ending.debits}</td>\r\n                <td>{$ending.balance}</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n</div>', 'ceb87047e8238deac4f90bf648ce43ea', '2022-06-09 08:56:36');
##########
CREATE TABLE `hb_theme_configs` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `theme` varchar(255) NOT NULL,
  `configuration` text,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `theme` (`theme`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lastreply` datetime NOT NULL,
  `lastupdate` datetime NOT NULL,
  `lastedit` datetime NOT NULL,
  `editby` varchar(50) NOT NULL,
  `ticket_number` int(6) NOT NULL DEFAULT '0',
  `acc_hash` varchar(32) NOT NULL DEFAULT '0',
  `dept_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `creator_id` int(11) NOT NULL DEFAULT '0',
  `name` text NOT NULL,
  `email` text NOT NULL,
  `cc` text,
  `bcc` mediumtext,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `status` varchar(31) NOT NULL DEFAULT 'Open',
  `priority` enum('0','1','2','3') NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL,
  `tags` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `admin_read` tinyint(1) NOT NULL DEFAULT '0',
  `client_read` tinyint(1) NOT NULL DEFAULT '0',
  `type` enum('Client','Admin','Email','Unregistered') DEFAULT 'Client',
  `request_type` enum('General','Incident','Problem','Task','Question') DEFAULT 'General',
  `senderip` varchar(16) NOT NULL,
  `escalated` int(11) NOT NULL DEFAULT '0',
  `sla_id` int(11) DEFAULT '0',
  `start_date` datetime NOT NULL,
  `resolve_date` datetime NOT NULL,
  `owner_id` int(11) NOT NULL DEFAULT '0',
  `metadata` text,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `date` (`date`),
  KEY `admins` (`admin_read`),
  KEY `dept_id` (`dept_id`),
  KEY `status` (`status`(3)),
  KEY `lastreply` (`lastreply`),
  KEY `ticket_number` (`ticket_number`),
  KEY `acc_hash` (`acc_hash`(6)),
  KEY `parent_id` (`parent_id`),
  KEY `request_type` (`request_type`),
  KEY `escalated` (`escalated`),
  KEY `owner_id` (`owner_id`),
  KEY `hb_tickets_status_dept_owner` (`status`,`dept_id`,`owner_id`),
  KEY `hb_tickets_deptid_flags` (`dept_id`,`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticketshare_agreements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(40) NOT NULL,
  `access_key` varchar(40) NOT NULL,
  `name` varchar(128) NOT NULL,
  `tag` varchar(128) NOT NULL,
  `sharing_url` text NOT NULL,
  `status` enum('pending','accepted','declined','inactive') NOT NULL,
  `deactivated_by` enum('sender','receiver') DEFAULT NULL,
  `created_by` enum('sender','receiver') NOT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticketshare_attachments` (
  `attach_id` int(10) NOT NULL,
  `uuid` varchar(40) NOT NULL,
  `local` tinyint(4) NOT NULL,
  PRIMARY KEY (`attach_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticketshare_comments` (
  `uuid` varchar(40) NOT NULL,
  `target` enum('reply','note','ticket') NOT NULL,
  `target_id` int(11) NOT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE KEY `target_taget_id` (`target`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticketshare_tickets` (
  `uuid` varchar(40) NOT NULL DEFAULT '',
  `type` enum('master','slave') NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `agreement_id` int(11) NOT NULL,
  PRIMARY KEY (`uuid`),
  KEY `ticket_id` (`ticket_id`),
  KEY `agreement_id` (`agreement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `rel_id` int(11) NOT NULL DEFAULT '0',
  `filename` text NOT NULL,
  `org_filename` mediumtext,
  `type` varchar(8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `rel_id` (`rel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('Email','Subject','Content') NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_tickets_bans` (`id`, `type`, `text`) VALUES
(1, 'Subject', 'eval(base64_decode');
##########
CREATE TABLE `hb_tickets_emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `to` text NOT NULL,
  `from` text NOT NULL,
  `subject` text NOT NULL,
  `headers` text NOT NULL,
  `message` text NOT NULL,
  `status` tinyint(2) NOT NULL,
  `rel` enum('ticket','reply') DEFAULT NULL,
  `rel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_emails_stats` (
  `email` varchar(254) NOT NULL,
  `last_success` datetime DEFAULT NULL,
  `last_reject` datetime DEFAULT NULL,
  `last_reject_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `ticket_number` int(6) NOT NULL,
  `date` datetime NOT NULL,
  `action` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `date` datetime NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `admin_id` (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_predefinied` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `name` text NOT NULL,
  `reply` text NOT NULL,
  `admin_note` text,
  `usability` int(11) DEFAULT '0',
  `note` tinyint(4) DEFAULT NULL,
  `priority` tinyint(4) DEFAULT NULL,
  `deptid` int(11) DEFAULT NULL,
  `status` varchar(31) DEFAULT NULL,
  `owner` int(10) DEFAULT NULL,
  `subscribers` text,
  `tags` text,
  `share` int(11) DEFAULT NULL,
  `notify` tinyint(4) NOT NULL DEFAULT '1',
  `sub_email` int(11) NOT NULL DEFAULT '0',
  `sort_order` int(11) DEFAULT NULL,
  `relation` enum('none','timers') NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  KEY `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_predefinied_cats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_cat` int(11) NOT NULL DEFAULT '0',
  `name` text NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent` (`parent_cat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_predefinied_my` (
  `admin_id` int(11) NOT NULL,
  `reply_id` int(11) NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`admin_id`,`reply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_public` (
  `ticket_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`ticket_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_tags` (
  `tag_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  PRIMARY KEY (`tag_id`,`ticket_id`),
  KEY `tag_id` (`tag_id`),
  KEY `ticket_id` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_tags_archived` (
  `id` int(11) NOT NULL,
  `tag` varchar(128) NOT NULL,
  `color` varchar(8) DEFAULT '#03a9f4',
  `date` datetime DEFAULT NULL,
  `who` varchar(250) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_tickets_timers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `macro_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `start_date` datetime DEFAULT NULL,
  `timezone` varchar(255) DEFAULT '',
  `executed_at` datetime DEFAULT NULL,
  `executed_by` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT '0',
  `auto_reset` tinyint(1) NOT NULL DEFAULT '0',
  `status` enum('Pending','Executed','Canceled manually','Canceled by reply') NOT NULL DEFAULT 'Pending',
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `macro_id` (`macro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_billing` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `type` enum('hourly','flat') NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_billing_items` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(10) NOT NULL,
  `date` datetime NOT NULL,
  `start` datetime NOT NULL,
  `end` datetime NOT NULL,
  `rate_id` int(11) NOT NULL,
  `rate` decimal(10,2) NOT NULL,
  `type` enum('hourly','flat') NOT NULL,
  `admin_id` int(10) NOT NULL,
  `admin` varchar(250) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `note` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rate_id` (`rate_id`),
  KEY `admin_id` (`admin_id`),
  KEY `ticket_id` (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_business_hours` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL,
  `day` enum('monday','tuesday','wednesday','thursday','friday','saturday','sunday') NOT NULL DEFAULT 'monday',
  `from` varchar(10) NOT NULL DEFAULT '00:00',
  `to` varchar(10) NOT NULL DEFAULT '00:00',
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `email` varchar(128) NOT NULL,
  `senderemail` varchar(128) NOT NULL,
  `sendername` varchar(256) NOT NULL,
  `assigned_admins` text NOT NULL,
  `sort` int(10) NOT NULL DEFAULT '0',
  `method` enum('POP','PIPE') NOT NULL DEFAULT 'PIPE',
  `host` varchar(128) NOT NULL,
  `port` int(4) NOT NULL DEFAULT '110',
  `login` varchar(128) NOT NULL,
  `password` text NOT NULL,
  `sendmethod` tinyint(1) NOT NULL DEFAULT '1',
  `smtphost` varchar(128) NOT NULL,
  `smtpport` int(11) NOT NULL,
  `smtplogin` varchar(128) NOT NULL,
  `smtpemail` varchar(128) NOT NULL,
  `smtppassword` text NOT NULL,
  `options` int(3) UNSIGNED NOT NULL DEFAULT '13',
  `autoclose` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `default_rate` int(10) NOT NULL DEFAULT '0',
  `sla_level_zero` int(10) NOT NULL DEFAULT '0',
  `sla_level_one` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `sla_level_two` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `macro_sla0_id` int(10) NOT NULL DEFAULT '0',
  `macro_sla1_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `macro_sla2_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `macro_reportreply` int(10) NOT NULL DEFAULT '0',
  `macro_reportticket` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `email` (`email`(64)),
  KEY `admins` (`assigned_admins`(30)),
  KEY `method` (`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_departments_import` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL,
  `hash` char(32) DEFAULT NULL,
  `method` varchar(50) NOT NULL,
  `config` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_departments_mail` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `dept_id` int(10) NOT NULL,
  `email` varchar(50) NOT NULL,
  `method` enum('POP','PIPE') NOT NULL,
  `host` varchar(50) NOT NULL,
  `login` varchar(50) NOT NULL,
  `port` int(10) NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_departments_sla` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `macro_id` int(11) DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `trigger` enum('time','replytime','adminreplytime','client_reply','admin_reply') NOT NULL DEFAULT 'time',
  `trigger_unit` enum('minutes','hours','days') NOT NULL DEFAULT 'minutes',
  `trigger_value` int(11) NOT NULL DEFAULT '0',
  `trigger_status` text,
  `tags` text,
  `de_escalate` tinyint(4) DEFAULT '0',
  `business_hours` tinyint(1) DEFAULT '1',
  `override_staff` text,
  `datecreated` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dept_id` (`dept_id`),
  KEY `level` (`level`),
  KEY `trigger` (`trigger`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_departments_staff` (
  `dept_id` int(10) NOT NULL,
  `staff_id` int(10) NOT NULL,
  `staff_type` enum('admin','team') NOT NULL,
  `options` int(10) NOT NULL,
  PRIMARY KEY (`dept_id`,`staff_id`,`staff_type`),
  KEY `dept_id` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_filter` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` enum('pre','post') NOT NULL,
  `final` int(10) NOT NULL,
  `join_type` enum('all','any') NOT NULL,
  `macro_id` int(10) NOT NULL DEFAULT '0',
  `sort_order` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `macro_id` (`macro_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_ticket_filter` (`id`, `name`, `type`, `final`, `join_type`, `macro_id`, `sort_order`) VALUES
(1, 'Example', 'pre', 1, 'any', 0, 0),
(2, 'Old filters', 'pre', 1, 'any', 0, 0);
##########
CREATE TABLE `hb_ticket_filter_items` (
  `id` int(10) NOT NULL,
  `filter_id` int(10) NOT NULL,
  `field` varchar(50) NOT NULL,
  `type` enum('contains','match','regexp') NOT NULL,
  `content` text NOT NULL,
  PRIMARY KEY (`id`,`filter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_ticket_filter_items` (`id`, `filter_id`, `field`, `type`, `content`) VALUES
(1, 1, 'subject', 'contains', '***SPAM'),
(2, 1, 'body', 'regexp', '/eval\\s*\\(\\s*base64_decode/i');
##########
CREATE TABLE `hb_ticket_rating` (
  `ticket_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `comment` text,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_replies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_id` int(11) NOT NULL,
  `replier_id` int(11) NOT NULL DEFAULT '0',
  `name` text NOT NULL,
  `email` text NOT NULL,
  `date` datetime NOT NULL,
  `lastedit` datetime NOT NULL,
  `editby` varchar(50) NOT NULL,
  `body` text NOT NULL,
  `status` enum('Sent','Draft','Scheduled') NOT NULL DEFAULT 'Sent',
  `type` enum('Client','Admin','Email','Unregistered','System') DEFAULT 'Client',
  `flags` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `ticket_id` (`ticket_id`),
  KEY `rep_type` (`replier_id`,`type`),
  KEY `date` (`date`),
  KEY `hb_ticket_replies_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_replies_rating` (
  `reply_id` int(10) NOT NULL,
  `rating` int(10) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`reply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_staff_autoassign` (
  `staff_id` int(11) NOT NULL,
  `dept_id` int(11) NOT NULL,
  `last_assign` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`staff_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_status` (
  `status` varchar(31) NOT NULL,
  `options` int(3) NOT NULL DEFAULT '0',
  `color` varchar(7) NOT NULL DEFAULT '000000',
  `sort_order` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`status`),
  KEY `options` (`options`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_ticket_status` (`status`, `options`, `color`, `sort_order`) VALUES
('Answered', 3, '000000', 2),
('Client-Reply', 1, '000000', 4),
('Closed', 1, '000000', 1),
('In-Progress', 1, '000000', 3),
('Open', 1, '000000', 0),
('Scheduled-Notification', 5, '000000', 0),
('Sent-Out', 9, '000000', 0);
##########
CREATE TABLE `hb_ticket_subscriptions` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `admin_id` int(10) NOT NULL,
  `ticket_id` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_id_ticket_id` (`admin_id`,`ticket_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_views` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `owner` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `options` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `columns` int(11) UNSIGNED NOT NULL DEFAULT '31',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_views_columns` (
  `id` int(10) NOT NULL,
  `view_id` int(10) NOT NULL,
  `column` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`,`view_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_ticket_views_filters` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `view_id` int(10) NOT NULL,
  `type` int(10) UNSIGNED NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `client_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `status` enum('Success','Processing','Refunded','Chargeback','Draft') DEFAULT 'Success',
  `module` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `description` text NOT NULL,
  `in` decimal(10,2) NOT NULL DEFAULT '0.00',
  `fee` decimal(10,2) NOT NULL DEFAULT '0.00',
  `out` decimal(10,2) NOT NULL DEFAULT '0.00',
  `trans_id` varchar(70) DEFAULT NULL,
  `currency_id` int(11) NOT NULL DEFAULT '0',
  `rate` decimal(15,10) NOT NULL DEFAULT '1.0000000000',
  `refund_of` int(11) DEFAULT NULL,
  `type` enum('invoice','bulk','credit','refund','chargeback') DEFAULT 'credit',
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `invoice_id` (`invoice_id`),
  KEY `trans_id` (`trans_id`),
  KEY `currency_id` (`currency_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_transaction_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_id` int(11) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_transfers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `rel_id` int(11) NOT NULL,
  `old_client_id` int(11) NOT NULL,
  `new_client_id` int(11) DEFAULT NULL,
  `new_client_email` varchar(255) NOT NULL,
  `description` text,
  `status` enum('Pending','Approved','Rejected','Immediate') NOT NULL DEFAULT 'Pending',
  `date_request` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`,`rel_type`,`rel_id`),
  KEY `old_client_id` (`old_client_id`),
  KEY `new_client_id` (`new_client_id`),
  KEY `new_client_email` (`new_client_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_upgrades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rel_type` enum('Hosting','Domain') NOT NULL DEFAULT 'Hosting',
  `account_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `old_product_id` int(11) NOT NULL,
  `status` enum('Pending','Upgraded') NOT NULL DEFAULT 'Pending',
  `total` decimal(10,2) NOT NULL,
  `old_value` decimal(12,2) NOT NULL,
  `new_value` decimal(10,2) NOT NULL,
  `new_billing` enum('Free','One Time','Monthly','Quarterly','Semi-Annually','Annually','Biennially','Triennially','Daily','Weekly','Hourly') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `rel_type` (`rel_type`,`account_id`),
  KEY `client_id` (`client_id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  KEY `old_product_id` (`old_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_vps_details` (
  `account_id` int(11) NOT NULL,
  `veid` varchar(64) NOT NULL,
  `type` enum('Xen','Xen HVM','OpenVZ','KVM','Virtuozzo','Other') NOT NULL,
  `ip` varchar(45) NOT NULL,
  `additional_ip` text NOT NULL,
  `guaranteed_ram` int(3) NOT NULL,
  `burstable_ram` int(3) NOT NULL,
  `disk_usage` int(11) NOT NULL,
  `disk_limit` int(11) NOT NULL,
  `bw_usage` int(11) NOT NULL,
  `bw_limit` int(11) NOT NULL,
  `os` text NOT NULL,
  `node` varchar(32) NOT NULL,
  `extra` text NOT NULL,
  PRIMARY KEY (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `target_type` enum('Product','Category') NOT NULL DEFAULT 'Product',
  `target_id` int(11) NOT NULL DEFAULT '0',
  `widget_id` int(11) NOT NULL,
  `override_defaults` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `config` text NOT NULL,
  `group` varchar(32) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widget_id` (`widget_id`),
  KEY `tar` (`target_type`,`target_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE `hb_widgets_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `widget` varchar(32) NOT NULL,
  `name` text NOT NULL,
  `location` text NOT NULL,
  `ptype` int(11) NOT NULL,
  `config` text NOT NULL,
  `options` int(11) NOT NULL DEFAULT '1',
  `group` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `widget` (`widget`),
  KEY `ptype` (`ptype`),
  KEY `options` (`options`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
##########
INSERT INTO `hb_widgets_config` (`id`, `widget`, `name`, `location`, `ptype`, `config`, `options`, `group`) VALUES
(1, 'resetpass', 'Reset Password', 'includes/types/widgets/resetpass/', 0, 'a:2:{s:8:\"smallimg\";s:42:\"includes/types/widgets/resetpass/small.png\";s:6:\"bigimg\";s:40:\"includes/types/widgets/resetpass/big.png\";}', 1, 'sidemenu'),
(2, 'logindetails', 'Login Details', 'includes/types/widgets/logindetails/', 0, 'a:2:{s:8:\"smallimg\";s:45:\"includes/types/widgets/logindetails/small.png\";s:6:\"bigimg\";s:43:\"includes/types/widgets/logindetails/big.png\";}', 1, 'sidemenu'),
(3, 'diskbandusage', 'Disk & Bandwidth Usage', 'includes/types/widgets/diskbandusage/', 0, 'a:2:{s:8:\"smallimg\";s:46:\"includes/types/widgets/diskbandusage/small.png\";s:6:\"bigimg\";s:44:\"includes/types/widgets/diskbandusage/big.png\";}', 1, 'sidemenu'),
(4, 'accesscpanel', 'Access Control Panel', 'includes/types/widgets/accesscpanel/', 0, 'a:2:{s:8:\"smallimg\";s:45:\"includes/types/widgets/accesscpanel/small.png\";s:6:\"bigimg\";s:43:\"includes/types/widgets/accesscpanel/big.png\";}', 1, 'sidemenu'),
(5, 'accesswebmail', 'Access WebMail', 'includes/types/widgets/accesswebmail/', 0, 'a:2:{s:8:\"smallimg\";s:46:\"includes/types/widgets/accesswebmail/small.png\";s:6:\"bigimg\";s:44:\"includes/types/widgets/accesswebmail/big.png\";}', 1, 'sidemenu'),
(6, 'contactinfo', 'Contacts Information', 'includes/types/domains/widgets/contactinfo/', 9, 'a:2:{s:8:\"smallimg\";s:52:\"includes/types/domains/widgets/contactinfo/small.png\";s:6:\"bigimg\";s:50:\"includes/types/domains/widgets/contactinfo/big.png\";}', 1, 'sidemenu'),
(7, 'dnsmanagement_widget', 'DNS Management', 'includes/types/domains/widgets/dnsmanagement_widget/', 9, 'a:2:{s:8:\"smallimg\";s:61:\"includes/types/domains/widgets/dnsmanagement_widget/small.png\";s:6:\"bigimg\";s:59:\"includes/types/domains/widgets/dnsmanagement_widget/big.png\";}', 1, 'sidemenu'),
(8, 'domainforwarding', 'Domain Forwarding', 'includes/types/domains/widgets/domainforwarding/', 9, 'a:2:{s:8:\"smallimg\";s:57:\"includes/types/domains/widgets/domainforwarding/small.png\";s:6:\"bigimg\";s:55:\"includes/types/domains/widgets/domainforwarding/big.png\";}', 1, 'sidemenu'),
(9, 'emailforwarding', 'Email Forwarding', 'includes/types/domains/widgets/emailforwarding/', 9, 'a:2:{s:8:\"smallimg\";s:56:\"includes/types/domains/widgets/emailforwarding/small.png\";s:6:\"bigimg\";s:54:\"includes/types/domains/widgets/emailforwarding/big.png\";}', 1, 'sidemenu'),
(10, 'eppcode', 'Auth Info / EPP Key', 'includes/types/domains/widgets/eppcode/', 9, 'a:2:{s:8:\"smallimg\";s:48:\"includes/types/domains/widgets/eppcode/small.png\";s:6:\"bigimg\";s:46:\"includes/types/domains/widgets/eppcode/big.png\";}', 1, 'sidemenu'),
(11, 'registernameservers', 'Register Nameservers', 'includes/types/domains/widgets/registernameservers/', 9, 'a:2:{s:8:\"smallimg\";s:60:\"includes/types/domains/widgets/registernameservers/small.png\";s:6:\"bigimg\";s:58:\"includes/types/domains/widgets/registernameservers/big.png\";}', 1, 'sidemenu'),
(12, 'autorenew', 'Auto-Renewal Options', 'includes/types/domains/widgets/autorenew/', 9, 'a:2:{s:8:\"smallimg\";s:50:\"includes/types/domains/widgets/autorenew/small.png\";s:6:\"bigimg\";s:48:\"includes/types/domains/widgets/autorenew/big.png\";}', 1, 'sidemenu'),
(13, 'reglock', 'Domain Lock Settings', 'includes/types/domains/widgets/reglock/', 9, 'a:2:{s:8:\"smallimg\";s:48:\"includes/types/domains/widgets/reglock/small.png\";s:6:\"bigimg\";s:46:\"includes/types/domains/widgets/reglock/big.png\";}', 1, 'sidemenu'),
(14, 'nameservers', 'Manage Nameservers', 'includes/types/domains/widgets/nameservers/', 9, 'a:2:{s:8:\"smallimg\";s:52:\"includes/types/domains/widgets/nameservers/small.png\";s:6:\"bigimg\";s:50:\"includes/types/domains/widgets/nameservers/big.png\";}', 1, 'sidemenu'),
(15, 'idprotection', 'Manage Privacy', 'includes/types/domains/widgets/idprotection/', 9, 'a:2:{s:8:\"smallimg\";s:53:\"includes/types/domains/widgets/idprotection/small.png\";s:6:\"bigimg\";s:51:\"includes/types/domains/widgets/idprotection/big.png\";}', 1, 'sidemenu');
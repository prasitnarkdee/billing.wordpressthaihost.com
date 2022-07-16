REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'report_groups', 'Report Groups' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'editadmins', 'manageReportGroups','Manage report groups' FROM hb_language WHERE target='admin';
##########
UPDATE `hb_admin_access` SET access = CONCAT(access, ',manageReportGroups') WHERE access LIKE '%customizeReports%';
##########
UPDATE `hb_admin_teams` SET access = CONCAT(access, ',manageReportGroups') WHERE access LIKE '%customizeReports%';
##########
CREATE TABLE IF NOT EXISTS `hb_report_groups` (
`name` VARCHAR (60) NOT NULL,
`access` VARCHAR (60) NOT NULL,
`customize` VARCHAR (60) NOT NULL,
`options` INT (3) DEFAULT 1,
`sort_order` TINYINT (3),
PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_report_groups` (`name`,`access`,`customize`, `options`, `sort_order`) VALUES
('Custom', 'accessReportsCustom', 'customizeReportsCustom', 0, 0),
('Affiliates', 'accessReportsAffiliates', 'customizeReportsAffiliates', 0, 1),
('Clients', 'accessReportsClients', 'customizeReportsClients', 0, 2),
('Invoices', 'accessReportsInvoices', 'customizeReportsInvoices', 0, 3),
('Knowledgebase', 'accessReportsKnowledgebase', 'customizeReportsKnowledgebase', 0, 4),
('Orders', 'accessReportsOrders', 'customizeReportsOrders', 0, 5),
('Staff', 'accessReportsStaff', 'customizeReportsStaff', 0, 6),
('Support', 'accessReportsSupport', 'customizeReportsSupport', 0, 7);
##########
UPDATE `hb_admin_access`
SET access = CONCAT(access, ',customizeReportsCustom,customizeReportsAffiliates,customizeReportsClients,customizeReportsHidden,customizeReportsInvoices,customizeReportsKnowledgebase,customizeReportsOrders,customizeReportsStaff,customizeReportsSupport')
WHERE access LIKE '%customizeReports%';
##########
UPDATE `hb_admin_teams`
SET access = CONCAT(access, ',customizeReportsCustom,customizeReportsAffiliates,customizeReportsClients,customizeReportsHidden,customizeReportsInvoices,customizeReportsKnowledgebase,customizeReportsOrders,customizeReportsStaff,customizeReportsSupport')
WHERE access LIKE '%customizeReports%';
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'editadmins', 'accessReportsAffiliates','Access Reports: Affiliates' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'accessReportsKnowledgebase','Access Reports: Knowledgebase' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsCustom','Customize Reports: Custom' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsAffiliates','Customize Reports: Affiliates' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsClients','Customize Reports: Clients' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsInvoices','Customize Reports: Invoices' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsKnowledgebase','Customize Reports: Knowledgebase' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsOrders','Customize Reports: Orders' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsStaff','Customize Reports: Staff' FROM hb_language WHERE target='admin'
UNION SELECT id, 'editadmins', 'customizeReportsSupport','Customize Reports: Support' FROM hb_language WHERE target='admin';
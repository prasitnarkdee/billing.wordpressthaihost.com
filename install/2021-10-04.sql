CREATE TABLE IF NOT EXISTS `hb_client_option` (
     `id` INT NOT NULL AUTO_INCREMENT,
     `key` VARCHAR(32) NULL,
     `type` VARCHAR(32) NOT NULL DEFAULT 'select',
     `title` TEXT NOT NULL,
     `description` TEXT NULL,
     `meta` TEXT NOT NULL,
     `sort` INT NOT NULL DEFAULT '1',
     PRIMARY KEY (`id`),
     UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
CREATE TABLE IF NOT EXISTS `hb_client_option_item` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `option_id` INT NOT NULL,
    `title` TEXT NOT NULL,
    `description` TEXT NULL,
    `value` TEXT NULL,
    `meta` TEXT NOT NULL,
    `sort` INT NOT NULL DEFAULT '1',
    PRIMARY KEY (`id`),
    KEY `option_id` (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
TRUNCATE `hb_client_option`;
##########
INSERT INTO `hb_client_option` (`id`, `key`, `type`, `title`, `description`, `meta`, `sort`) VALUES
(1, 'TaxExempt', 'select', '{$lang.taxexempt}', NULL, '{"tags":["billing","tax","client_tax"],"default":true}', 1),
(2, 'TaxOverrideRate', 'number', '{$lang.taxrateoverride}', 'Percent value [%] for L1 tax rate.', '{"tags":["billing","tax","client_tax"]}', 1),
(3, 'EmailSwitch', 'select', '{$lang.sendeme}', NULL, '{"tags":["notification","email"]}', 1),
(4, 'CCChargeAuto', 'tpl', '{$lang.CCChargeAuto}', NULL, '{"tags":["billing","payment","creditcard"],"related":["CCDaysBeforeCharge","CCRetryForDays","CCAttemptOnce"]}', 1),
(5, 'CreditOnDowngradeOverride', 'select', 'Credit on Downgrade', NULL, '{"tags":["billing","credit"]}', 1),
(6, 'CreditAutoApply', 'select', '{$lang.autoapplycredit}', NULL, '{"tags":["billing","credit"],"allow_client_edit":true}', 1),
(7, 'CreditDelayAutoApply', 'number', 'Auto-apply Credit Delay', 'The number of days before invoice due date after which to apply credit automatically.', '{"tags":["billing","credit"]}', 1),
(8, 'AllowControlInvoiceDelivery', 'select', '{$lang.AllowControlInvoiceDelivery}', NULL, '{"tags":["billing","invoice"]}', 1),
(9, 'AttachPDFInvoicePaid', 'select', '{$lang.InvoiceDeliveryMethod}', NULL, '{"tags":["billing","invoice"],"allow_client_edit":true}', 1),
(10, 'AttachPDFInvoice', 'select', '{$lang.InvoiceDeliveryMethod}', NULL, '{"tags":["billing","invoice"]}', 1),
(11, 'AddToPrintQueue', 'select', '{$lang.AddToPrintQueue}', NULL, '{"tags":["billing","invoice"]}', 1),
(12, 'ContinueInvoices', 'radio', '{$lang.ContinueInvoices}', NULL, '{"tags":["billing","invoice"]}', 1),
(13, 'RenewInvoice', 'tpl', '{$lang.InvoiceGeneration}', NULL, '{"tags":["automation","invoice"],"related":["InvoiceGeneration","InvoiceGenerationDay"]}', 1),
(14, 'AdvancedDueDate', 'tpl', 'Advanced due date settings', NULL, '{"tags":["automation","invoice"],"related":["InvoiceExpectDays","InitialDueDays","MoveDueDays"]}', 1),
(15, 'GenerateSeparateInvoices', 'radio', '{$lang.MergeInvoices}', NULL, '{"tags":["billing","invoice"],"allow_client_edit":true}', 1),
(16, 'MergeDomainRenewals', 'tpl', '{$lang.MergeInvoiceOptions}', NULL, '{"tags":["billing","invoice"],"related":["MergeMonthlyServiceRenewals","MergeAnnualServiceRenewals"]}', 1),
(17, 'FinalInvoiceOnPayment', 'radio', '{$lang.FinalInvoiceOnPayment}', NULL, '{"tags":["billing","invoice"]}', 20),
(18, 'CollectionInvoicesOnDays', 'tpl', 'Auto-Collections', NULL, '{"tags":["billing","invoice"],"related":["CollectionInvoicesOnDaysValue"]}', 1),
(19, 'InvoiceTemplate', 'tpl', '{$lang.InvoiceTemplate}', NULL, '{"tags":["billing","template"]}', 1),
(20, 'EstimateTemplate', 'tpl', '{$lang.EstimateTemplate}', NULL, '{"tags":["billing","template"]}', 1),
(21, 'CNoteTemplate', 'tpl', '{$lang.CreditNoteTemplate}', NULL, '{"tags":["billing","template"]}', 1),
(22, 'ReceiptTemplate', 'tpl', '{$lang.CreditReceiptTemplate}', NULL, '{"tags":["billing","template"]}', 1),
(23, 'EnableAutoCreation', 'select', '{$lang.auto_create}', NULL, '{"tags":["automation","hosting"]}', 1),
(24, 'EnableAutoUpgrades', 'select', 'Automatic Upgrades', NULL, '{"tags":["automation","hosting"]}', 1),
(25, 'EnableAutoRenewService', 'select', 'Automatic Renew', NULL, '{"tags":["automation","hosting"]}', 1),
(26, 'EnableAutoSuspension', 'tpl', 'Account suspension', NULL, '{"tags":["automation","hosting"],"related":["AutoSuspensionPeriod"]}', 1),
(27, 'EnableAutoTermination', 'tpl', '{$lang.new_EnableAutoTermination}', NULL, '{"tags":["automation","hosting"],"related":["AutoTerminationPeriod"]}', 1),
(28, 'EnableAutoRegisterDomain', 'tpl', 'Auto-Register domains', NULL, '{"tags":["automation","domain"],"related":["AutoRegisterDomainType"]}', 1),
(29, 'EnableAutoTransferDomain', 'tpl', 'Auto-Transfer domains', NULL, '{"tags":["automation","domain"],"related":["AutoTransferDomainType"]}', 1),
(30, 'EnableAutoRenewDomain', 'tpl', 'Auto-Renew domains', NULL, '{"tags":["automation","domain"],"related":["RenewOnOrder"]}', 1),
(31, 'SendPaymentReminderEmails', 'tpl', '{$lang.new_SendPaymentReminderEmails}', NULL, '{"tags":["automation","overdue"],"related":["InvoiceUnpaidReminder","1OverdueReminder","2OverdueReminder","3OverdueReminder"]}', 1),
(32, 'LateFeeType', 'tpl', '{$lang.latefees}', NULL, '{"tags":["automation","overdue","latefee"],"related":["LateFeeValue"]}', 1),
(33, 'AddLateFeeAfter', 'text', 'Late Fee Days', '{$lang.LateFeeType2x}', '{"tags":["automation","overdue","latefee"]}', 1),
(34, 'OrderScenario', 'select', 'Order scenario', 'You can choose whether customer falls under default scenario, or are processed with custom one.', '{"tags":["orders"]}', 1),
(35, 'EnableProRata', 'tpl', 'Pro-rata billing', 'With this option enabled client will have all new services billed on certain day of month.', '{"tags":["orders","prorata"],"related":["ProRataDay","ProRataMonth","ProRataNextMonth"]}', 1),
(36, 'UpgradeProratePrecision', 'select', 'Upgrade pro-rata', NULL, '{"tags":["orders","prorata","upgrades"]}', 1),
(37, 'ContractGeneration', 'select', 'Contract Generation', NULL, '{"tags":["orders","contracts"]}', 1),
(38, 'DiscountGlobal', 'tpl', 'Global Discount', NULL, '{"tags":["discount"],"default":true}', 1),
(39, 'DiscountForms', 'tpl', 'Form component discount', NULL, '{"tags":["discount"],"default":true}', 1),
(40, 'SupportDepartments', 'checkbox', 'Explicit ticket departments access', 'Departments with explicit access to which client has access', '{"tags":["support"],"default":true}', 1),
(41, 'SupportPriority', 'select', 'Ticket priority', NULL, '{"tags":["support"]}', 1),
(42, 'DefaultTicketRate', 'select', 'Default Ticket Rate', NULL, '{"tags":["support","supportrates"]}', 1),
(43, 'RecordsPerPage', 'select', '{$lang.RecordsPerPage}', NULL, '{"tags":["general"],"allow_client_edit":true,"allow_admin_edit":false}', 100),
(44, 'DefaultTimezone', 'select', '{$lang.timezone}', NULL, '{"tags":["automation","general"],"allow_client_edit":true}', 100),
(45, 'DefaultPaymentModule', 'select', '{$lang.DefaultPaymentModule}', NULL, '{"tags":["billing","payment"],"default":true,"allow_client_edit":true}', 100),
(46, 'ClientNotifications', 'checkbox', '{$lang.notify_setting}', NULL, '{"tags":["notification"],"allow_client_edit":true,"allow_admin_edit":false}', 1),
(47, 'DefaultNameservers', 'tpl', '{$lang.nameservers}', NULL, '{"tags":["order"],"allow_client_edit":true,"allow_admin_edit":false}', 1);
##########
TRUNCATE `hb_client_option_item`;
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
(10, 6, '{$lang.yes}', 'Apply available credit to new orders immediately, and few days before due date for recurring invoices', 'delay', '{"enable":["CreditDelayAutoApply"],"admin_only":true}', 1),
(11, 6, '{$lang.no}', '{$lang.autocredit_no}', 'off', '[]', 1),
(12, 8, '{$lang.yes}', '', 'on', '[]', 1),
(13, 8, '{$lang.no}', '', 'off', '[]', 1),
(14, 9, '{$lang.InvoiceDeliveryMethod_descr1}', '', 'on', '[]', 1),
(15, 9, '{$lang.InvoiceDeliveryMethod_descr2}', '', 'off', '{"admin_only":true}', 1),
(16, 9, '{$lang.InvoiceDeliveryMethod_descr3}', '', 'paper', '{"disable_email":true,"enable":["AddToPrintQueue"]}', 1),
(17, 9, '{$lang.InvoiceDeliveryMethod_descr4}', '', 'paperpdf', '{"enable":["AddToPrintQueue"]}', 1),
(18, 10, '{$lang.InvoiceDeliveryMethod_descr1}', '', 'on', '[]', 1),
(19, 10, '{$lang.InvoiceDeliveryMethod_descr2}', '', 'off', '{"admin_only":true}', 1),
(20, 10, '{$lang.InvoiceDeliveryMethod_descr3}', '', 'paper', '{"disable_email":true,"enable":["AddToPrintQueue"]}', 1),
(21, 10, '{$lang.InvoiceDeliveryMethod_descr4}', '', 'paperpdf', '{"enable":["AddToPrintQueue"]}', 1),
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
(54, 43, '200', '', '200', '[]', 1);
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('OrderOfReplies', 'oldest');
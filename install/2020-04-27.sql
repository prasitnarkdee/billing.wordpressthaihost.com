REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('CNoteIssueForUnpaidAuto', 'off'),
('CNoteIssueForUnpaidAutoValue', '30');
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'clientarea', 'sautorenew_enabled', 'If <strong>auto-renew is enabled</strong>, we will issue a renewal invoice for the subscription automatically.' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'sautorenew_disabled', 'If <strong>auto-renew is disabled</strong>, the subscription will terminate upon reaching its due date. You will need to request renewal manually for each billing period.' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'clientarea', 'sautorenew_paymethod', 'Default payment method' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'global', 'Creditedinvoices', 'Credited invoices' FROM hb_language WHERE target != 'user'
UNION SELECT id, 'clientarea', 'sautorenew_renewal', 'Renewal invoices may be automatically paid depending on selected payment option.' FROM hb_language WHERE target = 'user';
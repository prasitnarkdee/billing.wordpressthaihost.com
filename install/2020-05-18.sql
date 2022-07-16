REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'disable_access_to_departments', 'Disable access to following departments' FROM hb_language;
##########
ALTER TABLE `hb_invoice_items`
ADD COLUMN `position` INT NOT NULL DEFAULT 0 AFTER `qty`;
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('CreditOnDowngradeOverride', '');

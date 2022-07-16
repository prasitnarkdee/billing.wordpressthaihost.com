REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'domains', 'confirm_cancel_domain', 'Do you really want to cancel this domain?' FROM hb_language
UNION SELECT id, 'domains', 'CancelDomain', 'Cancel Domain' FROM hb_language
UNION SELECT id, 'clientarea', 'cancelation_pending_for_domain','Cancelation request was placed for this domain. If this was done by mistake please open a support ticket to notify us immediately' FROM hb_language
;
##########
ALTER TABLE `hb_cancel_requests` CHANGE COLUMN `account_id` `item_id` INT(11) NOT NULL AFTER `type`,
DROP INDEX `account_id`,
ADD INDEX `account_id` (`item_id`);
##########
ALTER TABLE `hb_cancel_requests` ADD COLUMN `item_type` ENUM('Account','Domain') NULL DEFAULT 'Account' AFTER `item_id`;
##########
UPDATE `hb_reports` SET `query` = 'SELECT cd.id as `Client ID`, CONCAT(cd.firstname,'' '',cd.lastname) as `Client`, COUNT(c.id) as `Cancellations Count`  FROM hb_cancel_requests c  INNER JOIN hb_accounts a ON a.id = c.item_id  INNER JOIN hb_client_details cd ON cd.id = a.client_id  WHERE c.item_type = ''Account'' AND c.date >= :date_bottom  AND c.date <= :date_top   GROUP BY cd.id'
WHERE type='Orders'  AND name= "Number of cancelations per customer in given period";
##########
UPDATE `hb_reports` SET `query` = 'SELECT cd.id as `Product ID`, cd.name as `Product Name`, cat.name as `Category Name`, COUNT(c.id) as `Cancellations Count` FROM hb_cancel_requests c INNER JOIN hb_accounts a ON a.id = c.item_id INNER JOIN hb_products cd ON cd.id = a.product_id INNER JOIN hb_categories cat ON cat.id = cd.category_id WHERE c.item_type = ''Account'' AND c.date >= :date_bottom AND c.date <= :date_top GROUP BY cd.id'
WHERE type='Orders'  AND name= "Number of cancelations per product in given period";
##########
UPDATE hb_language_locales SET section='global' WHERE keyword='cancel_request_removed' AND `section`='accounts';
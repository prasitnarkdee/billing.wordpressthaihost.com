ALTER TABLE `hb_language` ADD COLUMN `direction` ENUM('ltr','rtl') NOT NULL DEFAULT 'ltr' AFTER `status`;
##########
ALTER TABLE `hb_language` ADD COLUMN `iso` VARCHAR(4) NULL AFTER `direction`;
##########
CREATE TABLE IF NOT EXISTS `hb_cancelation_reasons` (
  `id` INT(10) NOT NULL AUTO_INCREMENT,
  `reason` VARCHAR (250) NOT NULL,
  `target` ENUM('all','service','domain') DEFAULT 'all',
  `counter` INT(10) NOT NULL DEFAULT '0',
  `sort_order` INT(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'cancellation_reasons', 'Cancellation Reasons' FROM hb_language
UNION SELECT id, 'global', 'cancel_reason_blank', 'There are no set reasons for cancellation' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'add_reason', 'Add a reason' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'reason_added', 'The reason has been correctly added' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'reason_empty', 'The reason cannot be empty' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'reason_edited', 'The reason has been correctly edited' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'reason_removed', 'The reason has been removed' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'reason_delete_confirm', 'Are you sure you want to delete cancellation reason?' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'cancel_describe2', 'Please select a reason for cancellation:' FROM hb_language WHERE target = 'user';
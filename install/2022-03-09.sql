CREATE TABLE `hb_coupon_batches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `status` enum('Active','Archived') NOT NULL DEFAULT 'Active',
  `prefix` varchar(32) NOT NULL,
  `coupon_type` enum('cart','invoice') DEFAULT 'cart',
  `type` enum('fixed','percent') NOT NULL,
  `value` decimal(10,2) NOT NULL DEFAULT '0.00',
  `complexity` int NOT NULL,
  `notes` text NOT NULL,
  `coupon_config` text NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##########
ALTER TABLE `hb_coupons` ADD `batch_id` int NOT NULL DEFAULT '0' AFTER `id`;
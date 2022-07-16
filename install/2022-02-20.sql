CREATE TABLE IF NOT EXISTS `hb_module_admin_acl` (
  `code` VARCHAR(50) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `module_id` INT(11) NOT NULL,
  PRIMARY KEY (`code`, `module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE `hb_transaction_data` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `transaction_id` INT NOT NULL,
    `key` VARCHAR(50) NOT NULL,
    `value` TEXT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `transaction_id` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

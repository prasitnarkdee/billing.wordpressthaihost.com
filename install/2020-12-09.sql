CREATE TABLE IF NOT EXISTS `hb_product_log` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `date` datetime NOT NULL,
    `product_id` int(11) NOT NULL,
    `admin_login` text NOT NULL,
    `change` text NOT NULL,
    PRIMARY KEY (`id`),
    KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
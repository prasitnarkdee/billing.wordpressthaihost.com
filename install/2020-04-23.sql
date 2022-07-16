ALTER TABLE `hb_aff_orders` CHANGE `type` `type` ENUM('order','recurring','manual','sub-affiliate','unassigned')  NOT NULL  DEFAULT 'order';

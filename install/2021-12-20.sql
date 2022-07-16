ALTER TABLE `hb_client_group_discount`
ADD COLUMN `domain_type` VARCHAR(200) DEFAULT '' AFTER `type`;
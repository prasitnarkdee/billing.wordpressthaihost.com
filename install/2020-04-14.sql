ALTER TABLE `hb_api_access` DROP INDEX `api_id`;
##########
ALTER TABLE `hb_api_access` CHANGE `api_key` `api_key` TEXT  NOT NULL;
##########
ALTER TABLE `hb_api_access` ADD INDEX (`api_id`);

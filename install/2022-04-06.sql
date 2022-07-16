REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ending_balance', 'Ending Balance' FROM hb_language
UNION SELECT id, 'global', 'client_ccount_balance','Client Account Register Balance' FROM hb_language
UNION SELECT id, 'global', 'account_statement','Account Statement' FROM hb_language
UNION SELECT id, 'global', 'credits','Credits' FROM hb_language
UNION SELECT id, 'global', 'debits','Debits' FROM hb_language
UNION SELECT id, 'global', 'type','Type' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'date','Date' FROM hb_language WHERE target = 'admin'
UNION SELECT id, 'global', 'transaction','Transaction' FROM hb_language
UNION SELECT id, 'configuration', 'AllowAccountStatement','Allow download Account Statement' FROM hb_language WHERE target = 'admin';
##########
ALTER TABLE `hb_templates` CHANGE `target` `target` ENUM('admin','user','invoice','estimate','creditnote','creditreceipt','contract','attachment','accountstatement')  NOT NULL  DEFAULT 'invoice';
##########
INSERT INTO `hb_templates` (`parent_id`, `name`, `target`, `created`, `updated`) VALUES (0, 'Default Account Statement', 'accountstatement', NOW(), NOW());
##########
INSERT INTO `hb_template_content` (`template_id`, `name`, `content`, `checksum`, `updated`)
SELECT id, 'Default Account Statement', '<style>\r\n    body {\r\n        font-size:13px;\r\n        font-family: Verdana, Arial, Helvetica;\r\n    }\r\n    div {\r\n        padding:15px;\r\n    }\r\n    table {\r\n        border-collapse: collapse;\r\n        width: 100%;\r\n        border: 1px solid #dddddd;\r\n    }\r\n    th, td {\r\n        padding: 8px;\r\n        text-align: left;\r\n        border-bottom: 1px solid #ddd;\r\n    }\r\n    .background {\r\n        background-color:#efefef;\r\n    }\r\n</style>\r\n<div>\r\n    <table style="border:none;">\r\n        <tr>\r\n            <td width=80% style="text-align:left;"><h2>{$business_name} - {$lang.account_statement}</h2></td>\r\n            <td width=20% style="text-align:right;">{$date}</td>\r\n        </tr>\r\n    </table>\r\n    <p>\r\n        <span style="font-size: 12px;">\r\n            {$client.companyname}<br /> \r\n            {$client.firstname} {$client.lastname}<br /> \r\n            {$client.address1} <br /> \r\n            {$client.address2}<br /> \r\n            {$client.city}, {$client.state}{$client.postcode}<br /> \r\n            {$client.country} \r\n        </span> \r\n    </p>\r\n    <table>\r\n        <thead>\r\n            <tr class="background">\r\n                <th>{$lang.type}</th>\r\n                <th>{$lang.date}</th>\r\n                <th>{$lang.Description}</th>\r\n                <th>{$lang.credits}</th>\r\n                <th>{$lang.debits}</th>\r\n                <th>{$lang.balance}</th>\r\n            </tr>\r\n        </thead>\r\n        <tbody>\r\n            {foreach from=$statement item=item}\r\n                <tr>\r\n                    <td>{$item.type}</td>\r\n                    <td>{$item.date}</td>\r\n                    <td>{$item.description}</td>\r\n                    <td>{$item.credits}</td>\r\n                    <td>{$item.debits}</td>\r\n                    <td>{$item.balance}</td>\r\n                </tr>\r\n            {/foreach}\r\n            <tr class="background">\r\n                <td colspan=2></td>\r\n                <td>{$lang.ending_balance}</td>\r\n                <td>{$ending.credits}</td>\r\n                <td>{$ending.debits}</td>\r\n                <td>{$ending.balance}</td>\r\n            </tr>\r\n        </tbody>\r\n    </table>\r\n</div>', 'ceb87047e8238deac4f90bf648ce43ea', NOW()
FROM `hb_templates` WHERE `name` = 'Default Account Statement';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('AccountStatementTemplate', (SELECT id FROM `hb_templates` WHERE `name` = 'Default Account Statement')),
('AllowAccountStatement', 'off');
##########
UPDATE IGNORE hb_language_locales SET `section`='global' WHERE `keyword`='invoice' AND `section`='clientarea';
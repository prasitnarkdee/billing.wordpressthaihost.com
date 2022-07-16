ALTER TABLE `hb_templates` CHANGE `target` `target` ENUM('admin','user','invoice','estimate','creditnote','creditreceipt','contract','attachment')  NOT NULL  DEFAULT 'invoice';
##########
UPDATE hb_templates t JOIN hb_contracts c ON c.template_id = t.id SET t.target='contract';
##########
INSERT INTO `hb_templates` (`parent_id`, `name`, `target`, `created`, `updated`) VALUES (0, 'Order Summary', 'attachment', NOW(), NOW());
##########
INSERT INTO `hb_template_content` (`template_id`, `name`, `content`, `checksum`, `updated`)
SELECT id, 'Order Summary', '<style type=\"text/css\"><!--\r\nbody {\r\n    font-family: Arial;\r\n}\r\n--></style>\r\n<div style=\"padding: 40px; font-size: 18px;\">\r\n<table style=\"width: 100%;\">\r\n<tbody>\r\n<tr>\r\n<td><strong style=\"font-size: 18px;\">{$business_name}</strong></td>\r\n<td align=\"right\"><span style=\"font-size: 18px;\">Order  #{$order.number}</span></td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p align=\"center\" style=\"padding: 20px;\"><strong>Thank you for your recent order!</strong></p>\r\n<div style=\"padding-bottom: 10px;\">This email is confirmation we\'ve received your order</div>\r\n<div style=\"padding-bottom: 10px;\">Following items were ordered:\r\n<ul>{foreach from=$order_details item=item}\r\n<li><strong> {$item.description} </strong> <span> {$item.amount|price:$currency}</span></li>\r\n{/foreach}</ul>\r\n</div>\r\n<div style=\"padding-bottom: 10px;\">We inform you additionally that:<ol>\r\n<li>We will activate your order as soon as possible after accounting payment (if applies) for this order</li>\r\n</ol></div>\r\n</div>', 'e6f207c899a726152e1b68187e407785', NOW()
FROM `hb_templates` WHERE `name` = 'Order Summary';

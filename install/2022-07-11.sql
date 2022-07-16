INSERT INTO `hb_configuration` (`setting`, `value`) VALUES ('NotifyLowStock', '0');
##########
INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`, `sender_id`)
VALUES ('Product: Low Stock', 'Product', 'Admin', 1, 'Product {$product.name} stock is low', 'Following product available stock decreased below {$threshold}.\r\nCurrently there are {$product.qty} used out of {$product.stock} available items.\r\n--\r\nProduct: {$product.category_name}: {$product.name}\r\nLink: {$admin_url}?cmd=services&action=product&id={$product.id}\r\n--', '', 1, 1, 1, 0, 0, 1, 0);
##########
UPDATE `hb_widgets_config` SET `options`=17 WHERE widget='manualrenew';
INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`, `displayname`)
VALUES
	(NULL, 'Orders', 'Domain Contracts', 'SELECT cd.id as `Client ID`,\r\n cd.firstname as `Firstname`,\r\n cd.lastname as `Lastname`,\r\n cd.companyname as `Company`,\r\n o.id as `Order ID`,\r\n ct.id as `Contract Id`,\r\n ct.number as `Contract number`,\r\n ct.created_at as `Contract date`,\r\n ct.accepted_at as `Accepted at`,\r\n ct.expires as `Contract Expires`,\r\n ct.status as `Contract Status`,\r\n o.status as `Order Status`,\r\n ct.public_notes as `Contract Notes`,\r\n t.name as `Contract template name`,\r\n CONCAT(ccd.firstname,\' \',ccd.lastname) as `Accepted by`,\r\n d.id as `Domain ID`,\r\n d.name as `Domain`,\r\n d.status as `Domain Status`,\r\n p.name as `TLD`,\r\n c.name as `Orderpage name` \r\nFROM hb_order_contracts oc \r\nINNER JOIN hb_client_contracts ct ON oc.contract_id = ct.id \r\nINNER JOIN hb_contracts t ON t.id = ct.template_id \r\nINNER JOIN hb_orders o ON o.id = oc.order_id \r\nINNER JOIN hb_client_details cd ON cd.id = ct.client_id \r\nINNER JOIN hb_domains d ON d.order_id = o.id \r\nINNER JOIN hb_products p ON p.id = d.tld_id \r\nINNER JOIN hb_categories c ON c.id = p.category_id \r\nLEFT JOIN hb_client_details ccd ON ccd.id = ct.accepted_by \r\nWHERE\r\n ct.created_at >= :date_bottom \r\nAND ct.created_at <= :date_top', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:22:\"{$current_month_start}\";s:9:\":date_top\";s:20:\"{$current_month_end}\";}s:10:\"conditions\";a:0:{}s:6:\"output\";s:4:\"html\";}', 'a:20:{i:0;s:9:\"Client ID\";i:1;s:9:\"Firstname\";i:2;s:8:\"Lastname\";i:3;s:7:\"Company\";i:4;s:8:\"Order ID\";i:5;s:11:\"Contract Id\";i:6;s:15:\"Contract number\";i:7;s:13:\"Contract date\";i:8;s:11:\"Accepted at\";i:9;s:16:\"Contract Expires\";i:10;s:15:\"Contract Status\";i:11;s:12:\"Order Status\";i:12;s:14:\"Contract Notes\";i:13;s:22:\"Contract template name\";i:14;s:11:\"Accepted by\";i:15;s:9:\"Domain ID\";i:16;s:3:\"TLD\";i:17;s:6:\"Domain\";i:18;s:13:\"Domain Status\";i:19;s:14:\"Orderpage name\";}', 'Domain Contracts'),
	(NULL, 'Orders', 'Account Contracts', 'SELECT cd.id as `Client ID`,\r\n cd.firstname as `Firstname`,\r\n cd.lastname as `Lastname`,\r\n cd.companyname as `Company`,\r\n o.id as `Order ID`,\r\n ct.id as `Contract Id`,\r\n ct.number as `Contract number`,\r\n ct.created_at as `Contract date`,\r\n ct.accepted_at as `Accepted at`,\r\n ct.expires as `Contract Expires`,\r\n ct.status as `Contract Status`,\r\n o.status as `Order Status`,\r\n ct.public_notes as `Contract Notes`,\r\n t.name as `Contract template name`,\r\n CONCAT(ccd.firstname,\' \',ccd.lastname) as `Accepted by`,\r\n a.id as `Account ID`,\r\n a.status as `Account Status`,\r\n p.id as `Product ID`,\r\n p.name as `Product Name`,\r\n c.name as `Orderpage name` \r\nFROM hb_order_contracts oc \r\nINNER JOIN hb_client_contracts ct ON oc.contract_id = ct.id \r\nINNER JOIN hb_contracts t ON t.id = ct.template_id \r\nINNER JOIN hb_orders o ON o.id = oc.order_id \r\nINNER JOIN hb_client_details cd ON cd.id = ct.client_id \r\nINNER JOIN hb_accounts a ON a.order_id = o.id \r\nINNER JOIN hb_products p ON p.id = a.product_id \r\nINNER JOIN hb_categories c ON c.id = p.category_id \r\nLEFT JOIN hb_client_details ccd ON ccd.id = ct.accepted_by \r\nWHERE\r\n ct.created_at >= :date_bottom \r\nAND ct.created_at <= :date_top', 1, 'sql', 'a:3:{s:6:\"params\";a:2:{s:12:\":date_bottom\";s:22:\"{$current_month_start}\";s:9:\":date_top\";s:20:\"{$current_month_end}\";}s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:20:{i:0;s:9:\"Client ID\";i:1;s:9:\"Firstname\";i:2;s:8:\"Lastname\";i:3;s:7:\"Company\";i:4;s:8:\"Order ID\";i:5;s:11:\"Contract Id\";i:6;s:15:\"Contract number\";i:7;s:13:\"Contract date\";i:8;s:11:\"Accepted at\";i:9;s:16:\"Contract Expires\";i:10;s:15:\"Contract Status\";i:11;s:12:\"Order Status\";i:12;s:14:\"Contract Notes\";i:13;s:22:\"Contract template name\";i:14;s:11:\"Accepted by\";i:15;s:10:\"Account ID\";i:16;s:14:\"Account Status\";i:17;s:10:\"Product ID\";i:18;s:14:\"Orderpage name\";i:19;s:12:\"Product Name\";}', 'Account Contracts');
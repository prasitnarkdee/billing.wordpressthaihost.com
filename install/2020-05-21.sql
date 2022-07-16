INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`, `displayname`)
VALUES
	(NULL, 'Invoices', 'Billable Products & their configuration items', 'report.billableproductsandconfigs.php', 0, 'php', 'a:3:{s:6:\"params\";N;s:10:\"conditions\";N;s:6:\"output\";s:4:\"html\";}', 'a:23:{i:0;s:4:\"Type\";i:1;s:2:\"id\";i:2;s:4:\"Name\";i:3;s:16:\"Belongs to: type\";i:4;s:14:\"Belongs to: id\";i:5;s:16:\"Belongs to: name\";i:6;s:6:\"status\";i:7;s:12:\"Billing type\";i:8;s:1:\"m\";i:9;s:7:\"m_setup\";i:10;s:9:\"m_upgrade\";i:11;s:1:\"q\";i:12;s:7:\"q_setup\";i:13;s:9:\"q_upgrade\";i:14;s:1:\"a\";i:15;s:7:\"a_setup\";i:16;s:9:\"a_upgrade\";i:17;s:1:\"b\";i:18;s:7:\"b_setup\";i:19;s:9:\"b_upgrade\";i:20;s:1:\"t\";i:21;s:7:\"t_setup\";i:22;s:9:\"t_upgrade\";}', 'Billable Products & their configuration items');
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('RecalculateCurrencyChange', 'off');

INSERT INTO `hb_reports` (`id`, `type`, `name`, `query`, `options`, `handler`, `state`, `columns`, `displayname`)
VALUES
	(NULL, 'Invoices', 'Estimated Income This Month', 'report.estimatedincomethismonth.php', 0, 'php', 'a:3:{s:6:"params";N;s:10:"conditions";N;s:6:"output";s:4:"html";}', 'a:2:{i:0;s:8:"Currency";i:1;s:16:"Estimated Income";}', 'Estimated Income This Month');
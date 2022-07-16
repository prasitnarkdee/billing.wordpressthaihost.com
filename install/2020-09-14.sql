ALTER TABLE hb_domains ADD `server_id` INT(11) NOT NULL DEFAULT 0 AFTER `name`;
##########
UPDATE hb_servers s
INNER JOIN hb_server_groups g ON s.group_id = g.id
INNER JOIN hb_modules_configuration m ON (s.default_module = m.id)
SET s.group_id = (SELECT g2.id FROM hb_server_groups g2 WHERE g.module = g2.module ORDER BY id LIMIT 1), s.`default` = '0'
WHERE m.`type` = 'Domain';
##########
DELETE s FROM hb_server_groups s
INNER JOIN hb_modules_configuration m ON s.module = m.id
WHERE s.id NOT IN (SELECT group_id FROM hb_servers) AND m.`type` = 'Domain';
##########
UPDATE hb_servers s
INNER JOIN (SELECT se.id FROM hb_servers se INNER JOIN hb_modules_configuration mc ON se.default_module = mc.id WHERE mc.`type` = 'Domain' GROUP BY group_id) s2 ON s.id = s2.id
SET s.`default` = '1';
##########
UPDATE hb_domains d
INNER JOIN hb_servers s ON d.reg_module = s.default_module AND s.`default` = '1'
SET d.server_id = s.id;
##########
UPDATE hb_products_modules p
INNER JOIN hb_servers s ON p.module = s.default_module AND s.`default` = '1'
INNER JOIN hb_modules_configuration m ON (p.module = m.id)
SET p.server = s.id WHERE m.`type` = 'Domain';
##########
UPDATE hb_servers s
INNER JOIN hb_modules_configuration m ON (s.default_module = m.id)
SET s.custom = m.config
WHERE m.`type` = 'Domain';
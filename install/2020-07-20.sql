REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'services', 'addnewsubcategory', 'Add new sub-category' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'orpage_blank_cats', 'This order page doesn''t have sub-categories' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'subcategories', 'Sub-categories' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'categories', 'Categories' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'contains', 'Contains' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'orpage_blank_subcats', 'To begin create new sub-category' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'orpage_blank_subcats_desc', 'HostBill allows you to divide categories into sub-categories, each of which may contain different products.' FROM hb_language WHERE target='admin'
UNION SELECT id, 'cart', 'subcatproducts', 'products' FROM hb_language WHERE target!='admin'
UNION SELECT id, 'ssl', 'csr_with_password_challenge_error', 'CSR contains a challenge phrase, please generate a new CSR that does not contain a challenge phrase' FROM hb_language WHERE target = 'user';;
##########
ALTER TABLE `hb_categories` ADD `parent_id` int(11) NOT NULL DEFAULT 0 AFTER `id`;
##########
ALTER TABLE `hb_categories` ADD `contains` enum('categories','products') NOT NULL DEFAULT 'products' AFTER `parent_id`;
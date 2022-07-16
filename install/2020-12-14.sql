REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('StoreXMLInvoice', 'off'),
('AttachXMLInvoicePaid', 'off'),
('StoreXMLPath', '')
;
##########
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'configuration', 'StoreXMLInvoice', 'Store XML invoice' FROM hb_language WHERE target='admin'
UNION SELECT id, 'global', 'downloadxmlubf', 'Download XML/UBL' FROM hb_language
UNION SELECT id, 'configuration', 'AttachXMLInvoicePaid', 'Attach XML invoice' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'AttachXMLInvoicePaid_descr', 'add XML/UBL invoice to email notification' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'AttachXMLInvoicePaid_descr1', 'do not attach XML invoices' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'StoreXMLInvoice_descr', 'store final XML invoice under:' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'StoreXMLInvoice_descr1', 'dont store, generate XML/UBL each time its requested' FROM hb_language WHERE target='admin'
UNION SELECT id, 'configuration', 'StoreXMLInvoice_descr2', 'Provide full path to folder where HostBill should store your XML invoices, it should have same chmod/owner as templates_c folder' FROM hb_language WHERE target='admin';

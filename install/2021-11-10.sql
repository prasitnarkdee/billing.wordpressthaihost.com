INSERT INTO `hb_email_templates` (`tplname`, `group`, `for`, `language_id`, `subject`, `message`, `altmessage`, `send`, `plain`, `system`, `hidden`, `notify`, `loglevel`)
VALUES ('Estimate:Accepted', 'Invoice', 'Admin', 1, 'Estimate #{$invoice.id}: Accepted', '<h1>Estimate #{$estimate.id} has been accepted by client</h1>\r\n\r\n<h2>Details</h2>\r\n<p>\r\n    <b>Estimate ID:</b> {$estimate.id}<br>\r\n    <b>Estimate URL:</b> {$estimate_url}<br>\r\n    {if $estimate.invoice_id}\r\n        <b>Invoice ID:</b> {$estimate.invoice_id}<br>\r\n        <b>Invoice URL:</b> {$invoice_url}<br>\r\n    {/if}\r\n</p>', 'Estimate #{$estimate.id} has been accepted by client\r\n\r\n---------------------------------------------------------------\r\nDetails\r\n---------------------------------------------------------------\r\n# Estimate ID: {$estimate.id}\r\n# Estimate URL: {$estimate_url}\r\n{if $estimate.invoice_id}\r\n# Invoice ID: {$estimate.invoice_id}\r\n# Invoice URL: {$invoice_url}\r\n{/if}\r\n\r\n', 1, 2, 0, 0, 0, 1);
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('ApprovingEstimateByClient', 'generate');
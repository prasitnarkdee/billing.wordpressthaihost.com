REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'ReceiptNumerationAfterPayment','Generate Credit Receipt number after payment' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'ReceiptNumerationAfterPaymentON','<b>Yes</b>, generate credit receipt number  after payment' FROM hb_language  WHERE target='admin'
UNION SELECT id, 'global', 'ReceiptNumerationAfterPaymentOFF','<b>No</b>, issue credit receipt number immediately' FROM hb_language  WHERE target='admin';
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('ReceiptNumerationAfterPayment', 'off');
##########
REPLACE INTO hb_configuration (`setting`, `value`) VALUES
('CancellationTypeImmediate', 'on'),
('CancellationTypeEndPeriod', 'on');

REPLACE INTO hb_configuration (`setting`, `value`) VALUES ('SSLPeriodYears', 'off');
##########
ALTER TABLE hb_ticket_departments_import DROP INDEX `hash`;
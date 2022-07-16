REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'passistoolong', 'Password is too long' FROM hb_language
UNION SELECT id, 'cart', 'iwantupdate_outside','Use domain registered outside of <b>%s</b>' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'cart', 'iwantupdate_cart','Use domain from cart' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'cart', 'iwantupdate_myaccount','Use domain from my account' FROM hb_language WHERE target = 'user'
UNION SELECT id, 'cart', 'youdonthaveactivedomain','You currently don''t have active domains with us' FROM hb_language WHERE target = 'user';
##########
INSERT IGNORE INTO  hb_configuration (`setting`, `value`) VALUES
('DomainClientareaLayout', 'left');
##########
INSERT IGNORE INTO  hb_configuration (`setting`, `value`) VALUES
('DomainCancellationRequest', 'off');
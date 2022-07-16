REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'pendingReviewOrder','Edit Order Ownership' FROM hb_language WHERE target='admin'
UNION SELECT id, 'services', 'BeforePromo', 'Before Promo' FROM hb_language;

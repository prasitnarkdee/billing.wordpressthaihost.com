REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'profiles', 'fillwithmainprofiledetails','Fill in with the main profile details' FROM hb_language WHERE target='user';
REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT id, 'global', 'active_referral_info', 'Referral cookie is active for affiliate #%d&nbsp;%s. <br /><a class="text-dark" href="%s">Click here to deactivate it</a>' FROM hb_language WHERE target='user';
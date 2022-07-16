REPLACE INTO `hb_language_locales` (`language_id`,`section`,`keyword`,`value`)
SELECT `id`, 'global', 'note_client_viewable','Client viewable' FROM hb_language WHERE target='admin'
UNION SELECT `id`, 'clientarea', 'Notes','Notes' FROM hb_language WHERE target='user';
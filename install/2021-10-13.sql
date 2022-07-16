REPLACE INTO hb_automation_settings
SELECT p.id, 'Hosting', 'EnableAutoCreation', p.autosetup FROM hb_products p;
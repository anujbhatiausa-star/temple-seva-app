-- Seed data extracted from the yearlySevas and mahotsavams arrays that used
-- to live in frontend/temple-seva-app.html. Safe to re-run (upserts by id).

insert into public.sevas (id, name, category, base_price, homam_label, homam_price, recurrence_note, active)
values
  ('pradosha-siva', 'Pradosha Siva Seva', 'yearly', 521, 'with Rudra homam', 621, 'Rudra abhishekams (24) and archana to Lord Shiva', true),
  ('rudrabhishekam-monday', 'Rudrabhishekam & Bhasma Archana', 'yearly', 521, 'with Rudra homam', 621, 'On Mondays (52 times a year)', true),
  ('chaturthi-ganesha', 'Chaturthi Ganesha Seva', 'yearly', 521, 'with Ganesha homam', 621, 'Abhishekams (24) and archana to Ganesha', true),
  ('poornima-satyanarayana', 'Poornima Satyanarayana Seva', 'yearly', 261, 'with Purushasukta homam', 361, 'Pooja and abhishekam (12 times a year)', true),
  ('ekadasi-satyanarayana', 'Ekadasi Satyanarayana Seva', 'yearly', 521, 'with Sudarsana homam', 621, 'Pooja and abhishekam (24 times a year)', true),
  ('ekadasi-srinivasa', 'Ekadasi Srinivasa Seva', 'yearly', 521, null, null, 'Abhishekams (24) to Srinivasa, Sridevi, Bhudevi', true),
  ('balaji-saturday', 'Balaji Seva', 'yearly', 521, null, null, 'Abhishekams and Vishnu sahasranama parayan (52), on Saturdays', true),
  ('laddu-balaji', 'Laddu Seva to Balaji', 'yearly', 521, null, null, '11 laddus and sahasranama parayan on Saturdays (52)', true),
  ('ram-parivar-vada-mala', 'Ram Parivar Vada Mala Seva', 'yearly', 521, null, null, 'Vada mala seva and Hanuman archana on Tuesdays (52)', true),
  ('sri-chakra', 'Friday & Poornima Sri Chakra Poojas', 'yearly', 501, 'with Srisukta homam', 651, '60+ poojas a year', true),
  ('maha-lakshmi', 'Maha Lakshmi Seva', 'yearly', 1101, null, null, 'Abhishekams and archanas on Sundays (52)', true),
  ('ram-parivar-nakshtra', 'Ram Parivar Nakshtra Seva', 'yearly', 521, null, null, 'Alankaram, archana and homam on Punarvasu Nakshtram (12)', true),
  ('radha-krishna-nakshtra', 'Radha Krishna Nakshtra Seva', 'yearly', 521, null, null, 'Alankaram, archana and homam on Rohini Nakshtram (12)', true),
  ('samvatsara-devi', 'Samvatsara Devi Seva', 'yearly', 521, null, null, 'Lalitha (Friday) and Lakshmi (Sunday), sahasranama archanas', true),
  ('nitya-devata-1', 'Samvatsara Nitya Devata Aradhana', 'yearly', 1101, null, null, 'Daily archana, 365 days a year', true),
  ('navagraha-homam', 'Navagraha Homam Seva', 'yearly', 1101, null, null, 'Homam, abhishekam and archana on Saturdays (52)', true),
  ('shukla-shasthi', 'Shukla Shasthi Subrahmanya Seva', 'yearly', 261, null, null, 'Abhishekam and archana (12 times a year)', true),
  ('phalguni-ayyappa', 'U. Phalguni Nakshtra Seva', 'yearly', 261, null, null, 'Abhishekam and archana for Ayyappa (12 times a year)', true),
  ('nitya-devata-2', 'Samvatsara Nitya Devata Aradhana II', 'yearly', 1101, null, null, 'Daily archana, 365 days a year', true),
  ('sugandhi-mala', 'Sugandhi Mala Seva', 'yearly', 601, null, null, '52 weeks of fragrant garland seva', true),
  ('thomala', 'Thomala Seva', 'yearly', null, null, null, 'Please call the temple office to inquire', true),
  ('nakshtra-pooja', 'Nakshtra Pooja', 'yearly', 151, null, null, 'One-time nakshtra pooja', true),
  ('annadanam', 'Annadanam', 'yearly', 101, null, null, 'Thursday food offering seva', true),
  ('samvatsara-rudrabhishekam', 'Samvatsara Rudrabhishekam', 'yearly', 5001, null, null, 'Siva abhishekam and archana daily for a year (365) — includes pradoshams and Maha Sivaratri sevas', true),

  ('new-year', 'New Year Mahotsavam', 'mahotsavam', 101, null, null, 'Sarva devatha archana', true),
  ('sivaratri', 'Sivaratri Mahotsavam', 'mahotsavam', 201, null, null, 'Maha Pradosham, Sivaratri, Uma Maheswara Kalyanam', true),
  ('vasantha-navaratri', 'Vasantha Navaratri Mahotsavam', 'mahotsavam', 201, null, null, 'Nine days poojas, Chandi homam', true),
  ('rama-navami', 'Rama Navami Mahotsavam', 'mahotsavam', 101, null, null, 'Rama''s birth, abhishekam, and Sita Rama Kalyanam', true),
  ('shravan-somvara', 'Shravan Somvara Siva Abhishekams', 'mahotsavam', 101, null, null, 'Monday Shravan-month abhishekams', true),
  ('janmashtami', 'Janmashtami Mahotsavam', 'mahotsavam', 101, null, null, 'Krishna''s birth, abhishekam, Rukmini Kalyanam', true),
  ('ganesha-chaturthi', 'Ganesha Chaturthi Mahotsavam', 'mahotsavam', 101, null, null, 'Abhishekam, sit-down pooja, Sahasra modaka archana', true),
  ('balaji-mahotsavam', 'Balaji Mahotsavam', 'mahotsavam', 101, null, null, '5 days poojas, Srinivasa Kalyanam', true),
  ('navaratri', 'Navaratri Mahotsavam', 'mahotsavam', 251, null, null, 'Nine days pooja, Nava Chandi homam, Uma Maheswara Kalyanam', true),
  ('skanda', 'Skanda Mahotsavam', 'mahotsavam', 101, null, null, 'Six days abhishekam, Soora Samharam, Valli Kalyanam', true),
  ('kartika-somavara', 'Kartika Somavara Siva Abhishekams', 'mahotsavam', 101, null, null, 'Monday abhishekams during Kartika month', true),
  ('ayyappa-mandala', 'Ayyappa Mandala Mahotsavam', 'mahotsavam', 151, null, null, '40 days poojas', true),
  ('dhanurmasa', 'Dhanurmasa Mahotsavam', 'mahotsavam', 101, null, null, '30 days poojas, Andal Kalyanam', true)

on conflict (id) do update set
  name = excluded.name,
  category = excluded.category,
  base_price = excluded.base_price,
  homam_label = excluded.homam_label,
  homam_price = excluded.homam_price,
  recurrence_note = excluded.recurrence_note,
  active = excluded.active;

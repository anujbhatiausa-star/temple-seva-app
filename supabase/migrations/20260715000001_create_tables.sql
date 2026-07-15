-- Core schema for the Sri Maha Lakshmi Devasthanam seva sponsorship app.

create extension if not exists pgcrypto;

-- Sevas: the catalog of yearly sevas and mahotsavams offered by the temple.
-- id is a human-readable slug (matches the front end) rather than a uuid.
create table public.sevas (
  id text primary key,
  name text not null,
  category text not null check (category in ('yearly', 'mahotsavam')),
  base_price numeric(10,2),
  homam_label text,
  homam_price numeric(10,2),
  recurrence_note text,
  active boolean not null default true
);

-- Devotees: contact info for whoever submits a sponsorship.
create table public.devotees (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text,
  email text,
  address text,
  created_at timestamptz not null default now()
);

-- Submissions: one sponsorship submission (one or more sevas) by a devotee.
create table public.submissions (
  id uuid primary key default gen_random_uuid(),
  devotee_id uuid not null references public.devotees(id),
  wish text,
  total_amount numeric(10,2) not null default 0,
  status text not null default 'pending' check (status in ('pending', 'confirmed', 'paid', 'fulfilled')),
  created_at timestamptz not null default now()
);

-- Submission items: the individual sevas selected within a submission.
create table public.submission_items (
  id uuid primary key default gen_random_uuid(),
  submission_id uuid not null references public.submissions(id) on delete cascade,
  seva_id text not null references public.sevas(id),
  with_homam boolean not null default false,
  price_charged numeric(10,2) not null
);

-- Sankalpam entries: family members named in the sankalpam for a submission.
create table public.sankalpam_entries (
  id uuid primary key default gen_random_uuid(),
  submission_id uuid not null references public.submissions(id) on delete cascade,
  gotram text,
  nakshtram text,
  name text,
  relationship text
);

-- Notifications: SMS/e-mail delivery log for a submission (stubbed for now — see api/notify.js).
create table public.notifications (
  id uuid primary key default gen_random_uuid(),
  submission_id uuid not null references public.submissions(id) on delete cascade,
  channel text not null check (channel in ('sms', 'email')),
  status text not null default 'queued' check (status in ('queued', 'sent', 'failed')),
  sent_at timestamptz,
  provider_message_id text
);

create index submissions_devotee_id_idx on public.submissions(devotee_id);
create index submission_items_submission_id_idx on public.submission_items(submission_id);
create index submission_items_seva_id_idx on public.submission_items(seva_id);
create index sankalpam_entries_submission_id_idx on public.sankalpam_entries(submission_id);
create index notifications_submission_id_idx on public.notifications(submission_id);

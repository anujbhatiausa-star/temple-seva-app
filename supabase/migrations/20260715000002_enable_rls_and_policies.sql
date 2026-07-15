-- Row Level Security for the seva sponsorship app.
-- "Staff" = any authenticated Supabase Auth user. Staff accounts are created
-- manually in the Supabase dashboard — there is no public sign-up flow, so
-- "authenticated" is a safe proxy for "staff" here.

alter table public.sevas enable row level security;
alter table public.devotees enable row level security;
alter table public.submissions enable row level security;
alter table public.submission_items enable row level security;
alter table public.sankalpam_entries enable row level security;
alter table public.notifications enable row level security;

-- sevas: public can view only active sevas; staff can view all (including
-- retired ones, so old ledger entries still resolve seva names correctly).
create policy "Public can view active sevas" on public.sevas
  for select to public using (active = true);

create policy "Staff can view all sevas" on public.sevas
  for select to authenticated using (true);

-- devotees: public can submit new devotees; only staff can read/update.
create policy "Public can insert devotees" on public.devotees
  for insert to public with check (true);

create policy "Staff can view devotees" on public.devotees
  for select to authenticated using (true);

create policy "Staff can update devotees" on public.devotees
  for update to authenticated using (true) with check (true);

-- submissions: public can submit; only staff can read/update (e.g. status).
create policy "Public can insert submissions" on public.submissions
  for insert to public with check (true);

create policy "Staff can view submissions" on public.submissions
  for select to authenticated using (true);

create policy "Staff can update submissions" on public.submissions
  for update to authenticated using (true) with check (true);

-- submission_items
create policy "Public can insert submission items" on public.submission_items
  for insert to public with check (true);

create policy "Staff can view submission items" on public.submission_items
  for select to authenticated using (true);

create policy "Staff can update submission items" on public.submission_items
  for update to authenticated using (true) with check (true);

-- sankalpam_entries
create policy "Public can insert sankalpam entries" on public.sankalpam_entries
  for insert to public with check (true);

create policy "Staff can view sankalpam entries" on public.sankalpam_entries
  for select to authenticated using (true);

create policy "Staff can update sankalpam entries" on public.sankalpam_entries
  for update to authenticated using (true) with check (true);

-- notifications: no public access at all (no insert, no select policy for
-- public); only staff can view.
create policy "Staff can view notifications" on public.notifications
  for select to authenticated using (true);

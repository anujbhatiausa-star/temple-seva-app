-- Single RPC that atomically writes a devotee + submission + submission_items
-- + sankalpam_entries for a new sponsorship, instead of four separate
-- client-side inserts. SECURITY DEFINER so it can perform all four writes in
-- one transaction regardless of the caller's row (the public insert-only RLS
-- policies still apply to any direct table access, e.g. from the dashboard).
create or replace function public.create_submission(
  p_devotee jsonb,    -- {name, phone, email, address}
  p_wish text,
  p_items jsonb,      -- [{seva_id, with_homam, price_charged}, ...]
  p_sankalpam jsonb   -- [{gotram, nakshtram, name, relationship}, ...]
)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  v_devotee_id uuid;
  v_submission_id uuid;
  v_total numeric(10,2) := 0;
  v_item jsonb;
  v_sank jsonb;
begin
  insert into public.devotees (name, phone, email, address)
  values (
    p_devotee->>'name',
    nullif(p_devotee->>'phone', ''),
    nullif(p_devotee->>'email', ''),
    nullif(p_devotee->>'address', '')
  )
  returning id into v_devotee_id;

  select coalesce(sum((item->>'price_charged')::numeric), 0)
  into v_total
  from jsonb_array_elements(p_items) as item;

  insert into public.submissions (devotee_id, wish, total_amount, status)
  values (v_devotee_id, nullif(p_wish, ''), v_total, 'pending')
  returning id into v_submission_id;

  for v_item in select * from jsonb_array_elements(p_items)
  loop
    insert into public.submission_items (submission_id, seva_id, with_homam, price_charged)
    values (
      v_submission_id,
      v_item->>'seva_id',
      coalesce((v_item->>'with_homam')::boolean, false),
      (v_item->>'price_charged')::numeric
    );
  end loop;

  for v_sank in select * from jsonb_array_elements(p_sankalpam)
  loop
    insert into public.sankalpam_entries (submission_id, gotram, nakshtram, name, relationship)
    values (
      v_submission_id,
      nullif(v_sank->>'gotram', ''),
      nullif(v_sank->>'nakshtram', ''),
      nullif(v_sank->>'name', ''),
      nullif(v_sank->>'relationship', '')
    );
  end loop;

  return jsonb_build_object(
    'submission_id', v_submission_id,
    'devotee_id', v_devotee_id,
    'total_amount', v_total
  );
end;
$$;

-- Public (anon) callers need EXECUTE since this is the only write path used
-- by the sponsorship form; staff use it too when signed in.
grant execute on function public.create_submission(jsonb, text, jsonb, jsonb) to anon, authenticated;

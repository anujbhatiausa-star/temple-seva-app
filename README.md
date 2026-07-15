# Sri Maha Lakshmi Devasthanam — Seva Sponsorship App

A seva sponsorship form and staff ledger for Sri Maha Lakshmi Devasthanam,
backed by Supabase (Postgres + PostgREST + Auth) and deployed on Vercel.

```
temple-seva-app/
├── frontend/
│   └── temple-seva-app.html   # static front end (HTML/CSS/JS, supabase-js via CDN)
├── api/
│   └── notify.js              # Vercel serverless function — notification stub
├── supabase/
│   ├── migrations/            # schema + RLS + RPC, applied in filename order
│   └── seed.sql                # seva catalog (yearly sevas + mahotsavams)
├── vercel.json
└── README.md
```

Both Supabase's and Vercel's free tiers are enough for this project (small
database, one serverless function, a static page) — you shouldn't need to
upgrade either one for local dev or an initial deploy.

## 1. Create the Supabase project

1. Go to [supabase.com](https://supabase.com), sign in, and click **New
   project**.
2. Pick an org, name it (e.g. `temple-seva-app`), set a database password
   (save it somewhere — you'll want it if you ever connect with `psql`), and
   choose a region close to you.
3. Wait for provisioning to finish (a couple of minutes).

## 2. Run the migrations

The three files in `supabase/migrations/` must run **in filename order** —
they create the tables, then enable RLS and add policies, then create the
`create_submission` RPC function.

### Option A — Supabase CLI (recommended)

On Windows, install the CLI with `scoop` or `npm`:

```powershell
npm install -g supabase
```

From the project root:

```powershell
supabase login
supabase link --project-ref YOUR_PROJECT_REF   # found in Project Settings → General
supabase db push                                # applies every file in supabase/migrations
```

### Option B — Dashboard SQL editor

If you'd rather not install the CLI: open **SQL Editor** in the Supabase
dashboard, and paste + run each file's contents, in this order:

1. `supabase/migrations/20260715000001_create_tables.sql`
2. `supabase/migrations/20260715000002_enable_rls_and_policies.sql`
3. `supabase/migrations/20260715000003_create_submission_function.sql`

## 3. Run the seed script

`supabase/seed.sql` inserts the yearly sevas and mahotsavams (with their
prices) that the front end reads from the `sevas` table. It's safe to re-run
— it upserts by `id`.

- **CLI:** `supabase db execute -f supabase/seed.sql`
- **Dashboard:** paste `supabase/seed.sql` into the SQL editor and run it.

## 4. Put the anon key into the front end

In the Supabase dashboard, go to **Project Settings → API** and copy:
- **Project URL**
- **anon / public** key (not the `service_role` key — that one must never
  appear in front-end code)

Open `frontend/temple-seva-app.html` and find these two lines near the top
of the `<script>` block:

```js
const SUPABASE_URL = 'YOUR_SUPABASE_PROJECT_URL';
const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
```

Replace both placeholders with your real values.

## 5. Create a staff user

There is no public sign-up form — staff accounts are created manually:

1. In the Supabase dashboard, go to **Authentication → Users → Add user**.
2. Enter an email and password, and set **Auto Confirm User** to on (so they
   can sign in immediately without clicking an email link).
3. Repeat for each staff member who needs access to the ledger.

They can now sign in from the **Temple Office** tab in the app using that
email and password — no magic link, no OAuth, just email/password.

## 6. Run locally with Vercel

Install the Vercel CLI if you don't have it:

```powershell
npm install -g vercel
```

From the project root:

```powershell
vercel dev
```

This serves the static front end and `api/notify.js` together, matching
production routing (`vercel.json` rewrites `/` to
`frontend/temple-seva-app.html`). The first run will ask you to link the
folder to a Vercel project — you can create a new one or accept the
defaults.

## 7. Deploy to Vercel

```powershell
vercel        # preview deploy
vercel --prod # production deploy
```

Or connect the repo to Vercel via the dashboard (Import Project → pick this
repo) for automatic deploys on push. No environment variables are required
for the current stub — `api/notify.js` doesn't call any external service yet.

## Demo-phase logging

While real devotee data isn't being collected yet, the app logs to the
console: sign-in attempts and their result, the full payload sent on a new
submission, Supabase's response after that insert, and the payload
`api/notify.js` receives (logged server-side in its own function log).

Every one of these lines is tagged `// DEMO LOGGING - remove before
production` in both `frontend/temple-seva-app.html` and `api/notify.js` —
search for that comment and delete them before collecting real names,
phone numbers, or addresses.

## What's stubbed / not yet built

- `api/notify.js` just logs the payload and returns success — no real SMS or
  e-mail is sent yet. Wiring up a provider (Twilio, SendGrid, etc.) is a
  follow-up.
- The `notifications` table exists in the schema for that future work but
  nothing writes to it yet.

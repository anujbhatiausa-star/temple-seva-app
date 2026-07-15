// Vercel serverless function — stubbed notification dispatcher.
// Called by the front end right after a submission is saved to Supabase.
// TODO: integrate a real SMS/e-mail provider (e.g. Twilio, SendGrid) once the base app works.
module.exports = async function handler(req, res) {
  if (req.method !== 'POST') {
    res.status(405).json({ error: 'Method not allowed' });
    return;
  }

  const payload = req.body;

  // DEMO LOGGING - remove before production
  console.log('[api/notify] received payload:', JSON.stringify(payload, null, 2));

  res.status(200).json({
    ok: true,
    message: 'Notification stub received the payload — no SMS/e-mail was actually sent.',
  });
};

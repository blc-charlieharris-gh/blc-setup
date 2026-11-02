---
name: reference_resend_direct_client_email
description: Claude can send a client email straight through Resend (key in marketing-agent .env.local) when the Hub isn't signed in; not logged in Hub History
metadata:
  type: reference
---

RESEND_API_KEY is in marketing-agent `.env.local`. Email client sends from `InstallrHub <brad@installrhub.com>`, reply-to the same (check recent sends via GET https://api.resend.com/emails, needs a User-Agent header). Build the HTML with `composeClientEmail({ clientName, greeting, opening, subject, picks: [], portalButton: false })` from `src/lib/clientEmailBuilder.js` run through `npx vite-node` (plain node fails on extensionless imports). A new id returns "Email not found" for ~20s, then queued, then delivered.

Used 2026-11-02 for the false Payment issue corrections (Elect, SWH, Helix), with Charlotte's OK on the wording. Such sends never reach hub_client_emails, so they don't show in the Hub's History or "Sent today". Always show the wording first ([[feedback_check_feedback_before_status_sql]] spirit: confirm outward sends).

---
name: reference_resend_installer_sends
description: "How to send marketing email to installers via Resend (key location, verified domains, recipient query, send mechanics)"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 2703110a-219a-46b6-ac39-cd720aab2087
  modified: 2026-08-27T12:17:29.913Z
---

Resend is wired for the marketing-agent project. Reusable facts for future installer email sends:

**Auth / key:** `RESEND_API_KEY` lives in `marketing-hub/marketing-agent/.env.local` (gitignored). Read it from there; never print it. "CharlieKey" is the key name in the Resend dashboard.

**If `.env.local`'s key is empty (found 2026-08-27):** check before assuming Resend access is gone. `vercel env pull` will NOT recover it — Vercel's `RESEND_API_KEY` on this project is a Sensitive/Encrypted var, write-only by design, unreadable via CLI or dashboard even with full account access, only the deployed server function can use it at runtime. The only fix is generating a fresh key at resend.com/api-keys and pasting it into `.env.local` by hand (Charlotte did this 2026-08-27 to send a one-off client email directly rather than merging a throwaway in-app composer). Don't waste time on `vercel env pull`/`vercel env ls` trying to extract the value, it will come back empty.

**Verified sender domains:** `installrhub.com` and `greentideenergy.com` (both verified, eu-west-1). Use `brad@installrhub.com` for installer sends.

**Send mechanics:** POST to `https://api.resend.com/emails` (single) or `https://api.resend.com/emails/batch` (up to 100 messages, one call). Batch response returns message IDs in the SAME order as the request array. Personalise `{{first_name}}` yourself in the HTML before sending (NOT Resend template vars) so each recipient gets pre-rendered HTML. `reply_to` accepts an array for multiple reply addresses. `cc` is an array.

**Recipient source (IMPORTANT):** installer contacts live in `company_members` (name/email/role/receives_email), NOT `companies.email` (that's mostly `email_disabled`/empty, only ~6 of 74 usable). Active installers = `companies.is_active` joined to `company_members` where `role='owner'` + `receives_email` + non-empty email. ~69 owners across 74 active companies. Always EXCLUDE test/demo accounts: `WhatsApp Test Installer` (serafimparente@gmail.com + BLC internal), `InstallrHub Demo (View Only)` (demo@installrhub.com). A few real installers have no "owner" role, only admin/member (e.g. Helix Power, Stellar Insulations) so `role='owner'` alone misses them.

**Email template:** the InstallrHub branded shell = `src/lib/brandAssets.js` (logo header, 2px rule, BLC footer, EMAIL_FONT) + the inline-CSS renderer pattern in `src/lib/emailBlast.js`. Reuse that shell (580px max-width column, responsive w/ MSO ghost table, viewport meta, hidden preheader for preview text). See [[project_greentide_lead_pipeline]] for related lead data.

**2026-07-02 SiteScore campaign:** sent to 58 installer owners (69 owners minus 12 boss-omitted, minus 1 test, plus Helix + Stellar admins). Free website audit / "first 5 to reply" offer. Reply-to brad@installrhub.com. Send log at `BLC/sitescore-send-log-2026-07-02.csv`.

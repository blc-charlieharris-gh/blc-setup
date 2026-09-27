---
name: feedback_landing_route_lookup_keys_empty
description: The Lead Intake Destination field has never steered traffic because landing_route_lookup_keys is empty; a secret-gated RPC that fails closed looks identical to a working one when the caller has a fallback
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c96c47ef-ef81-4683-ae76-f43b2c2ab3c7
  modified: 2026-08-05T13:35:59.585Z
---

`landing_form_routes` + the `landing_route_lookup(p_form_key, p_secret)` SECURITY DEFINER RPC exist so
the dashboard can repoint a landing form's n8n webhook with no redeploy. Verified 2026-08-04: it has
**never worked on any site**. `landing_route_lookup_keys` has **0 rows**, and the function raises
`unauthorized` unless the presented secret matches an ACTIVE key. So every lookup fails and the site
falls back to its `LEAD_WEBHOOK_URL` env var.

**Why:** Corroborated by `landing_form_routes.destination_url` being null on every row too, so nobody
ever filled a destination in either. The migration deliberately does not seed the secret ("never commit
a secret to git") and leaves an instruction comment to INSERT one after applying. Nobody did.

**How to apply:**
- A secret-gated RPC that fails closed, behind a caller with a fallback, is **invisible when broken**.
  No error, no lost lead, no alert. Check the gate table has rows before believing the feature works.
- To switch it on: one INSERT into `landing_route_lookup_keys (name, secret)`, then set
  `LEAD_ROUTE_LOOKUP_SECRET` on each site's Vercel project (plus `SUPABASE_URL` / `SUPABASE_ANON_KEY`).
- Both Green Tide (`site/api/lead.js`) and the forecast funnel (`installrhub-static/api/lead.js`, wired
  2026-08-04) use the same `lookupRoute` shape with a 60s module cache.
- Third shipped-but-never-run feature found in a fortnight. See [[feedback_silent_fallbacks_hide_dead_features]].

**Update 2026-08-05:** still 0 rows. Charlotte has now filled in `destination_url` on every
InstallrHub row and both Green Tide rows, so the HUB side is correct and the assumption
"I set it in the hub so it works" is now actively wrong. There are TWO locks, both must open:
(1) `lookupRoute()` returns null before any network call unless `SUPABASE_URL` +
`SUPABASE_ANON_KEY` + `LEAD_ROUTE_LOOKUP_SECRET` are all set on the Vercel project, and
installrhub production has only `SUPABASE_URL`; (2) the empty key table. Note `api/contact.js`
(homepage, /contact, /breakdown) has NO hardcoded fallback, so every one of its leads goes to
the Resend email instead of GHL, unlike `api/lead.js` which hides the fault behind a hardcoded
URL. Full write-up + the fix: `BLC/docs/lead-routing-architecture.md`.

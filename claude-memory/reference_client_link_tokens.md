---
name: reference_client_link_tokens
description: Token-gated no-login client links (report/audit/preview) via the client-link edge fn + /api/report-link mint; the shared access model that retires SiteScore passwords
metadata: 
  node_type: memory
  type: reference
  originSessionId: e306d040-3199-4d38-bd90-f2686f851312
  modified: 2026-07-31T08:38:54.411Z
---

The single access model for "send a client a link" pages (starting with the weekly report; audit + site
preview migrate onto it later). No login, no password, possession of the link is the access (like a Stripe
receipt). LIVE end-to-end 2026-07-31.

**How it works:**
- **Mint** (staff-only): `POST /api/report-link` (Vercel, `requireStaff`) HMAC-signs `${slug}|report|${from}_${to}|${exp}`
  (exp = now + 30 days) and returns `https://crew.installrhub.com/<slug>/report/<from>_<to>?k=<exp>.<hexsig>`.
  Reads no DB; the caller passes the client name. "Copy report link" button on Clients > Reports.
- **Validate + serve** (public): `client-link` edge fn (`verify_jwt=false`, service-role). Re-computes the HMAC,
  checks expiry, resolves slug→client via `slugify(clients.name)` (no slug column on clients), then returns the
  RAW report numbers (ad_windowed_totals current/prev/trend/lifetime) + saved editorial (`client_reports`:
  selected_stats/feedback/next_steps) + reportBench targets. The public page `ClientReport.jsx` (route
  `/:slug/report/:dates` in ClientApp) renders `ReportView` from that, reusing the hub libs.
- **Secret:** `CLIENT_LINK_SECRET` must be IDENTICAL in Vercel env AND Supabase edge secret. A mismatch =
  every link returns "invalid". Deployed via Supabase dashboard (not the InstallrHub repo), so it is REPO-DRIFTED
  like [[project_edge_fn_repo_drift_A0]]: add `client-link/index.ts` to the InstallrHub repo later, source staged
  at `.claude/docs/client-link-edge-fn/` on branch feat/hosted-report (merged to main #?).

**slug = slugify(name)** must stay byte-identical across `api/report-link.js`, the edge fn, and any frontend use.
`slugify = lower, & -> " and ", non-alnum -> "-", trim -.`

**Design decisions:** 30-day expiry all resources; token-only for v1 (the "or valid client session" door is a TODO
for when the CREW login becomes real, today it's a localStorage stub). Reports keyed by marketing `client_id`,
NOT company_id (reports are per-client ad performance; the identity spine is separate). A paused client's existing
link still resolves (historical), but the report PICKER only lists live clients (isLive, see [[feedback_lead_only_blanks_cpbl]]).

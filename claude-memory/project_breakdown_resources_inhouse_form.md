---
name: project_breakdown_resources_inhouse_form
description: /breakdown unlock form rebuilt in-house 08-05; captured NOTHING 29 Jul-5 Aug; n8n field mapping unverified
metadata: 
  node_type: memory
  type: project
  originSessionId: 2c1bca1a-44e2-4716-b13f-3c84e4647209
  modified: 2026-08-05T13:42:38.050Z
---

site-installrhub `/breakdown` ("7 free resources" funnel). The Fillout embed was
replaced with the in-house 4-step qualifying survey on 2026-08-05 (PR #48, merged
and live): `breakdown/index.html` modal + `js/breakdown.js`, posting to the SHARED
`api/contact.js` with form_key `installrhub-resources`, registered in `api/_forms.js`
with label `InstallrHub - Resources`.

NOTE: a standalone `api/resources.js` was written first and DELETED before merge.
PR #47 had landed the same day with shared plumbing (`api/_forms.js` registry,
generic `api/contact.js`, `api/form-keys.js`, `js/site-forms.js`) and local main was
8 commits stale, so the first attempt duplicated it. Fetch before building anything
form-related here. `js/site-forms.js` drives single-step `form[data-ih-form]` only,
which is why the multi-step modal keeps its own controller.

**Why it broke:** not Fillout. Commit 6cc6ca0 (2026-07-29, "Rebuild /forecast
funnel") rewrote `js/forecast.js` and dropped `initSurvey()`, the ONLY code that
opened the `#fc-survey` modal. From 29 Jul to 5 Aug the "Unlock the full
breakdown" buttons did nothing and the funnel captured zero leads. The
controller now lives in `js/breakdown.js`, named after the page it serves, so a
future /forecast rebuild cannot silently delete it again. See
[[feedback_silent_fallbacks_hide_dead_features]].

**Why its own endpoint, not /api/lead:** `api/lead.js` forwards a fixed
whitelist of Forecaster calculator fields. Posting through it would have
silently dropped tech / capacity / issue, the entire qualification payload. See
[[feedback_hardcoded_raw_whitelists_drop_payloads]].

**Open, needs sign-off before this can be called live:**
- The n8n workflow at `...4d90a9a3-...fillout-resources` was built for a FILLOUT
  payload shape. Our in-house JSON (source/formKey/name/company/email/phone/
  tech/capacity/issue/fit/tracking) is unverified against its field mapping. If
  n8n 200s but maps nothing, the Resend fallback will NOT fire, so the lead is
  lost silently.
- The `installrhub-resources` landing_form_routes row is `active=false`.
  Currently moot: `landing_route_lookup_keys` still has 0 rows so the RPC fails
  closed for every form and the site uses its hardcoded fallback URL. See
  [[feedback_landing_route_lookup_keys_empty]].

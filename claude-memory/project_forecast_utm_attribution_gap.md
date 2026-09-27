---
name: project_forecast_utm_attribution_gap
description: "B2B installer-lead attribution IS working (verified 2026-08-12); data lands as flat GHL keys in sales_lead_intake_events.raw, not under `tracking`"
metadata: 
  node_type: memory
  type: project
  modified: 2026-08-12T13:28:30.805Z
  originSessionId: e6c0c629-e22b-49f9-925d-66ad850bf430
---

**RESOLVED 2026-08-12. The earlier "UTMs never reach Supabase" finding is OUT OF DATE, and the
handoff note `site-installrhub/SERAFIM-forecast-utm-attribution.md` describes a fixed problem.**

`ghl-installr-lead-webhook` **v16 is deployed** with the `raw: { ...body }` spread, so the
hardcoded 8-key whitelist is gone (see [[feedback_hardcoded_raw_whitelists_drop_payloads]],
which listed this fn as still open: it is not). Attribution arrives and is stored.

**THE TRAP THAT MAKES IT LOOK BROKEN.** Checking `raw ? 'tracking'` or `raw ? 'customFields'`
returns 0 across every row and reads as total data loss. Both key names are wrong. GHL sends
**flat custom-field names**, inconsistently cased:

- `utm_source` (lowercase) but `UTM Campaign`, `UTM Content`, `UTM Medium` (title case, spaces)
- `fbclid`, plus our own `ih_channel`, `ih_placement`, `ih_landing_page`, `ih_referrer`

Verified live rows: `utm_source='meta'`, `UTM Campaign='FB Instant Form - DTO'`,
`UTM Content=120249569180840731` (the ad id), `ih_channel='paid-social'`,
`ih_placement='meta-instant-form'`. Null utm on other rows is CORRECT: those are direct or
organic visitors who never carried a UTM, plus `source='test'` rows.

**`installer_prospects` is populated MANUALLY, by design.** The edge fn header states it is
AUDIT-ONLY and "never creates an `installer_prospects` row (the rep does that explicitly from
the Intake panel)". So intake events not becoming prospects is NOT a bug. On 2026-08-12,
15 intake rows since 1 Aug had 0 matching prospects simply because nobody had worked the
Intake panel since 31 July. Do not go hunting for a code break there.

**What is genuinely left:** the values live only in `raw` as awkward mixed-case keys, and
`sales_lead_intake_events` still has no typed utm columns (`source` is the literal `'webhook'`
or `'test'`). So a sources report must either read `raw->>'UTM Campaign'` with exact casing, or
the keys get promoted into columns first. That is the only remaining work, and it is reporting
ergonomics, not data loss.

Remember `utm_campaign` is overloaded ([[reference_greentide_utm_attribution]]): landing leads
carry the ADSET id, instant-form leads the CAMPAIGN id. Related: [[project_sources_tracking]].

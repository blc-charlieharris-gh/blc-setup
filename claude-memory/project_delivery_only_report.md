---
name: project_delivery_only_report
description: "Delivery-only client report (no money shown) for per-lead clients; SHIPPED + verified live 2026-08-10, currently dormant because no client has transfers='all' yet"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9f6ce79c-9f19-49d3-8535-930912ccc48f
  modified: 2026-08-10T16:26:34.149Z
---

Built and verified live 2026-08-10. Spec: `.claude/docs/delivery-only-report-spec.md`.

**The problem:** clients who pay us PER LEAD while WE fund the ads. Our cost per lead is our MARGIN,
and the report printed it on the front page ("43 leads at £29.29 each"). First report would hand over
the markup. First case is Mark Harvey Renewables (`6de4d602`), not live yet, campaign still off.
`Harvard Renewables` (`734d78bb`) is a SEPARATE company, not a duplicate, do not re-raise it.

**Shipped:** hub #560 (core), #562 (hosted page), `client-link` edge fn **v6** deployed by Charlotte
from the dashboard. `deliveryOnly` threads through `ReportView`, `reportNarrative`, `reportStats`.

**THE TRAP THAT NEARLY SHIPPED HALF-DONE:** there are TWO report renderers. `/reports` in the hub is
the operator preview; the page the client opens is `ClientReport.jsx`, fed entirely by the
**`client-link` edge fn**. Fixing only the hub looks fixed while the real page leaks. Any future
report change has to cover both, and the client-facing one is server-fed, so it is NOT frontend-only.

**Key implementation choice:** in delivery-only mode the cost numbers are NOT COMPUTED, rather than
computed and hidden. Every cost clause was already guarded on a cpl value / corridor verdict / cost
delta being non-null, so nulling those three drops all of them. A filter over finished prose is one
regex away from leaking. The guard test (`reportNarrative.test.js`) asserts no `£` and no "cost per
lead" in ANY tone, and it immediately caught two leaks the hand edit missed.

**Deliberate asymmetry:** the edge fn FAILS SAFE (lookup errors → hide money, a leak cannot be
undone). The page does NOT (missing field → show money, because a missing field means "old fn
version", not "delivery-only"). So a suddenly money-free normal report = the fn's lookup is failing.

**Currently DORMANT and correct:** only one attribution link exists in the whole system (Arktek,
`transfers='surveys'`). ZERO clients are `transfers='all'`, so nobody is delivery-only yet and every
existing report is unchanged. Mark Harvey switches on automatically when his campaign is linked with
mode `all`. Arktek stays normal, per Charlotte: their top-up is retainer-covered.

**Still open:** the switch infers billing from FUNDING (`transfers='all'`), which is right today but
conflates the two. `clients.billing_model` is the real fix, a one-column tier-2 migration.
Also two PRE-EXISTING bugs found and deliberately not fixed: `reportStats.test.js` fails on main
(asserts DEFAULT_STAT_KEYS excludes `impressions`, which it does not), and the zero-lead prose quotes
ad spend to ordinary clients against that file's own header rule.

Related: [[project_client_weekly_reports]], [[feedback_report_prose_no_adspend]],
[[project_adset_client_attribution_override]], [[feedback_postgrest_column_select_gate]].

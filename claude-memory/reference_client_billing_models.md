---
name: reference_client_billing_models
description: Three client commercial models decide what money a client report may show; a per-lead client seeing our CPL is seeing our margin
metadata: 
  node_type: memory
  type: reference
  originSessionId: f0dddaa7-d145-49d2-a755-e210eb20d4f8
  modified: 2026-08-10T15:59:16.995Z
---

Three arrangements, and they decide what a client is allowed to see on their report:

1. **Own campaign** (e.g. Arktek's own ad account). The CLIENT pays for the ads. Their spend and cost per lead are their own money, so the report may show them. Charlotte 2026-08-10: "we're fine to show arktek ad spend, just not our contribution".
2. **Top-up** (`transfers='surveys'` link). WE pay, out of Green Tide, to make up a SURVEY shortfall on a retainer client's own campaign. Our spend and leads never enter their column, so their report only ever shows their own money. The client is NOT told any survey came from elsewhere.
3. **Per-lead / per-survey** (`transfers='all'` link, e.g. Mark Harvard Renewables). WE fund the whole campaign and charge per lead. **Their report must show NO money at all.** Our cost per lead IS our margin: charge £60, report "£29.29 each", and they can read the markup off the headline.

**The trap:** the `transfers='all'` link is right for model 3 INTERNALLY (it puts spend/leads/CPL under their name in the hub so we can see margin against the price), but it does NOT make the money theirs. Charlotte, correcting me 2026-08-10: "no so we're charging him per lead, hes not funding the cmapaign we are".

The client report today is built cost-first (hero reads "43 leads at £29.29 each", plus CPL chips, corridor prose, cost stat cards, a cost-per-lead momentum chart and CPL target gauges), so model 3 needs a delivery-only shape. Spec: `.claude/docs/delivery-only-report-spec.md` (branch `docs/delivery-only-report-spec`). NOT started as of 2026-08-10; wanted before Mark Harvard goes live.

Do NOT overload `clients.lead_only` for this: it already means something else (routes lead counting to Meta, blanks booking metrics).

See [[project_adset_client_attribution_override]], [[feedback_report_prose_no_adspend]], [[project_client_weekly_reports]].

---
name: feedback_hardcoded_raw_whitelists_drop_payloads
description: Two separate intake edge fns built their raw column from a hardcoded field whitelist and silently discarded everything else; check the raw construction before concluding the sender is at fault
metadata: 
  node_type: memory
  type: feedback
  originSessionId: c96c47ef-ef81-4683-ae76-f43b2c2ab3c7
  modified: 2026-08-04T15:39:39.983Z
---

The same defect has now been found in **two** intake edge functions: they build the `raw` JSON column
from a hand-picked list of keys, so everything else the caller sends is thrown away with no error.

- **`lead-ingest`** (homeowner spine) kept 4 keys. Dropped `gt_exp`, the split-test variant the A/B
  winner is scored on, plus `visitor_id` / `eligible` / `dq_reason` / `answers` / `page_url`. Fixed and
  deployed 2026-08-04 (v4): `raw: { ...body, via: "lead-ingest" }`, spread first so `via` can't be
  clobbered.
- **`ghl-installr-lead-webhook`** (B2B / sales spine) keeps 8 keys: `firstName`, `lastName`,
  `fullName`, `contactSource`, `rawTags`, `relatedIntakeIds`, `priorIntakeCount`,
  `originalContactDate`. Every `/forecast` lead therefore lands in `sales_lead_intake_events` with
  names and nothing else. **Still open as of 2026-08-04.**

**How to apply:**
- When a lead "arrives empty", read the **receiving function's `raw` construction first**. Both times
  the sender was fine and the receiver was the culprit; both times the first theory blamed the sender
  (Fillout config, then n8n).
- Its own comment can betray it: `ghl-installr-lead-webhook` sets a 20KB body limit "because workflow
  webhooks carry the full custom-field schema", so it knows more is arriving than it keeps.
- The fix shape is always the same: spread the body, then re-apply the derived/computed keys after it.
- Related: [[project_forecast_utm_attribution_gap]], [[reference_greentide_utm_attribution]].

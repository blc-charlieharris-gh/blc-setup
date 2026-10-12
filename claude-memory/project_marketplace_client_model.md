---
name: project-marketplace-client-model
description: "Charlotte 10-08 marketplace model: pay per survey or per lead, each fixed pack or ongoing, each with/without Brand Package; we track + report, billing isn't ours; pack used up = pause ad set + Actions card"
metadata:
  node_type: memory
  type: project
  originSessionId: 6a33dffe-7abe-450c-b4b9-bfc677a26314
  modified: 2026-10-08T18:51:39.138Z
---

Charlotte 2026-10-08, for the marketplace overhaul:
- Every marketplace client = (surveys | leads) x (fixed pack | ongoing) x (with | without Brand Package). All four marketplace combos are real; fixed lead packs will be sold.
- How ongoing clients are charged "doesn't concern us": the Hub only needs to track and report surveys/leads delivered.
- A fixed pack (surveys or leads) used up -> pause their area ad set and raise an Actions card (top-up).
- Hub on 10-08 supported only fixed per-survey (survey_orders; nothing stops at zero) and ongoing per-lead; no reporting for any marketplace client.

**Why:** the explainer I gave said "every pay-per-survey sale is a fixed pack, no ongoing" and she corrected it.
**How to apply:** build these into the marketplace overhaul plan (waits on her resent notes); don't treat per-survey as fixed-only or per-lead as ongoing-only. Related: [[reference_client_billing_models]], [[project_new_marketplace_as_codes]].

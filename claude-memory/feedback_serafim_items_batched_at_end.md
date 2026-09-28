---
name: feedback_serafim_items_batched_at_end
description: "Hub audit: anything Hub-side (incl. marketing-* edge fns in the Hub repo, Hub tables, Serafim notes about the Hub) is OURS to fix; only true app-side items go to Serafim, batched at the end"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1d632e35-8cda-477e-acf4-0486ae313969
  modified: 2026-09-28T19:12:52.875Z
---

Charlotte 2026-09-28 (page 6 Status), two rules:
1. "dont send serafim anything, anything for serafim is to be assessed and sent over at the end, same with anything he has written back."
2. Correction the same evening: "we are end to end hub, he is the app. if this or any other of his notes relate to the hub, it's us not him to sort." I had parked the marketing-status-check edge fn change "for Serafim". Wrong: that fn lives in the Hub repo (supabase/functions/marketing-status-check) and is ours.

**Why:** the Hub is Charlotte's end to end; Serafim owns the InstallrHub app only. Parking Hub work on him stalls it.

**How to apply:** before tagging anything SERAFIM, check where it lives: Hub repo code, Hub edge fns (marketing-*, hub-*), Hub-only tables = ours, fix it in the page's PR. Only app-side code/tables go on the end-of-audit Serafim list. His cross_agent_notes that concern the Hub are action items for us, handled in the page they belong to. Never message him mid-audit. Related: [[feedback_serafim_signoff_and_handoffs]], [[feedback_hub_only_migrations_no_serafim_review]], [[project_hub_page_audit]].

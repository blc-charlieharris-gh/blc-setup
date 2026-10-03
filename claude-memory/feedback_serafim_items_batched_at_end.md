---
name: feedback_serafim_items_batched_at_end
description: "Hub audit: anything Hub-side (incl. marketing-* edge fns in the Hub repo, Hub tables, Serafim notes about the Hub) is OURS to fix; only true app-side items go to Serafim, batched at the end"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1d632e35-8cda-477e-acf4-0486ae313969
  modified: 2026-10-03T12:26:14.206Z
---

Charlotte 2026-09-28 (page 6 Status), two rules:
1. "dont send serafim anything, anything for serafim is to be assessed and sent over at the end, same with anything he has written back."
2. Correction the same evening: "we are end to end hub, he is the app. if this or any other of his notes relate to the hub, it's us not him to sort." I had parked the marketing-status-check edge fn change "for Serafim". Wrong: that fn lives in the Hub repo (supabase/functions/marketing-status-check) and is ours.

**Why:** the Hub is Charlotte's end to end; Serafim owns the InstallrHub app only. Parking Hub work on him stalls it.

**How to apply:** before tagging anything SERAFIM, check where it lives: Hub repo code, Hub edge fns (marketing-*, hub-*), Hub-only tables = ours, fix it in the page's PR. Only app-side code/tables go on the end-of-audit Serafim list. His cross_agent_notes that concern the Hub are action items for us, handled in the page they belong to. Never message him mid-audit.

3. Charlotte 2026-10-03: "if its on serafims end, leave it off his stack. we told him, it's on him now. only if we've not raised it, or we're impacting him or he's impacting us do we need to know of it." So once an app-side item has been raised with him, drop it from our lists and reports (e.g. Arktek over-count on his dashboard, raised 09-14). Only surface Serafim items that are (a) not yet raised, (b) something we're doing that affects him, or (c) something of his that's blocking/breaking us. Same day she narrowed it further: housekeeping inside his own app repo (e.g. his 9 Aug sales_targets/sales_documents migrations never pushed) is "Serafim's stuff for Serafim", don't add it to his pack either. Her summary: "just his stuff we need to pass him from our audit findings really". So the Serafim list = only app-side items our Hub audit turns up that he needs to act on; nothing else. Related: [[feedback_serafim_signoff_and_handoffs]], [[feedback_hub_only_migrations_no_serafim_review]], [[project_hub_page_audit]].

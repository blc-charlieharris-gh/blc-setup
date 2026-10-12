---
name: project-library-older-ads-catchup
description: "Charlotte is linking older ads in Library > \"Show all older ads (catch-up)\"; remind her each prime, then remove the catch-up view once she says done"
metadata:
  node_type: memory
  type: project
  originSessionId: 0283fc76-20ea-48be-8226-5101255d523d
  modified: 2026-10-10T08:31:19.776Z
---

Charlotte asked (2026-10-10) to be reminded so she doesn't forget: she is linking the older ads in Library > Ads not linked, "Show all older ads (catch-up)" view (bulk Link / Add from Meta / Old; dismissals in `hub_ad_link_dismissals`, built in #1662).

**Why:** the catch-up view is a temporary backlog tool; once the old ads are sorted it should go (no interim measures left behind, [[feedback_no_duplicate_solutions]]).
**How to apply:** at every marketing-agent prime, list this under "Waiting on you" until she says it's done. When she says done: check how many older ads are still unlinked (live), tell her the number, then on a branch remove the catch-up switch/view (keep `hub_ad_link_dismissals` only if something else reads it), PR + merge, and delete this memory.

---
name: project-churned-clients-cleanup
description: "Churned clients that keep getting re-raised as problems: filter for is_active AND is_tracked first"
metadata: 
  node_type: memory
  type: project
  originSessionId: 5cf7e5df-a104-4414-952e-381d8eec04a6
  modified: 2026-08-06T15:03:13.717Z
---

**Before flagging any client-config oddity, filter `clients` on `is_active AND is_tracked`.**
Churned clients keep surfacing as false alarms and Charlotte has corrected this
more than once.

Known churned / not live (do NOT raise these as bugs):
- **Eco Green Upgrades** (`is_active = false`). Raised repeatedly, including as a
  `mirror_to_ingest` drift example on 2026-08-06. It is churned, its config being
  stale is expected and harmless.
- **Renerji**, **My Energy Care**, **My Eco Move** (all `is_active = false`).

`isLive(c)` in `src/lib/clientScope.js` is the shared definition:
`is_active AND is_tracked`. Every list, picker and check should gate on it, so a
paused client disappears everywhere at once rather than leaking into whichever
screen forgot to check.

Related: [[project_sources_tracking]].

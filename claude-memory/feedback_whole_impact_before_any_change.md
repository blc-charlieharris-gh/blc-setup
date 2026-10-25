---
name: feedback-whole-impact-before-any-change
description: "Any change/update/add/remove Charlotte asks for: sweep every place that reads the same thing and fix them all in the same change, to stop data drift"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 50c8121e-3273-41f0-a582-48d735931a72
  modified: 2026-10-24T12:17:06.150Z
---

Charlotte, 2026-10-24: "if i ask you to change update add or remove something, we need to look at the whole impact so we can avoid data drifts like this."

Before building ANY change (a rule, a link, a field, a definition, a count, a setting), list every place that reads or shows the same thing (SQL functions/RPCs, Hub pages and their columns, Actions cards, client portal, reports, edge fns, the app side) and check each one. Fix every reader in the same change, or name it as left alone and why. The report says which places were checked and which changed.

**Why:** 10-24 the shared AS code fix (AS01 = Links Energy + Renewable Sales) corrected the Targeting leads count but missed the same page's "Campaign reaches" column, which still said "12 outside theirs" for RSSS. She found it, not me.
**How to apply:** grep for the table/column/function/concept across src, api, supabase/functions and the latest migrations (an Explore agent for wide sweeps) BEFORE writing the fix; put the sweep list in the final message. Related: [[feedback-audit-full-page-hidden-and-linked]], [[feedback-say-what-audit-already-covers]].

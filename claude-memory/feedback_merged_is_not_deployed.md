---
name: feedback_merged_is_not_deployed
description: "A merged edge-fn fix may never have been pasted live; before saying a bug is fixed, read the deployed fn for the fix's code"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0b5481e2-5705-450f-8a6e-b3ef2173efd1
  modified: 2026-11-04T18:46:09.458Z
---

11-04: #3185 (booked-call reminders) was merged at 15:30 but nurture-run stayed v89 and broadcasts v97, so Tom (airsource-pro) still lost his demo reminders. Found only by reading the deployed functions.

**Why:** edge fns go live only when Charlotte pastes them ([[reference_blc_supabase_cli_wrapper]]); merging does nothing to Supabase.

**How to apply:** when a test or bug says "fixed by #N", grep the live function (get_edge_function, saved to a file) for a line from that change before trusting it. Also: an enrolment stopped by removed_from_ghl never restarts by itself (only call_cancelled reopens), so people hit before a fix need a guarded SQL reopen.

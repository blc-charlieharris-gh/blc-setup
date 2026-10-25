---
name: feedback-uk-time-after-clocks-change
description: UK clocks went back 25 Oct 2026: from then UK time = UTC; I said times an hour out all day
metadata:
  type: feedback
---

From 25 Oct 2026 01:00 (until the last Sunday of March) UK time = UTC, so DB/Meta/cron times are UK times as they are. I added an hour all day on 10-25 (said 13:15 for the 12:15 cron) and Charlotte corrected it.

**Why:** times in reports must match her clock.

**How to apply:** before giving a UK time, check the date against BST (last Sunday of March to last Sunday of October = UTC+1, else UTC). Related: [[feedback_check_clock_before_time_cutoffs]].

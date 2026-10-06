---
name: feedback_timed_reminders_batch_cap
description: "nurture-run sends 100 per 5-min tick even for before_date steps: 359 '10 mins to go' texts would run to 6:05pm; fix so timed steps send all due at once (10-06)"
metadata:
  type: feedback
---

2026-10-06 webinar: the 10-minute text to 359 people would have gone 100 per tick (17:50, 17:55, 18:00, 18:05). I ran nurture-run by hand twice (publishable key, atomic claim so no double send) so all went by 17:53. Charlotte: "we need this sorting automatically for next one".

**Why:** BATCH = DATE_LOCKED_BATCH_PER_TICK = 100 in supabase/functions/nurture-run; a timed reminder is useless late.
**How to apply:** change nurture-run so before_date steps loop within the tick until none due (time budget), and a contact with no UK mobile is skipped, not 'failed' + retried. Deploy outside an event window.

---
name: project_nurture_routes_after_webinar_1104
description: "Nurture routing decisions 4 Nov 2026: booked-call reminders never stopped by another sequence; cancelled call = off nurture, stays on mailing list; after-webinar to-do list"
metadata:
  node_type: memory
  type: project
  originSessionId: 9b41cfcd-d877-4406-9c72-e8a8331edbfa
  modified: 2026-11-04T15:21:15.317Z
---

Decided with Charlotte 4 Nov 2026 (webinar day):
- Two kinds of sequence: "ways in" (Lead Nurture, lead magnets, webinar, replay) and call reminders (Discovery/Demo call booked). Nothing stops call reminders except their own call being cancelled. Replay takeover now skips booked-call sequences (#3159, nurture-run v86).
- Cancelled call: leave them OFF nurture (they may not be interested), but they stay on the mailing list. Do NOT build "put back on Lead Nurture".
- Replay replacing Lead Nurture mid-way is fine: the replay has its own 4 emails.
- Finished a way in without booking: Charlotte is building a regular email strategy (broadcasts) for them; don't build a "still thinking" sequence unasked.

After-webinar to-do (one change): route map at top of Emails > Nurture drawn from the live ticks; one "watches the replay" chip in "Stop this sequence when" replacing the hard-coded takeover (tick on Lead Nurture + Resources, never booked-call ones; no general "joins X" chips, they could clash); remove the blank mailing contact whose phone is our Twilio number and make texts skip our own number; remove the stale "Wire this funnel in GHL" box in SequenceEditor.

Built and merged 11-04 (#3180 + signup fix): route map, replay chip, report card on Events (Report button), attendance match labels, wider warm rule, day-based webinar slugs/tags (webinar-2dec2026). lead-ingest v59: one InstallrHub row per person+form+day (was person+day, second form dropped), and a phone match with a different email = new person. Attendance matching rule from Charlotte: keep close matches but label how matched; unmatched get their group + "Not matched: new, or signed up with another email"; nobody dropped.

**Why:** she wants existing tick systems extended, not new functions, and a clear route map so gaps show. Related: [[project_webinar_after_event_checks_1103]], [[feedback_no_parallel_copies_of_one_job]].

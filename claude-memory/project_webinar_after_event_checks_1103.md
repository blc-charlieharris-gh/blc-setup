---
name: project_webinar_after_event_checks_1103
description: "After-webinar emails: replay sequence must go on as the webinar ends (15-min lookback); share links never carry cid; copy must match the event's replay_hours"
metadata:
  type: project
---

Checked 3 Nov 2026 for the 4 Nov webinar (Nov follow-ups fixed by SQL, all 5 landed):
- The replay sequence used to pick up replay-form fills from only 15 min before switch-on; branch fix/webinar-copy-dates-replay-joins-1103 (nurtureJoins replayJoinStart, nurture-run) reads from when sign-ups closed, up to 3 days. Until that nurture-run is deployed, switch it on as the webinar ends.
- Next-webinar copy: moveWording now also moves dates up to 21 days after the webinar (replay end), weekday included.
- /webinar/replay without ?cid= (or a remembered lead) redirects to /webinar#register; from sign-ups close until replay_until, /webinar shows the "Missed it? Watch the replay" form instead.
- "Share with a colleague" links must not carry {{contact_id}} (the colleague's booking form fills with the sender). Point them at /webinar; the editor leaves cid off a paragraph that says share/colleague/forward.
- Email copy must match calendar_events.replay_hours (Nov = 168h, until Wed 11 Nov 7pm); October's copied emails said 48 hours.
- Broadcast step delays count from the step before.

**Why:** these were found only by reading every follow-up before the event; December's copy inherits whatever November has.
**How to apply:** before each webinar, re-run the same check on the copied follow-ups. Related: [[project_webinar_deck_figures_1102]], [[project_webinar_questions_1102]].

---
name: feedback-rules-not-one-off-fixes
description: Charlotte wants repeatable rules, not per-event SQL or one-off fixes she must remember next time
metadata:
  type: feedback
---

Charlotte (2026-10-05): "hardwiring and temporary fixes dont help next time as we'll forget". When a fix would need repeating (per webinar, per client, per broadcast), build it as a rule the system applies itself: e.g. broadcasts linked to a webinar read that event's replay sequence at send time instead of an exit rule set by SQL per broadcast; Set up the next webinar copies everything and leaves a tick-list task.

**Why:** she runs a lot at once; anything that relies on remembering a manual step gets missed.
**How to apply:** before shipping a data/SQL fix, ask "will this need doing again?" If yes, put the behaviour in code (read from the source of truth each time) and only use SQL for the one-time backfill. Related: [[feedback-no-duplicate-solutions]].

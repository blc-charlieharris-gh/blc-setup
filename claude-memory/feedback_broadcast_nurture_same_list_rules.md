---
name: feedback-broadcast-nurture-same-list-rules
description: "Broadcasts and nurture must handle unsubscribes, bounces and spam complaints the SAME way, and the Hub and GHL must stay in sync both ways (one source of truth for the mailing list)"
metadata:
  type: feedback
---

Charlotte 2026-10-10, after finding nurture complaints/bounces never reached GHL (only broadcasts did): "needs to be single source of truth and GHL and the Hub need to talk to each other to ensure the mailing list is correct. And I always say when you give me broadcast code, why not nurture code. They need to work the same or similar way for handling bounces, unsubscribes and spam."

**Why:** every email path fixed separately left gaps (nurture-resend-webhook never told GHL; old bounces never tagged), and she had been told GHL was updated.
**How to apply:** any change to email handling covers EVERY sending path (broadcasts, nurture, invites/resends, onboarding emails) through ONE shared handler, not a broadcast-only fix. Check both directions: Hub block list -> GHL (DND/tags) and GHL DND -> Hub (hourly mirror). Related: [[feedback_no_duplicate_solutions]], [[feedback_bounce_pause_hard_bounces_only]].

**Widened 2026-10-10 (later):** it's not just the list rules. Charlotte: "anything that affects emails or texts going out, which can be nurture or broadcasts, synced up, single source of truth". Broadcasts and nurture are ONE send-rules area; the only real difference is what starts a send (nurture = triggered by something happening, broadcast = a set time). Safety limits (auto-pause trip-wires, daily email cap, send window, soft-bounce rule, block-list read, merge fields, footer, senders) belong in shared code both use. Same-day overlap is NOT a global rule: each broadcast/sequence decides via its own filters (e.g. "skip if they had a message from these in the last N hours"). Booking exits/next sequence will be driven by the calendar classification (calendar_id -> what it's for): e.g. a disco call booked stops lead>triage and starts the disco sequence. Comparison of every rule done 10-10 (Part 1 safety / Part 2 tidy plan in that session's handoff).

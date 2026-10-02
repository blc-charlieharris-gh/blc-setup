---
name: feedback_bounce_pause_hard_bounces_only
description: Broadcast auto-pause counts hard bounces only (decided 2026-10-02); repeat or typo bounces auto-suppress; dated nurture sends are paced not capped
metadata:
  type: feedback
---

2026-10-02: "Webinar Email 3" paused at 2 of 61 (3.3%), both Transient (full inbox / busy server, one a client). Since then broadcasts emailTrip counts bounce_type <> 'Transient' only, at the same 2% limit. Also that day: nurture-resend-webhook suppresses an address on its 2nd bounce of any kind (typo domains come back Undetermined/Transient and kept bouncing on every step: 11 of 17 bounces were 4 addresses); bounce type/message are now stored (nurture_sends, event_invites, event_resends) and shown to telesales. nurture-run dated (before_date) sends go to everyone per run, Resend calls 550ms apart, 100s budget, and never before their own time (the old 5-per-run cap skipped people then sent the next email a day early).

**Why:** mailbox-provider reputation is hard bounces and complaints; a soft bounce says nothing about the list.
**How to apply:** if a bounce rate creeps up, look for repeat bouncers / typo domains before blaming the list; Charlotte reads Resend's overall rate.

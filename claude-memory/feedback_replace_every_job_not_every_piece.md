---
name: feedback_replace_every_job_not_every_piece
description: "Moving off a system (GHL): list every JOB it did for people and prove each replacement live, before switching anything off; a moved piece can drop a side-effect"
metadata:
  node_type: memory
  type: feedback
  originSessionId: b5437a73-bedd-46e2-b804-8bbdbff4b93e
  modified: 2026-11-03T11:22:38.679Z
---

Charlotte 3 Nov 2026, angry: "I HAVE ASKED FOR THOROUGHNESS. WE CANNOT HAVE SUCH CRUCIAL GAPS." Website bookings moved
GHL -> CRM on 1 Nov; GHL used to also CREATE THE CONTACT that the Hub then picked up. Nobody replaced that job, so a
direct website booker never reached the Hub (no mailing list, no booked-call emails, not counted). I'd built the
booked-call emails matching only form people and said "CRM bookings reach the Hub live" without checking people.

**Why:** each piece was right on its own; the side-effect (contact made, tags, workflows firing) was lost in between.
**How to apply:** for any switch-over, write the job list first (every workflow, trigger, tag, write, read the old
system did, from the audit), and for each one name its replacement and PROVE it with a live record/test, including the
"who is this person" path for every entry point (forms, bookings, staff bookings, imports). Never call something done
from code reading alone. Related: [[feedback_ghl_never_a_fallback]], [[feedback_whole_impact_before_any_change]],
[[project_ghl_removal_hub]].

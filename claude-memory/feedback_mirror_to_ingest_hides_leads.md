---
name: feedback_mirror_to_ingest_hides_leads
description: "meta_lead_form_routes.mirror_to_ingest=false means those Meta leads NEVER reach lead_intake_events. They are delivered, not lost, but invisible to any count keyed on intake."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 8e34c854-5fd9-4b1b-8804-640c2307575b
  modified: 2026-08-17T09:56:38.335Z
---

Settled 2026-08-17 while chasing an apparent 4% lead drop.

**`meta_lead_form_routes.mirror_to_ingest` decides whether a Meta lead is also written to
`lead_intake_events`.** When it is FALSE the lead is forwarded to its n8n destination and nothing lands
in intake. The lead is delivered. It is simply not countable by anything that reads
`lead_intake_events`, which is most of our reporting.

**What this looked like before I understood it:** ~60 Meta leads in 21 days with no intake row, which
I reported to Charlotte on 14-08 as "roughly 4% of forwarded leads never land". That framing was
WRONG. Breaking the 60 down:

- **28 were `clients.lead_only = true`** (National Eco, InstallrHub). Lead-only clients are Meta-only
  with no CRM intake BY DESIGN. `marketing-status-check` already excludes them from its Meta side for
  exactly this reason, which I had read and not applied.
- **24 were one form**, `PPL - MarkHarveyV1` (`1761565135043446`), whose route has
  `mirror_to_ingest: false`. Delivered via the partner path: `partner_lead_deliveries` holds 24 rows
  from 12-08 onward. Not lost.
- **~6 were genuinely unexplained**, across HQ Group (3), Greentide Backup (3) and Arktek (1), and 5 of
  the 7 DID have an earlier intake row for the same email. That small residue is the real
  "re-enquiry" pattern, at roughly two a week.

**The consequence worth acting on:** Mark Harvey is a per-lead client at £40 a lead, and his leads are
invisible to `lead_intake_events`, so any report keyed on intake under-counts him to zero.
`partner_lead_deliveries` is where they are. Decide deliberately whether his form should mirror.

**Method notes for next time.** Check `lead_only` and `mirror_to_ingest` BEFORE calling a Meta lead
missing, group the missing set by `form_id` early (24 of 30 sat in one form and the pattern was
invisible in the total), and rule out a match on phone and name before saying "absent": 1 of 32 had
landed under a different identifier.

See [[reference_lead_counting_model]], [[project_delivery_only_report]],
[[feedback_beacon_undercounts_dont_use_for_traffic]].

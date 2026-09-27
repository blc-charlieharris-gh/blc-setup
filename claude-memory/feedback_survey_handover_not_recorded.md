---
name: feedback_survey_handover_not_recorded
description: "CORRECTED 2026-08-12: the handover IS recorded, in leads.retainer_client_id (+ transferred_at / transferred_from). retainer_client_name is the intake-only field that is NOT it."
metadata:
  node_type: memory
  type: feedback
  originSessionId: f0dddaa7-d145-49d2-a755-e210eb20d4f8
  modified: 2026-08-12T09:39:25.681Z
---

**This memory said the handover was recorded nowhere. That was wrong, and it was wrong in the
confident "do not go looking for the field again" direction, which is worse.** Corrected 2026-08-12
by reading the rows, not the writers.

**The field is `leads.retainer_client_id`.** It holds a COMPANY id, it is stamped at intake AND when
a Green Tide lead is handed to a retainer out of Qualify, and that hand-over also sets
`transferred_at` and `transferred_from` ('qualify' / 'marketplace'). Proof, HQ Group
(company `d33137ff`): 14 leads carry the id and 3 are booked, while only 13 / 2 booked carry
`retainer_client_name = 'HQ Group'`. The third is lead `c998728b`, `lead_source: 'greentide'`,
`retainer_client_name: 'Green Tide Energy'`, `booking_type: 'published'`, `transferred_at: 08-08`,
`transferred_from: 'qualify'`. Arktek shows the same gap: 11 booked by id, 9 by name.

**`leads.retainer_client_name` is still NOT it,** and that part of the original memory holds.
`lead-ingest` writes it at INTAKE from the brand the lead arrived under and nothing updates it, so a
transferred survey still reads "Green Tide Energy". Any count keyed on the NAME under-reports the
hand-overs; that is exactly what showed HQ Group one survey when they had three.

**Count units by `retainer_client_id`, joined to `clients` through `company_id`.** A unit is one we
supplied (ours to pay for) when `transferred_at` is set or the intake name is not the client's own
brand. `useCostOfSupply` was rewritten onto this 2026-08-12.

**What is still genuinely missing:** the COST of a handed-over survey. Nothing links it back to the
campaign that produced it, so a client we supply only by hand (HQ Group) shows `?`, never £0. The
spec's "allocated" idea (source campaign's cost per booked survey) is still unbuilt.

**Lesson, the one worth keeping:** the original conclusion came from reading the writers of one
column and generalising to "the fact is not captured". Query the rows for the fact itself before
declaring a gap, and be slower to write "do not look again" into a memory.

See [[project_adset_client_attribution_override]], [[project_cost_of_supply]],
[[reference_client_billing_models]].

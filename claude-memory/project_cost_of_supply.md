---
name: project-cost-of-supply
description: "Performance > Cost of supply: what each client costs US, measured vs allocated vs not-recorded; shipped 2026-08-11, spend and leads only, no surveys until the handover column lands"
metadata: 
  node_type: memory
  type: project
  originSessionId: b5dd1666-e9e8-47f1-b3b0-1cde18f475a9
  modified: 2026-08-12T09:39:43.021Z
---

**REWORKED 2026-08-12** (see the three bullets at the bottom): revenue and margin removed on
Charlotte's call, units now counted off `leads.retainer_client_id`, and the "not recorded" state now
means "we supplemented them and cannot price it", not "their name appears on their own leads".

Shipped 2026-08-11 (marketing-agent #579). A client's own campaign is funded by them and costs us
nothing; anything we supplement off a Green Tide adset is our money and used to appear nowhere, so a
retainer could stop being profitable with nothing on screen changing.

**Nobody is billed for a supplemented lead.** This is cost-of-service, not a client charge. Charlotte
pushed back when it was framed as billing, and she was right.

Three states, in `src/lib/costOfSupply.js`:
- **measured**: a dedicated adset whose whole output goes to one client, so its spend IS the cost.
  Arktek (adset-level link, `transfers='surveys'`, he funds his own campaign and we top up surveys).
- **not recorded**: HQ Group. We hand them work off shared campaigns and nothing records the
  handover, so the row shows `?` and says why. **Never show £0 there**: it reads as "they cost us
  nothing", the opposite of true. This is now the strongest argument for
  `slots.delivered_to_client_id`, see [[feedback-survey-handover-not-recorded]].
- **own**: everything came off their own funded spend.

**v1 is spend and leads only, no surveys, deliberately.** The handover is unrecorded and
`usePeriodBookings` unions two incomplete routes as a stopgap due for deletion, so counting surveys
here would bake that in. Spec: `.claude/docs/client-cost-of-supply-spec.md`.

Retainer clients get cost and NO margin: their monthly fee is stored nowhere, so a margin would be
invented. Only per-lead clients have revenue.

**Mark Harvey Renewables is live as our first per-lead client**, £40 a lead
(`clients.per_lead_price`, a new column that needed an explicit `grant update` because `clients` is
column-allowlisted, see [[feedback-rls-needs-table-grant]]). Linked at CAMPAIGN level with
`transfers='all'` (we fund all of it), unlike Arktek's adset-level `'surveys'`. His campaign
"Heat Pumps – PPL -Mark Harvey Renewables" was PAUSED at close, so he reads zero until it is
unpaused. That is correct, not broken. See [[reference-mark-harvey-vs-harvard]].

**INTERNAL ONLY.** These figures must never reach a client report or client link, same rule as
[[feedback-report-prose-no-adspend]].

**The 2026-08-12 rework, all three on Charlotte's asks:**
1. **No revenue, no margin, no per-lead price on the screen.** "i dont need to record the profit,
   just the cost to us in marketing." `per_lead_price` stays in the DB, nothing in the hub reads it.
2. **Units come from `leads.retainer_client_id`**, not the RPC's resolved `survey_client_id` and not
   `retainer_client_name`. HQ Group read 1 survey against a real 3. See
   [[feedback-survey-handover-not-recorded]], which was WRONG and is now corrected: the handover IS
   recorded. The link route is still counted for a funded campaign nobody has handed over yet, and
   the LARGER of the two routes wins per client (not a sum: they overlap and the RPC returns totals,
   not lead ids).
3. **`unrecorded` now means `fromGreenTide > 0 && ourSpend === 0`.** The old rule fired for any
   client whose own name appeared on their own leads, so Gas Worx, who we do not supplement at all,
   read "Not recorded" in red. They now read "All their own", and the tag is "Cost not measured".

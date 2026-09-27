---
name: reference_lead_counting_model
description: "What each dashboard screen counts and why: campaign/tech/destination count EVERY lead, ad/creative/breakdown can only ever count tagged ones"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 1a8ed7c6-2687-4a83-9559-79fb3caafd7b
---

# The lead counting model (settled 2026-07-17)

**OUR leads = every lead that landed.** Not the subset carrying a `utm_content` that resolves to an ad. Charlotte's rule: "ad spend divided by OUR leads as the core figure throughout dashboard, performance and creative testing".

## Why some screens can be made whole and others never can

An untagged lead still knows its `technology` and `contact_source`. So:

| Level | Counts every lead? | Why |
|---|---|---|
| Campaign | YES | only ONE campaign drives each landing form, so there is exactly one honest bucket |
| Tech | YES | the lead carries its technology |
| Destination | YES | `contact_source` says landing vs instant form |
| **Ad / Creative / Creative Testing** | **NO, ever** | many ads in the campaign, nothing says which one an untagged lead came from |
| **Breakdown (placement/demo)** | **NO, ever** | an untagged lead has no placement/device. Meta knows that about a CLICK, our CRM only knows a lead arrived |

The ad/creative ceiling is not a to-do, it is information that does not exist. The fix there is **surfacing coverage** (`campaign_lead_coverage` + `CoverageBadge`), not changing the denominator. Without it, a campaign losing its ad ids makes every creative look several times too expensive, and whichever creative kept its tags "wins" a test on a measurement artifact.

## The mechanism
`bridge` reads `ad_performance_with_leads`, which joins leads to ads THROUGH `utm_content`. An untagged lead is real, sits in `lead_intake_events`, and appears in that view nowhere, so it was credited to nothing. Fixed by `ads_campaigns.landing_form_tech` / `landing_form_source`: set on the ONE campaign driving a form, untagged leads matching (tech, source) are credited to it. Null = normal campaign.

**Load-bearing constraint:** never set `landing_form_tech` on two campaigns for the same (client, tech). Untagged leads cannot be split between them. Verified 2026-07-17 via the Meta API that only `2026 Solar – Landing page` has a landing destination; Instant Form and Back Up PPL are lead-form campaigns with no website destination.

## Verification trick that made this safe
Simulate the new arithmetic as a plain SELECT before applying anything. The check that the rule is not distorting healthy data: **rows with nothing untagged must not move a penny** (both instant-form rows stayed at £28.94 / £25.03), and lead-form campaigns must land on exactly 100% coverage.

See [[project_greentide_solar_landing_tracking_gap]], [[feedback_beacon_undercounts_dont_use_for_traffic]].

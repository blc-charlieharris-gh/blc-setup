---
name: feedback-grants-ended-schemes-not-over-strict
description: "Grant rule (11-02): live national schemes = BUS + Warm Homes; ended ones (ECO4, GHG, RHI) never written, old pages redirect; council grant work is fine"
metadata:
  node_type: memory
  type: feedback
  originSessionId: cb2b7879-0a88-46ab-b106-58e9c4364844
  modified: 2026-11-02T10:09:24.035Z
---

Charlotte 2026-11-02 (Castle Eco research asked "do you still offer grant-funded work now ECO4 has ended?"): the national grant schemes running are the Boiler Upgrade Scheme and Warm Homes. Ended schemes (ECO4, Green Homes Grant, RHI) are never written about, offered or asked about; an old page about one redirects to the closest live page and gets no new page. But "there may be specific council grant work the installer will do, so we need to be careful we dont go over strict": local council grant work the client tells us about is fine to show.

**Why:** my first wording ("never offer, mention or ask about any other grant-funded work") was merged and she corrected it the same hour.
**How to apply:** the wording lives in marketing-agent `src/lib/grantFacts.js` (GRANT_FACTS, read by every writer AI). Ban only what's known dead, never a whole category. Related: [[feedback_grant_wording_not_urgent]].

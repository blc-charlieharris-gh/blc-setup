---
name: feedback_beacon_undercounts_dont_use_for_traffic
description: "funnel-beacon catches only ~10-25% of arrivals, so never use funnel_events as a traffic measure; the \"132 clicks vs 5 page views\" alarm was a measurement artifact, do not re-chase it"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 1a8ed7c6-2687-4a83-9559-79fb3caafd7b
---

# The beacon is not a traffic measure. Do not re-raise this alarm.

2026-07-17 I flagged "Meta charged £294 for 132 link clicks to the solar landing page but the beacon saw 5 arrivals" as a spend problem. **It was my own measurement artifact and the alarm was wrong.**

Measured over 8 days, arrival rate (beacon landing views / Meta link clicks):
- heat pump landing: 43 / 410 = **10.5%**
- solar landing: 35 / 150 = **23.3%**

Solar is *better* than heat pump, so there is no solar-specific traffic problem. **The proof it is the beacon and not the traffic:** heat pump landing produced **31 Fillout leads** in those 8 days from 43 recorded views. A 72% landing-to-lead rate is not a thing. People are arriving; the beacon does not see them.

Measured on Meta link clicks (which are real), both funnels are healthy: heat pump 410 clicks to 31 leads = **7.6%**, solar 150 to 8 = **5.3%**. Nobody is burning spend sending people nowhere.

**Why:** unknown. Likely the beacon losing the race against fast bounces in the Facebook in-app browser, or the POST being dropped. Not diagnosed. Edge function logs only cover a ~20 minute window, so absence of beacon calls there proves nothing.

## What this means
- **Never** use `funnel_events` counts as a denominator for traffic, LPV, or click-through health. Use Meta's `link_clicks`.
- The earlier "solar LPV 11% vs heat pump 67%" reading was the same class of error (and the 67% was inflated by a rogue pixel firing pre-consent).
- The **real** cost of the undercount: `funnel_events` is what the a/b split test reads, so the test samples a fifth of traffic and cannot pick a winner. That is the only thing worth fixing here, and it is much smaller than the alarm I raised. See [[project_greentide_split_testing_gap]].

## The general lesson
Before calling a gap a business problem, check the same metric on the CONTROL. One ratio in isolation looks alarming; the same ratio on a known-healthy funnel exposes it as instrumentation. Also: a conversion rate that would have to be implausibly good (72%) is a tell that the denominator is wrong, not that the numerator is impressive.

---
name: feedback-check-meta-activity-log-before-blaming
description: "Before saying who made/changed a Meta ad, read act_<id>/activities (actor_name); never infer \"Meta did it\" from odd hours or changed copy"
metadata:
  node_type: memory
  type: feedback
  originSessionId: c76e3076-060f-4ba1-a1d9-e675ede5ee0a
  modified: 2026-10-22T20:31:05.792Z
---

On 10-22 I told Charlotte Meta's automatic testing made LJP's "Test - Ad2 - std copy" ads (created 4:36am, different media and extra texts). Wrong: Meta's activity log showed Erin Tonkiss made them in Ads Manager (Power Editor). Erin works early UK hours; "Test - " is what Ads Manager prefixes on test copies, stacking each time.

**Why:** a confident wrong cause sent Charlotte toward pausing ads and changing account settings for nothing.
**How to apply:** for "where did this ad come from", run meta_api._get(f'act_{acct}/activities', fields event_type,actor_name,event_time,object_name, since/until) and quote the actor before explaining. Ads made outside the Hub land in Ads not linked by design. See [[feedback_never_use_ad_names]].

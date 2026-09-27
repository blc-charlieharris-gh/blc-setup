---
name: feedback_client_report_tone
description: "Client report copy rules: never devalue the weekly report itself, and never let a bad week requalify the campaign's level"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 3884ddb1-1602-4b05-ade8-60f43285d69a
  modified: 2026-08-03T15:48:11.983Z
---

Two rules for client-report narrative copy, both from Charlotte correcting an over-correction in `src/lib/reportNarrative.js` (marketing-agent, 2026-08-03):

**1. Never tell the client the week is the wrong thing to look at.** A line like "the multi-week trend is the better read than any single week" devalues the product we sell them. Where a week is genuinely noisy, answer it with the since-launch run rate ("across the 3 weeks since launch the campaign is averaging 10 leads a week at £84.39 each") so proportion comes from data inside the report, not a disclaimer.

**2. Level and trend are separate facts; neither may overwrite the other.** The corridor verdict answers "is this cost right for this campaign's age". The trend answers "which way did it move". A month-1 campaign slightly over its corridor that had a bad week is NOT "off target": that contradicts the month-1 expectation we set at the start. Only overshoot (>25% past the corridor) or maturity moves a verdict off target. A bad week may drop reassuring flourishes ("which is normal this early") but must not change the classification.

**Why:** the original bug was the opposite failure, the summary hid a 46% lead drop behind "normal this early". Fixing it by making the copy harsher swapped one dishonesty for another. The honest version states both facts plainly: worse than last week, still within expectations for the stage.

**How to apply:** when writing any client-facing performance copy, state direction first, then level, then context from real data. Test the phrasing against a week that is simultaneously "worse than last week" and "in line with expectations" (see [[project_arktek_ads_onboarding]]), both must survive. Related: [[feedback_silent_fallbacks_hide_dead_features]], [[project_client_weekly_reports]].

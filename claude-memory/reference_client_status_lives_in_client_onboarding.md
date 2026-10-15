---
name: reference_client_status_lives_in_client_onboarding
description: "A client's Live/Onboarding/Paused/Churned is client_onboarding.status, not companies.paused_at or is_active; filter client lists by it"
metadata:
  type: reference
---

The Hub client card status (Live = 'active', 'onboarding', 'paused', 'churned') is `client_onboarding.status` (latest row per company_id; pausedSince() reads checklist.paused_at). `companies.paused_at` is only the marketplace offer switch and was set for Helix alone on 10-15, while HQ Group and NIBE were paused in the Hub with no companies.paused_at.

**Why:** 2026-10-15 I listed portal contacts "not signed in" including paused HQ Group and NIBE; Charlotte: "again, you're including paused clients here".

**How to apply:** any client list for Charlotte (who to email, who hasn't signed in, who's affected) joins client_onboarding and leaves out paused and churned, then groups Live and Onboarding separately. Related: [[project_marketplace_pause_is_the_switch]], [[reference_retainer_client_coding_inconsistent]]

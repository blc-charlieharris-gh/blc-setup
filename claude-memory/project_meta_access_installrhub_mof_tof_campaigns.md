---
name: meta-access-installrhub-mof-tof-campaigns
description: "InstallrHub TOF/MOF funnel campaigns built 2026-09-03, found already ACTIVE (not paused) on 2026-09-04 review"
metadata: 
  node_type: memory
  type: project
  originSessionId: e4509f95-55ae-41a5-b43e-99fb0f626b02
  modified: 2026-09-04T12:24:50.580Z
---

2026-09-03 session (meta-access, InstallrHub account `act_7095438517245067`) built/edited three funnel campaigns: **TOF-Engagement Campaign** (21 ad sets/ads, one per video, THRUPLAY, GB 25-65 minus NI, per-video `3SEC-VIDEOn` exclusion, £30/day), **MOF-Retargeting Campaign** (19 ad sets/ads, same exclusion pattern, targets `3SEC-ALLVIDEOS-TOF` + `Website-LeadConverters` + `MOF-LeadFormSubmitted`, £20/day), and **MOF - Direct to offer campaign** (copy replaced on 11 existing ads, kept creative/CTA, £50/day). The handoff doc (`docs/current-handoff.md`) said all three were left **PAUSED** pending Charlotte's review in Ads Manager before a manual campaign-level toggle live.

**Why this matters:** on 2026-09-04, live Meta API pull showed all three campaigns already **ACTIVE** — someone toggled them live between the 09-03 handoff and 09-04, so the handoff's "current state" is stale. MOF-Direct-to-offer has only 3 of 11 ads ACTIVE (`hp1 - Copy`, `Vid2 - Copy`, `hp1 - Copy 2`) with the other 8 PAUSED — checked `issues_info` on all 8, no delivery errors/crop-enforcement flags, so this reads as a deliberate manual selection, not a bug.

**How to apply:** Don't trust `current-handoff.md`'s "current state" section as live truth for campaign status — always re-pull from the Meta API before acting on it, per [[reference_installrhub_meta_account_not_in_env]]. If Charlotte asks why only 3/11 MOF-DTO ads are live, that's the open question to raise (not yet confirmed whether intentional).

**2026-09-04 follow-up:** at Charlotte's request, removed the `3SEC-ALLVIDEOS-TOF` (TOF video-views) audience from `custom_audiences` on all 19 MOF-Retargeting ad sets, keeping only the two leads-based audiences (`Website-LeadConverters`, `MOF-LeadFormSubmitted`). Per-video `excluded_custom_audiences` left untouched. Validated via `execution_options=validate_only` before applying; spot-verified post-change (VIDEO19). This is a Meta "significant edit" (targeting change), so it reset learning phase + re-triggered ad review on all 19 ad sets — check insights next session to confirm delivery held. MOF-DTO's 3/11-active question is still open.

**2026-09-23 update:** the live MOF campaign is now **MOF-Retargeting Campaign - Copy** (`120250219254990731`, duplicated 09-14); the original `120250039988000731` is PAUSED. `build_mof_video_adset.py` had still pointed at the paused original, now fixed. It now holds VIDEO1-27 (20-27 added 09-23, live, £20/day unchanged). New MOF videos: rename in Drive to MOF-VIDEOn, download with `drive_download.py`, run the script per video (`--video-id` resumes after a Reel was already published).

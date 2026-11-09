---
name: project_ih_ads_tof_mof_1109
description: "InstallrHub always-on ads: MOF and TOF are kept on purpose, MOF wants frequency 5+ on warm people; Advantage audience on makes the MOF list only a suggestion; 9 Nov review"
metadata:
  node_type: memory
  type: project
  originSessionId: 1920b7dd-44c8-4923-a500-2978f6758e03
  modified: 2026-11-09T17:47:43.215Z
---

InstallrHub ads review, 9 Nov 2026 (act_7095438517245067). Charlotte's steer: TOF and MOF-Retargeting feed the funnel and stay, never recommend pausing them. MOF is meant to run at frequency 5 or above on warm people only. The goal is InstallrHub's own leads, not webinar sign-ups (no webinar planned yet).

Found live:
- MOF ad sets target Website-LeadConverters + MOF-LeadFormSubmitted (DTO V1-V5), but `advantage_audience: 1` lets Meta go beyond them. Reach was about 26k to 29k people per 3 weeks against a list of about 1,000 to 2,000.
- MOF's frequency of about 5 before 19 Oct was Audience Network: 99.7% of impressions 28 Sep to 18 Oct. An API edit on 19 Oct removed Audience Network, spend moved to Facebook, frequency fell to about 1.7. No note found of who made the edit.
- The DTO ad set also has `advantage_audience: 1`, so "warm viewers" is not strict there either.
- TOF is CBO over 21 video ad sets with ThruPlay optimisation, so one video takes 83% to 97% of spend (VIDEO20 until 1 Nov, VIDEO15 from 2 Nov), at about 1p per ThruPlay. TOF has no installer targeting: GB 25-65 broad.

CAPI scoring (plan-sales-crm.md section 3, still a suggestion for Serafim) as of 9 Nov: only demo bookings (Schedule, sent by the CRM since 2 Nov) reach Meta; no score, Qualified or Won event yet; zero QualifiedLead sent; the lead campaign still optimises for plain instant-form leads. CAPI does work with instant forms (bookings already carry lead_id). Brad's 11-02 answers: MCS is the target, Working towards MCS and Umbrella unwanted.

Approved plan, 9 Nov (£315 a day): old TOF CBO off, new TOF Broad and TOF Lookalike (both ABO, same 6 videos at £10 each, rounds), DTO Broad unchanged at £80, new DTO Lookalike £80 on lookalike viewers, MOF £35. MOF Advantage audience turned off on all 27 ad sets 9 Nov (needs age_range removed from targeting first). Copying a video for its own viewer list: /advideos uploads are refused (#2654); a Page video with published=false, no_story=true works and is not public (LAL-VIDEO15 = 1454717912740531, audience 3SEC-LAL-VIDEO15 = 120251135601860731). Ad account is on development tier: heavy reads hit a limit (code 17).

Lookalike built 9 Nov: seed customer list IH-Qualified-Leads-Nov26 = 120251136611800731 (449 hashed form leads: MCS any size 357, umbrella 5+ 44, working towards 5+ 48; Charlotte put working towards in; 0-4 without MCS out). Meta form audiences can't filter on answers, so a list upload is the only way. 1% lookalike LAL-1%-IH-Qualified-Leads-GB = 120251136615280731, about 372k to 437k, ready. Country in lookalike_spec is going away in v27, so ad sets must set UK. Hidden copies (copy / 3SEC-LAL audience): VIDEO20 2633461367151465 / 120251136585960731, VIDEO16 3783473108475268 / 120251136610190731, VIDEO13 1122698703874980 / 120251136620710731, VIDEO5 1418702607082986 / 120251136627560731, VIDEO21 1489453393041692 / 120251136638910731. Test videos: VIDEO20 (paused 2 Nov on purpose because it took all the spend, back in as an ABO test), 15, 16, 13, 5, 21. Built 9 Nov, campaign PAUSED with ad sets and ads ACTIVE inside (one toggle each, go live together, old TOF off same day): TOF Broad (ABO) 120251136699140731, TOF Lookalike (ABO) 120251136700920731, DTO Lookalike 120251136705480731. Renamed 9 Nov: MOF - Direct to offer campaign is now DTO Broad (120250022035140731), MOF-Retargeting Campaign - Copy is now MOF Retargeting (Sign-ups) (120250219254990731). All three went LIVE 9 Nov 13:06, old TOF paused (£315 a day total), review around 23 Nov. TOF Broad excludes the lookalike and TOF Lookalike excludes 3SEC-ALLVIDEOS-TOF so the two sides stay apart; Direct to offer keeps Advantage on, so it isn't fully separate. VIDEO21 was added to 3SEC-ALLVIDEOS-TOF on 9 Nov (it had only £4 of spend ever, so nothing lost). New videos must be added to that list by hand. Hub notes are saved on the new campaigns. In the Hub, each video and DTO ad is merged into one creative across campaigns (creative_merges), the 4 DTO Lookalike ads are linked to their DTO Broad designs, and TOF and MOF videos are dismissed from Ads not linked. New DTO ads go in both DTOs. DTO Lookalike had £0 by the evening of 9 Nov: ACTIVE, but it only reaches TOF Lookalike viewers, so that list has to build first; check it delivers by 11 Nov.

**Why:** a future session could read MOF's zero leads as waste, or read its old high frequency as proof it was working.
**How to apply:** judge MOF on who it reaches and its frequency, not direct leads. Re-pull live before acting. Related: [[reference_ih_cost_per_discovery_demo]], [[project_meta_access_installrhub_mof_tof_campaigns]].

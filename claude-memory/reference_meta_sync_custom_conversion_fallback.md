---
name: reference-meta-sync-custom-conversion-fallback
description: "meta-sync counts standard Lead first, but falls back to SUMMING all custom conversions on an ad with no Lead (non OUTCOME_LEADS campaign); PageView CCs would inflate"
metadata:
  node_type: memory
  type: reference
  originSessionId: 5a111bcf-16ac-42d5-be7d-23ad886130dc
  modified: 2026-10-03T14:16:08.662Z
---

meta-sync (marketing-agent supabase/functions/meta-sync/index.ts ~479-485, per blc-87 3 Oct 2026): counts the standard Lead action (lead / fb_pixel_lead) first. Only if an ad has no Lead action that day AND its campaign is not OUTCOME_LEADS does it sum every offsite_conversion.custom.* on that ad.

InstallrHub (act_7095438517245067) has PageView-based custom conversions that count visits, not conversions: "InstallrHub Booking" 807560985310340 (/thank-you), "BLC Schedule" 701599905991249 (any URL containing thank-you, incl. /webinar/thank-you), "InstallrHub Lead" 2029603298436601 (/book-a-demo). /thank-you is linked from GHL emails and the MOT booked-in card. As of 3 Oct no active ad set optimises on them (only "Webinar - Broad" uses a CC: Webinar Registration 2258431381610266) and no insights rows were counted from a CC.

**How to apply:** any new IH web campaign must fire standard Lead on the page (MOT does, js/mot.js fireLead) and optimise on a Lead+URL custom conversion; never optimise on the PageView ones. Archiving them is Charlotte's call. Related: [[feedback-meta-lead-counting]].

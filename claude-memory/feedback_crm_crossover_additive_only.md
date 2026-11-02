---
name: feedback_crm_crossover_additive_only
description: "CRM crossover (from 2 Nov 2026) is additive only: never stop old-app or GHL activity until Charlotte confirms the app is no longer running"
metadata:
  node_type: memory
  type: feedback
  originSessionId: c0d4a966-8e2a-439a-a637-eeb19c19a079
  modified: 2026-11-02T10:20:29.917Z
---

Charlotte 2 Nov 2026: "we're not stopping any app activity yet are we? until we know for sure app is no longer running."

State on 2 Nov: leads go to the old app (installer_prospects), GHL and the new CRM (crm.installrhub.com, crm_door_mode on); website discovery/demo bookings go ONLY to the CRM (site env CRM_BOOKING_PAGES=discovery,demo). Whether telesales work in the app or the CRM is Serafim/Brad's call, unconfirmed.

**Why:** the crossover isn't confirmed; switching off an app or GHL write early loses data people still use.
**How to apply:** every CRM change reads/writes both (old + CRM), never instead. Switch off an old-app or GHL write only after (a) the CRM receives the same thing and (b) Charlotte says the app is off. Client MOT notes go on the CRM person like any other activity (11-02). Plan: marketing-agent `.claude/docs/plan-crm-integration.md`. Related: [[project_webinar_questions_1102]], [[project_ghl_removal_hub]].

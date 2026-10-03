---
name: feedback-installrhub-signup-vs-lead-rule
description: "InstallrHub reporting rule (Charlotte 2026-10-03) - lead magnets = sign-ups, direct-to-offer forms = leads, triage = triage, viewed by source"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 5a111bcf-16ac-42d5-be7d-23ad886130dc
  modified: 2026-10-03T14:16:07.620Z
---

InstallrHub's own funnel: every lead-magnet page/form (webinar, forecast, resources/breakdown, Installer MOT) counts its conversion as a SIGN-UP; direct-to-offer forms (homepage contact, DTO instant form) count as (sales) LEADS; triage bookings count as triage bookings, broken down by source. No separate per-magnet triage metric (e.g. "MOT triage") needed.

**Why:** most MOT/webinar people are already contacts; counting a lead magnet as a sales lead inflated leads. Charlotte, 3 Oct 2026.

**How to apply:** new lead-magnet pages need adding to SIGNUP_SOURCE_RE / SIGNUP_PAGE_RE in marketing-agent src/lib/b2bAppointments.js. The Hub splits triage only by channel (ads/organic/outbound/old_list) as of 3 Oct; form-level triage-by-source is pending the sources audit. Hub counts people once (email/phone match), at their first form fill.

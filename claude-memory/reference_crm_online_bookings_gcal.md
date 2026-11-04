---
name: reference_crm_online_bookings_gcal
description: "Site discovery/demo bookings go to the sales CRM, which makes the right meeting type in the rep's Google Calendar; blank meet_link on online rows in hub_crm_bookings is not a fault"
metadata:
  node_type: memory
  type: reference
  originSessionId: 0b5481e2-5705-450f-8a6e-b3ef2173efd1
  modified: 2026-11-04T16:30:30.575Z
---

Website discovery and demo bookings (installrhub-static api/_crmBook.js) post to the CRM's booking page for that type (/booking-page/discovery or /demo). The CRM makes the meeting and the rep's Google Calendar event with the right type (Charlotte confirmed 11-04: Serafim sorted it).

Online rows in hub_crm_bookings have no meet_link or length_minutes; staff-booked ones do. That is only the Hub's copy, not a missing calendar event, so don't flag it.

Calls book at most 6 days ahead (MAX_DAYS_AHEAD in _crmBook.js, 11-04).

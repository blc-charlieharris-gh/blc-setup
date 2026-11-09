---
name: project_madola_leads_booked_by_phone
description: "Madola leads are only booked by phone, so the Hub web booking path writing 'survey' for battery-only jobs is not a gap"
metadata:
  node_type: memory
  type: project
  originSessionId: 1a618904-df20-4fc2-991f-bbd50e5bac99
  modified: 2026-11-09T15:36:48.349Z
---

Madola's leads are only ever booked over the phone (Charlotte 2026-11-09), so `_shared/retainer-slot-write.ts` always writing appointment_mode 'survey' doesn't affect their battery-only jobs. The note on the 11-09 11:34 row of serafim-changes.md reads like a gap; it isn't one.

**Why:** Serafim's battery_only_booking_mode rule (Madola = call) lives in his app, which is where those phone bookings happen. I raised the web path as a problem and it was not.

**How to apply:** don't raise it again in Serafim checks or summaries ([[feedback_drop_parked_items]]). The separate watch still stands: once telesales book in the CRM, `crmTelesales.js` needs his rule.

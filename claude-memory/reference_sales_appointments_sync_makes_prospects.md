---
name: reference_sales_appointments_sync_makes_prospects
description: "The app's sync-sales-appointments (every 30 min) creates installer_prospects + Ring tasks for ANY InstallrHub GHL calendar booking, e.g. job interviews"
metadata:
  node_type: memory
  type: reference
  originSessionId: 59c668e8-d295-49a2-b80e-6f4a456ff737
  modified: 2026-10-20T13:55:43.089Z
---

Serafim's `sync-sales-appointments` edge fn mirrors every calendar on the InstallrHub GHL location into `sales_appointments`, and for any contact with no prospect it inserts an `installer_prospects` row (source 'unknown', channel 'outbound', stage new_lead), which fires a "Ring <name>" telesales task. On 2026-10-20 six job candidates on the "Interviews" calendar showed up as overnight "new leads", landing on the hour/half-hour.

**How to apply:** "new leads" with source unknown, no intake row and created at :00/:30 are calendar bookings, not lead-intake gaps: check `sales_appointments.calendar_name`. Fix is Serafim's (exclude non-sales calendars); Charlotte said he knows. Deleting the prospects just recreates them on the next tick.

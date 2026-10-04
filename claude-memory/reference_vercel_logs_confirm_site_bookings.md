---
name: reference_vercel_logs_confirm_site_bookings
description: Confirm installrhub.com bookings/form posts without GHL access via blc-vercel logs (POST /api/book 200 = GHL appointment created)
metadata:
  type: reference
---

`~/code/blc-setup/bin/blc-vercel logs --scope blc-promotions --project installrhub-site --environment production --since 2h --query "/api/book" --json` lists request rows (requestMethod, responseStatusCode, logs). api/book.js only returns 200 after GHL has created the appointment, so a POST 200 with empty `logs` means it was booked. The logs don't show which calendar. The Hub mirror `sales_appointments` (calendar_id, start_at, title) syncs hourly on the hour, so very recent bookings aren't there yet. Pulling GHL_BOOKING_TOKEN from Vercel is blocked (credential materialization), so Claude can't cancel GHL appointments. Related: [[project_mot_booking_calendar]], [[reference_installrhub_site_deploy_and_verify]]

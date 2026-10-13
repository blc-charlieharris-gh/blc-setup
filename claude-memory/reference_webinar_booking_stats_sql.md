---
name: reference_webinar_booking_stats_sql
description: "How to count InstallrHub webinar bookings by hand (on-webinar demos vs triages/demos booked after), no screen for it yet"
metadata:
  node_type: memory
  type: reference
  originSessionId: a6e79e05-41b6-45a9-bd1a-4a386b06fab4
  modified: 2026-10-13T07:07:00.084Z
---

No Hub screen for InstallrHub webinar booking stats yet (Charlotte 2026-10-13: build it in the InstallrHub marketing stats part of the audit). Pulled by SQL for her boss 10-13.

- **On the webinar:** `booking_attribution` rows with page_url `/webinar/book-demo` and utm_source `event` (utm_campaign = event slug, e.g. webinar-oct2026). Exact. Join `sales_appointments` on ghl_appointment_id for status.
- **Outside the webinar:** webinar crowd = `mailing_contacts` with tags like `webinar-oct26%` / `webinar-oct2026%`; their `sales_appointments` on calendars `InstallrHub Discovery` (= triage) and `InstallrHub Demo` created after the event start. Team-booked = no booking_attribution page (created_source calendar_page/contactdetails_page/third_party); follow-ups carry utm_campaign `webinar-oct-2026-*`. Can be a few under: some attendees never got tagged (4 of 26 webinar bookers had no tag).
- Can't split team bookings into call/WhatsApp/email: nothing records which.
- Charlotte wanted cancelled bookings included and noted, and counts by people (one double-booker counted once). 10-13 answer: 26 on webinar (3 cancelled), 44 triages (2 cancelled), 14 demos outside.

Related: [[project_webinar_page_automation]], [[feedback_charlotte_plain_explanations]]

---
name: ih-demographics-tab
description: Hub /ih-demographics (live 2026-10-19): Meta age/gender/region + form answers + anonymous form drop-off; where each piece lives
metadata:
  type: project
---
Live 2026-10-19. Now InstallrHub > Analytics (/ih-analytics, #2095: Sources + Demographics, 9 tabs; /sources and /ih-demographics redirect). Was /ih-demographics (#2081, migration 20261019121700: form_progress_events, log_form_progress, ih_demo_* RPCs). meta-sync writes breakdown_type 'demographic' (age, gender) and 'region' (#2082; Meta UK region = four nations only). Site sends anonymous progress via js/progress.js -> /api/progress (#218), every submission keeps its answers. Meta gives totals only, never per-lead age.

**Why:** Charlotte wants targeting narrowed by who converts (MCS, 5+ installs), not just cheapest CPL.
**How to apply:** new form fields should use canonical answer keys (service, installs, mcs, ...) listed at the top of js/progress.js. Related: [[project_ih_kpis_journey_page]].

Bookings (2026-10-19): edge fn meta-booking-events sends CAPI 'Schedule' for InstallrHub Discovery/Demo bookings (sales_appointments), ledger meta_capi_bookings_sent, cron meta-booking-events-hourly :41; Meta only accepts events up to 7 days old, so booking history starts 12 Oct and builds up. Meta returns NO lead actions for the region breakdown (Region = spend only). Lead quality counts one person per ad (#2099); bookings matched via mailing_contacts email/phone to sales_appointments.

Gotcha (2026-10-20): Meta reports CAPI 'Schedule' bookings in the insights `conversions` field (schedule_total), NOT `actions`; meta-sync reads both since #fix 10-20. Meta attributed 13 of the first 38 (only bookers who saw/clicked an ad recently). Region gives no conversions either.

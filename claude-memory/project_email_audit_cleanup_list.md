---
name: project-email-audit-cleanup-list
description: "Charlotte 10-04: at the Hub email audit, remove unused bits (nurture funnel keys etc.), come off n8n altogether (touches Lead Intake, already audited) and switch off GHL nurture workflows"
metadata:
  type: project
---

Since 10-04 the Hub starts all three nurture sequences from form fills ("Who joins": general = MOT, Forecast, Breakdown, Homepage, Meta; Resources = Breakdown; Webinar-Oct2026 = Webinar). n8n "nurture new" tag nodes removed by Charlotte; webinar/resources GHL workflows (tag -> *_completed check -> nurture-enroll funnel_key) still active as harmless backups. General nurture "Who's allowed in": leave out anyone in Webinar-Oct2026 for 90 days.

**Why:** she wants one way per thing and n8n gone, but not mid-week.
**How to apply:** at the email audit (hub-audit README rows 23-24 + End deliverables): remove unused funnel keys, replace n8n for every lead path (source/first-touch only on NEW contacts), switch off the GHL nurture workflows, re-check Lead Intake (it reads the GHL intake copy). First build next session: webinar sign-ups go to the NEXT webinar's sequence automatically (must land before the November webinar page goes live). Related: [[feedback_source_first_touch_classify_on_page]], [[project_hub_page_audit]].

---
name: project_webinar_page_automation
description: "installrhub.com/webinar runs itself from the Hub event (10-04): states, close time, missed-webinar form → n8n webinarnext → Lead Nurture"
metadata:
  node_type: memory
  type: project
  originSessionId: 335f3750-3894-423d-b4fe-8adc1f8f1e90
  modified: 2026-10-04T19:30:46.968Z
---

Live 2026-10-04 (site #131, Hub #1436-#1442). Per new webinar Charlotte only creates the event in Hub Events, picks its sequence, ticks "Webinar sign-ups join this one" (optional "Sign-ups close at", blank = end minus 10 min). The page reads `webinar_page_event()` via site `api/webinar-event.js`: early, then countdown (12h), then live, then over.

- Over form: key `installrhub-webinar-over`, page `/webinar-over`. Hub route goes to n8n flow "Webinar missed - next one" (webhook path `...-webinarnext`), which tags `webinar-missed` plus the telesales tag. The Hub classifies it by Converted Page as `webinar_over` and enrols it in Lead Nurture - No Booked Call. It never joins the next webinar's sequence. Tested end to end 10-04 19:30.
- Webinar sign-ups between webinars wait and join the next webinar's sequence once it exists.
- The page's title/og tags and headline copy are still hand-written per webinar.

**Why:** Charlotte wants webinars fully automatic, with nothing lost and no site edits.
**How to apply:** for a new webinar, don't edit site times. Check the event is ticked and has an active sequence. Related: [[feedback_source_first_touch_classify_on_page]], [[project_email_audit_cleanup_list]].

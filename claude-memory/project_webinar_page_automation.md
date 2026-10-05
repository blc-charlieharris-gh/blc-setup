---
name: project_webinar_page_automation
description: "installrhub.com/webinar runs itself from the Hub event: states incl. 48h replay (10-05), pages each form goes to, missed-webinar form -> n8n webinarnext -> Lead Nurture"
metadata:
  node_type: memory
  type: project
  originSessionId: 335f3750-3894-423d-b4fe-8adc1f8f1e90
  modified: 2026-10-04T19:30:46.968Z
---

Live 2026-10-04 (site #131, Hub #1436-#1442). Per new webinar Charlotte only creates the event in Hub Events, picks its sequence, ticks "Webinar sign-ups join this one" (optional "Sign-ups close at", blank = end minus 10 min). The page reads `webinar_page_event()` via site `api/webinar-event.js`: early, then countdown (12h), then live, then replay (from sign-ups close until `replay_until`, default end + 48h, added 2026-10-05), then over.

- Pages (2026-10-05): sign-up -> /webinar/thank-you; replay form (key `installrhub-webinar-replay`, Converted Page /webinar/replay) -> /webinar/replay (video from the event's Replay link, YouTube or a Drive file shared "anyone with the link"; "coming soon" until set; entry only via form or ?cid=); over -> /webinar/thank-you-next; every book-a-call -> event `discovery_page`, default /webinar/book-discovery; demo = /webinar/book-demo ("30-minute Loan Scheme Growth Session", GHL Demo calendar is 45 min on purpose, site shows 30). Any booking ends on /thank-you.
- Replay route (landing_form_routes) must wait for the nurture-run redeploy with the webinar_replay rule, else replay fills join the next webinar's emails (any source containing "webinar" = sign-up).

- Over form: key `installrhub-webinar-over`, page `/webinar-over`. Hub route goes to n8n flow "Webinar missed - next one" (webhook path `...-webinarnext`), which tags `webinar-missed` plus the telesales tag. The Hub classifies it by Converted Page as `webinar_over` and enrols it in Lead Nurture - No Booked Call. It never joins the next webinar's sequence. Tested end to end 10-04 19:30.
- Webinar sign-ups between webinars wait and join the next webinar's sequence once it exists.
- Title date fills from the event; share/meta text is date-free. The share image (images/webinar/og-webinar.jpg) has the date baked in: new image per webinar (on the Hub's next-webinar checklist). Headline copy is hand-written per topic.

**Why:** Charlotte wants webinars fully automatic, with nothing lost and no site edits.
**How to apply:** for a new webinar, don't edit site times. Check the event is ticked and has an active sequence. Related: [[feedback_source_first_touch_classify_on_page]], [[project_email_audit_cleanup_list]].

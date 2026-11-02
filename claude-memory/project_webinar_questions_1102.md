---
name: project_webinar_questions_1102
description: "Webinar questions (2 Nov 2026): /webinar/question page from emails, telesales Log a question, one list on the event; CRM note waits on the CRM owner"
metadata:
  node_type: memory
  type: project
  originSessionId: c0d4a966-8e2a-439a-a637-eeb19c19a079
  modified: 2026-11-02T09:10:32.561Z
---

Built 2 Nov 2026 (site branch feat/webinar-question-page-1102, Hub branch feat/webinar-questions-1102):
- Emails link `installrhub.com/webinar/question?cid={{contact_id}}`, NEVER /webinar/thank-you: the thank-you page fires the Meta Lead ("Webinar Registration" conversion) and the /webinar/thank-you audience rule, so an email click would count as a sign-up.
- One form for all three sources (thank-you page, question page, telesales `api/event-question.js` with page `/hub-question`, logger in utm_content): form key `installrhub-webinar-question`, listed on the event's On the day > Questions sent in with where it came from.
- Future webinars: the event card's red box flags when no sign-up email links the question page; on the set-up checklist.
- Prospect record: each question is a note on the app prospect (sales_outreach_log) via trigger hub_webinar_question_note on site_form_submissions (Charlotte 11-02: we own lead ingest, no GHL). CRM notes door is an extra ask: `.claude/docs/crm-question-note-ask.md`.

**How to apply:** new webinar emails asking for questions use the question page link; when the CRM owner adds a notes door, route questions into hub_crm_outbox. Related: [[project_webinar_page_automation]], [[project_event_invites_telesales]].

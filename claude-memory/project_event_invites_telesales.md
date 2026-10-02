---
name: project_event_invites_telesales
description: Event invites built 2026-10-02 - /events page, per-event settings, telesales (Louise, Leon) invite/resend/correct-email
metadata:
  type: project
---

Built 2026-10-02 in marketing-agent (PRs #1310 onwards). Telesales (Louise McGrath, Leon Vengesten) have ONLY the `event_invites` permission and land on /events (cards). Admins get the events manager on the same page (was Email > Events).

Each event (calendar_events) needs, set on the event form: signup_form_key (installrhub.com form registry key, e.g. installrhub-webinar-oct6), signup_url, nurture_sequence_id, resend_step_id, optional invite_subject/invite_body (visual editor; {{first_name}} {{company}} {{event}} {{date}} {{event_details}} {{calendar_button}}). Outside the Hub each event still needs: the site page + form registered in installrhub-static api/_forms.js, n8n -> GHL tag -> nurture-enroll funnel_key, and the nurture sequence.

Flows: Invite someone = api/event-invite.js posts to installrhub.com/api/contact with page '/hub-invite' (site then needs only name+email), then sends the invite email from the sequence sender (hub_event_sender). Resend = api/event-resend.js, one email set on the event, never re-enrols. Correct their email (bounce only) = hub_event_correct_email + broadcasts edge fn correct_contact_email (updates GHL). All refuse unsubscribed/bounced/complained/GHL-DND (hub_email_blocked). Invite email never names the inviter (GDPR).

**Why:** Charlotte wants telesales to add people who asked to come (often a colleague of who they spoke to) exactly as a page sign-up.
**How to apply:** new events work end to end once the four settings are filled; if invites fail with "Unknown form", the site form isn't registered.

---
name: project-onboarding-emails
description: "Four client-onboarding emails: 3 fired by app.installrhub, only go-live is ours; go-live is a reviewed manual send, never an auto-trigger, and both boards ignore anything before 2026-08-11"
metadata: 
  node_type: memory
  type: project
  originSessionId: b5dd1666-e9e8-47f1-b3b0-1cde18f475a9
  modified: 2026-08-11T08:36:28.313Z
---

Shipped 2026-08-11 (marketing-agent #568, `feat/onboarding-emails`). Four emails between "sold" and
"live", split by who sends:

| # | Email | Sent by |
|---|---|---|
| 1 | Welcome + start onboarding | app.installrhub (Serafim's trigger) |
| 2 | Chaser, form not back after 2 days | app.installrhub (moved to auto 08-11; hub sends it by hand until his trigger lands) |
| 3 | Onboarding complete, "now we build" | app.installrhub (on form submit) |
| 4 | Go live | **us**, Emails > Onboarding |

`src/lib/onboardingEmails.js` renders all four and is the single source of truth: the in-app preview,
the Resend send, and the three templates Serafim ports (`design-handoff/emails/01,02,03`) are the
same code. Those three files are GENERATED, regenerate rather than hand-edit. `03-youre-live.html` was
deleted. Send path is `api/onboarding-email.js`, a staff-gated Resend relay copied from
`api/crew-audit-email.js` (`ONBOARDING_EMAIL_FROM`, defaults to brad@installrhub.com). Emails sign off
as **The InstallrHub Team**.

**Why go-live is not an automatic trigger on Take live** (it was specced as one): the body carries the
client's survey delivery details (Google Sheet link, or WhatsApp / CRM wording) and whether their
website is in build, and none of that is reliably on the record. Every client onboarded on the old
form has `onboarding_answers = '{}'`, so the operator picks the delivery mode in a composer. Taking a
client live instead raises a permanent red "[client] go live email to be sent" card
(`goLiveEmailActions` in `lib/actions.js`); sending ticks `golive_email_sent`, the only thing that
clears it. That checklist item `applies` only when `status === 'active'`, so it cannot block the
"ready to take live" gate. See [[project-client-onboarding-engine]].

**`ENGINE_LIVE_FROM = '2026-08-11'` gates both boards.** The chaser ignores clients created before
it (LJP Plumbing & Heating came off the old form and is never chased) and the go-live list gates on
`activated_at`, not on status alone, so Arktek / HQ Group / National Eco (long since live and told)
stay off it. A date, not a per-row flag: no backfill write, nothing to undo.

**The chaser has a hard dependency:** `writeCommercialSatellites` only INSERTs, so
`checklist.form_submitted` can never be set after the row exists. Until that is fixed an automatic
chaser would email clients who already submitted. Blocks Serafim's email 2.

**The graph is a hosted PNG at `public/email/initial-graph.png`**, referenced ABSOLUTELY as
`https://internal.installrhub.com/email/initial-graph.png`. Verified that real files in `public/`
serve past the SPA catch-all rewrite in `vercel.json` (they return their own content-type; only
unmatched paths fall through to index.html). An inbox has no relative base and no session, so any
future email asset must follow the same rule.

**Still owed by Serafim:** `onboarding_url` on the 2-hour pull contract. The chaser needs the client's
tokenised onboarding link, the hub never sees the token, so today the operator pastes it per client
and it is remembered in localStorage (`ih_onboarding_links`). Handoff note:
`docs/serafim-2026-08-11-onboarding-emails.md`, which supersedes T2 in
`docs/serafim-onboarding-handoff.md`.

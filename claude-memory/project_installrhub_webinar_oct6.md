---
name: project-installrhub-webinar-oct6
description: "InstallrHub 6 Oct Warm Homes Loan webinar page state (09-21): speakers, Installer MOT bonus live, open sign-offs, CSS cache-bust rule"
metadata: 
  node_type: memory
  type: project
  originSessionId: 142b5b8c-2390-499e-bb11-d625d4119d15
  modified: 2026-09-22T07:10:03.444Z
---

/webinar on installrhub.com (repo site-installrhub/installrhub-static, commits straight to main, auto-deploys; check www.installrhub.com since apex 307-redirects). Shipped 2026-09-21 in 397d44b, handoff doc at docs/current-handoff.md.

- Speakers: Brad Clark (InstallrHub, lead gen & sales), Scott Law (FinMatch co-founder, finance), Chelsea Showering (Midsummer BDM, Easy PV, design & quoting). Bios written by Claude from LinkedIn, NOT yet approved by the speakers.
- Lead magnet is now the "Installer MOT" diagnostic, badge "Free Live Bonus", only for live attendees. Mockup categories/score are illustrative.
- logo-partner-a = Midsummer, logo-partner-b = EasyPV.
- Meta Lead on signups LIVE (PR #65): IH_TRACK_LEAD on /webinar/thank-you, verified accept=PageView+Lead, reload=no repeat. Playwright needs a normal Chrome user agent or Meta sends no pixel traffic.
- Small-laptop fix live 09-22 (1625ea3): fixed form lane from 1280px, 460px card below 1536px, compact form up to 900px tall. CSS now ?v=20260922a.
- Source photos/mockup originals live in site-installrhub/webinar/ (outside the git repo).

**Why:** Charlotte twice saw "nothing changed" because the browser cached webinar.css.
**How to apply:** bump the `webinar.css?v=` query on all 3 webinar pages with every CSS edit, and verify rendering with Playwright screenshots before claiming done. Related: [[project_installrhub]], [[project-higgsfield]].


## Nurture emails rebuilt (22 Sept)
The Webinar-Oct2026 nurture (key prospect-seq-1788437607951) had placeholder links ([WEBINAR LINK], [CALENDAR LINK], [LINK]). Charlotte's ChatGPT-session edits from 21 Sept were never saved in the Hub. All 17 steps were replaced from her final text (source + builder in session scratchpad webinar/), verified byte-for-byte. Emails 10 and 13 carry the Installer MOT line. Calendar sections have Google + Outlook.com + work Outlook buttons. Step 15 SMS moved to 17:00. Lesson: the nurture editor has no unsaved-changes warning.

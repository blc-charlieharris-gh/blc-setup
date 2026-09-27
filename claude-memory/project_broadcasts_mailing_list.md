---
name: project-broadcasts-mailing-list
description: "Hub Broadcasts + Mailing list tabs (email/SMS blasts and drips to GHL InstallrHub contacts), LIVE 09-22 (PR #885), 2nd Resend webhook + eco4 line pending"
metadata: 
  node_type: memory
  type: project
  originSessionId: 9cacf443-1b51-4771-bf69-9f65af684541
  modified: 2026-09-22T08:06:42.970Z
---

Built 2026-09-22, merged (feat/broadcasts). Migration applied, edge fn `broadcasts` deployed (first dashboard deploy got slug rapid-worker, redeployed with the right name). First sync: 544 contacts.

- Emails > **Mailing list**: `mailing_contacts` mirrors the GHL installr sub-account hourly (edge fn `broadcasts` action sync), matched to companies / installer_prospects / sales_appointments, with a clean-up list (duplicates, no email, clients missing from GHL).
- Emails > **Broadcasts**: filters go through ONE SQL fn, `mailing_audience(jsonb)`, used for both the live count and the launch. Supports multi-step email+SMS drips, drip_per_hour, 08-20 London window, and exit reasons (always: unsubscribed/bounced/complained/dnd/removed_from_ghl; optional: became_client, booked_call).
- SMS consent: NO gate and NO tickbox (Charlotte, 09-22). Every site form carries a privacy line saying they'll get news and offers by email and text. Meta form leads are treated the same. Only GHL DND/STOP blocks SMS. PRs: site fix/privacy-line-no-tickbox, hub fix/broadcasts-sms-no-consent-gate. The live fn needs the one `no_sms_consent` line deleted. No n8n change needed.
- Found 09-22: api/nurture-unsubscribe.js was a silent no-op (no SUPABASE_SERVICE_ROLE_KEY on Vercel, 0 unsubscribes recorded across 352 nurture emails). It now re-exports api/broadcast-unsubscribe.js, which calls the edge fn.
- Still to do: a Resend webhook to `.../functions/v1/broadcasts?action=resend_webhook` plus the BROADCAST_RESEND_WEBHOOK_SECRET secret. GHL /contacts/search worked on the first live sync.
- Dashboard deploy gotcha: set the function NAME before the first deploy, otherwise the slug is random (rapid-worker).
- ECO4/GBIS is a trade filter ('eco4'). Live fn and repo in sync as of PR fix/broadcasts-exclude-internal.
- Resend webhook for broadcasts is a SECOND Resend endpoint, because nurture-resend-webhook ignores non-nurture sends.

## History/scheduled/stats (09-22, branch feat/broadcasts-history-stats)
Sent list pages, scheduled sends editable until 2 min before, broadcast_stats view (migration 20260922150000). The repo's edge fn now stamps email.delivered, but the LIVE fn doesn't yet. Hand Charlotte the full fn to redeploy at the Resend-webhook step (she prefers the whole file pasted as text, not line edits).

Drip guardrails (same branch): sends over 50 people are capped at 60/h, and a DAILY_CAP of 500 applies across all broadcasts (rolling 24h), mirrored in broadcastFilters.js. These live only in the repo fn until the final redeploy. Open question: which Resend plan (the free plan is 100/day).

## Remaining list (as of 09-22)
1. DONE 09-22: ECO4/GBIS trade (86), heating-engineer fix, staff/test + no-contact exclusion (keeps charlieharris@installrhub.com). The list is now 524.
2. Charlotte: add a SECOND Resend webhook to `https://ozmyjrzleejbqxqphbut.supabase.co/functions/v1/broadcasts?action=resend_webhook` (opened, clicked, bounced, complained), and put its whsec_ secret in Supabase as BROADCAST_RESEND_WEBHOOK_SECRET.
3. Tickbox REVERSED 09-22: no tickbox, privacy line only, no n8n work. The live edge fn now has delivered + drip caps (redeployed 09-22), and the Resend webhook + secret are set up; signed events are unproven until the first real send.
5. Clients missing from GHL (Prime Energy, RSSS, Legra deleted in GHL; National Eco = lead-only ECO4, never in GHL): Charlotte chose to LEAVE them (09-22). They're simply off the mailing list, and their companies rows stay untouched.
6. Live fn == main as of 09-22 (full redeploy after the no-consent-gate PR). Not yet exercised live: an actual send (test email, SMS test, launch, drip, unsubscribe round-trip). The first real test send is the check.

## SMS tracking (09-22, hub feat/broadcast-sms-tracking + site feat/sms-tracked-links)
broadcast_links + broadcast_link_click RPC (migration 20260922190000), site /t/<code> -> api/t.js, and a tick polls GHL for SMS delivery. Order: SQL, then site PR, then hub PR, then full fn paste. The "Thanks, InstallrHub" SMS ending is GHL's signature setting, not ours.
THEN: give Charlotte SQL to delete the 3 test broadcasts (Test, Test (copy), SMS test) plus their data (cascade from broadcasts), BEFORE the nurture audit.

## Shared email editor + nurture tracking (09-22, feat/rich-email-editor)
EmailBodyEditor (Quill, inline-px sizes, link, Insert field + /; emails with custom styling open in an HTML view) is used by BOTH the Broadcasts and Nurture editors. The nurture editor got an unsaved badge + beforeunload + a stale-tab check (latestStepUpdate) before Save steps. nurture_sends.delivered_at (migration 20260922210000) is stamped by the broadcasts fn: its Resend webhook covers nurture emails, and the tick polls GHL for nurture texts. Nurture SMS click tracking is NOT done (it needs nurture-run in Serafim's repo). Order: SQL, then PR, then full fn paste.

## Calendar links (09-22)
calendar_events + calendar_event_public RPC (migration 20260922230000). Site /cal/<slug> is a page with Google/Apple/Outlook/Outlook.com/M365 buttons, and /cal/<slug>.ics (api/cal.js, branch feat/calendar-links). The Hub has an Emails > Events tab (feat/calendar-events). Seeded webinar-oct2026. LIVE 09-22 and verified: page, .ics, and a bad slug goes to the homepage. The editor has a 📅 Event button (both editors) and the Overview counts real opt-outs (7). The swap SQL for emails 1/8/11 (scratchpad webinar/calendar-swap.sql) was handed over. The daily cap stays 500 (Charlotte). broadcasts fn v10 is live with nurture delivered.

## NEXT (Charlotte asked 09-22, after the end-to-end test)
Also add the same 'Insert field' merge-tag buttons (MERGE_FIELDS in broadcastFilters.js: first name, company) to the nurture editor. Charlotte asked for core field mapping in both. Audit the NURTURE system: are sends, opens and clicks actually tracked (nurture_sends stamps via nurture-resend-webhook), are the email contents right, do the links work and get tracked (bare URLs not linkified? same bug as broadcasts), and does the unsubscribe work end to end.

## Status 09-22 end of session
Everything merged + live. Handoff PR docs/handoff-2026-09-22-broadcasts pushed. When it's merged: `git worktree remove` the scratchpad ma-bc, `git -C marketing-hub/marketing-agent pull --ff-only`, then check `git status --short` is empty and `git worktree list` shows only main. I'm the last session.

## Handoff instructions (from the audit + CREW Google sessions, 09-22)
- Commit only my own files: work in my worktree (scratchpad ma-bc) and never `git add -A` in the shared tree.
- Build the doc edit on a branch from FRESH origin/main (fetch first; the CREW Google handoff PR docs/handoff-2026-09-22-crew-google may have merged). ADD a new section at the top of .claude/docs/current-handoff.md and a new entry at the top of .claude/docs/CHANGELOG.md. Do NOT edit or replace the existing 2026-09-22 entries (audit resends, CREW Google). Check `git diff` shows additions only.
- Remove only my own worktree (ma-bc) once my PRs are merged. Leave marketing-hub/ma-audit alone.
- Audit session (blc-39) CLOSED 09-22: ma-audit removed, PRs merged, two audit entries at the top of current-handoff.md + CHANGELOG.md. Add mine ABOVE them. I am now the only open worktree (ma-bc), so I finish LAST: after my PRs merge, run the pull --ff-only + clean-tree + worktree-list check.
- main can move without a PR (the Gas Worx blog-sync bot commits to main): always fetch before branching.
- If I finish LAST: once all handoff PRs are merged, run `git -C marketing-hub/marketing-agent pull --ff-only` on main, then confirm `git status --short` is empty and `git worktree list` shows only the main tree.

Related: [[installer-lead-flow-and-mailing-list]]

**09-22 later:** Emails > Overview Performance section LIVE (#928, SQL fn email_performance run). Booking credit = opened/clicked, then booked 1h-7d after send (30d for close), latest message wins. Plain last-touch gave 59 (instant site bookings after "No Booked Call" email 1), this rule ~15. ma-bc worktree removed; final pull of main left to the Erin onboarding session.

**09-22 evening:** fn broadcasts v12 LIVE (#929-#933 merged): booking_attribution reads GHL lastAttributionSource UTMs per booking (15/tick), broadcast links auto-tagged utm_content=bc-<id8>-s<n>, seed charlieharris@installrhub.com gets every broadcast first + others held 30 min (is_seed), per-broadcast nurture exit (exit_rules.nurture_sequences), exit checks fail closed, nurture "Send all to me" (action nurture_test). "Likely" credit = click only and never on a tagged booking (30d: 15 -> 0; honest tracked = 1). 6 webinar broadcasts scheduled 09-23..10-05, all with Webinar-Oct2026 exit ticked. TODO: check Webinar Email 1 exits after 09-23 10:16 UK launch (Manjeev/Asad excluded, seed first); Charlotte to run cleanup SQL (delete Test broadcast 1b47294d + test nurture enrolments) after her test SMS.

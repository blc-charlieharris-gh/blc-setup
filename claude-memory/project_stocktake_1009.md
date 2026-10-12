---
name: project-stocktake-1009
description: "Agreed but unbuilt items queued for the 10-09 stock-take (before the Creative Testing audit): drafts box, Status walk-through, 7 build questions"
metadata:
  node_type: memory
  type: project
  originSessionId: 6a33dffe-7abe-450c-b4b9-bfc677a26314
  modified: 2026-10-09T15:23:07.245Z
---

**STATUS 10-10 07:10: plan items 1+2 ALL LIVE (#1639-#1660, SQL run, 5 fns deployed, old-tab guard raised, placements backfill started). Next: step-6 click results, decisions (cost of supply by surveys a/b/c, one name-match rule + unmatched warning, spam complainers), final live check, then Goals audit. Source: marketing-agent current-handoff.md (docs/handoff-2026-10-10).**

Charlotte 2026-10-09: before resuming audits, take stock. Bring every page audited so far fully up to date (a retro of everything since the last retro: Hub #1639-#1646, site #202/#203). Agree the audit plan with her BEFORE running it. Then the Creative Testing audit.

**AGREED PLAN to be "up to date" (Charlotte 10-09):**
1. Retro fixes: A (merged), B1 (one rule each), B2 (access/security), B3 (smaller agreed items), then C–G from retro-2026-10-09.md.
2. Earlier agreed items:
   - automatic notes out of Messages;
   - placements;
   - the remaining typed-name rules (show the numbers impact first);
   - one Status ack + 7-day expiry;
   - Cost of supply split between installers;
   - "Delete from Library too?".
3. A live verification pass, plus the Serafim list summarised.

THEN write the handoff. The next session resumes the audit: the Goals audit first, then the unaudited pages. Only stop Charlotte for SQL, deploys, merges or decisions.

Agreed, not built yet:
- **One "Drafts for approval" box** on creative tasks, replacing the separate storyboard and rough-draft boxes. A draft can be a storyboard or a rough draft, either is fine, with as many rounds as needed. "Sent back" shows the feedback and the next step in the box, so the maker is never stuck. **Video: a draft is REQUIRED before final upload.** Image: optional. Carousel: optional (confirmed 10-09). Being built as feat/drafts-for-approval. Existing storyboards and rough drafts show as earlier rounds. Trigger: Erin was stuck on 10-09, because videos have no "Skip storyboard"; her workaround is "Add frames" (it accepts video).
- **Retro 10-09 decisions (Charlotte's answers):**
  1. Messages stay readable by all marketing staff. Not private; it's all work.
  2. Creative Testing editing is marketing-only.
  3. Make the public buckets staff-only: fix.
  4. Confirm before switching "Track this campaign" off: yes.
  5. Tech not set: fix, but only for LIVE campaigns (7 need it; old ones use the client's tech).
  6. DND on client service emails: warn, don't block (11 client-linked contacts have some DND).
  7. One sign-up rule = the campaign's "What is it for?". First point of entry wins: a lead who later signs up for the webinar stays a lead.
  8. Text opt-out skips texts only: fix.
  9. Rename "Ideas tested" to "Tasked / made", with hold winning over tasked.
  10. Lock approvals in the DB: fix.
  11. Structured History kind: yes.
  12. She didn't follow it; explain again (369eafff Image → Video).
  13. Delete creative_inspo.
  14. Move the hardwired numbers to Parameters.
  15. Green Tide = our PPS/PPL brand, with no Green Tide installer. KCG Links IS Links Energy. Cost of supply needs re-explaining under that model.
- **Follow-ups agreed 10-09:**
  - Upload file types follow the task type: image/carousel tasks accept images only; video tasks take only video finals, while drafts/storyboard accept images or videos.
  - Cost of supply lists real clients with their code-linked spend, plus one "Green Tide shared pool: £X" line.
  - Status Lead flow: 3 rows (instant forms, website from Meta ads, our website everything else), with the source shown only when something is missing.
  - Tech on live campaigns: RESOLVED (checked 10-10). Every live client's campaign gets its tech from the client's own setting; only InstallrHub's 3 (B2B, no heat pump/solar) have none, by design. The 10-10 handoff's "set tech on 7 campaigns" line is stale.
- **Test calculator is per CAMPAIGN** (Charlotte 10-09, after batch A): pick the client, then the campaign if there's more than one, and use THAT campaign's daily budget and cost per lead alone. Only Leads/Sign-ups campaigns are pickable. This supersedes batch A's client-level budget. Confirm the per-campaign CPL wording with her before building.
- **Goals "Joined a sequence"** has its own staff-domain test rule plus a DB copy. It must use the ONE shared test rule (single source of truth). Build it in batch B; she insisted.
- **Archived client link page** (agreed 10-09, build after batch A): an archived client opening their old page link sees a friendly closed page with the InstallrHub logo: "This page is no longer active. If you'd like to talk about anything to do with your brand package with InstallrHub, get in touch." plus a Contact us button to installrhub.com's contact page. The wording is always "brand package", for every client, not tailored. Nothing private shows.
- **Status Lead flow:** keep it a LOSS DETECTOR, not a sources tracker. Show which route or source is broken only when something goes missing.
- **Serafim list (held until the end of the audit; Charlotte wants it rechecked and summarised then, not sent piecemeal):**
  - the app half of the short ad id fix (_serafim/20261009400300);
  - retainer leads carry only retainer_client_name, so n8n/GHL should write company_id;
  - 11 non-admin staff can read Meta lead PII (is_admin vs hub_role);
  - wrap the client_onboarding_page trigger in an exception handler (it runs inside register-installer);
  - confirm sms_suppressions do_not_contact rows act as STOP;
  - an index for the lost-lead phone/email lookups.
  Full findings: .claude/docs/hub-audit/retro-2026-10-09.md.
- **Typed-text rules still in use** (found 10-09, not fixed; see [[feedback_never_classify_by_typed_titles]]):
  - **Read at view time, so they change all history:**
    - Performance totals match contact_source = landing_form_source.
    - settled_rates treats sign-ups by contactSource.
    - Tech is guessed from campaign names (SQL and Hub).
    - Sources and InstallrHub KPIs use contactSource regexes.
    - Find missing leads matches the GT form_name.
    - Lead flow knows clients by retainer_client_name.
  - **Written to stored data:**
    - marketing-sync-meta writes tech from campaign/ad set names (rewrites the last 14 days each sync).
    - Nurture picks its sequence from contactSource (new enrolments only).
    - Broadcasts writes booking_attribution and nurture exits from calendar-name regexes.
    - A one-off 10-02 backfill set lead_role from 'IH - Webinar%' names.
  - Each needs the correct-data impact shown to Charlotte before changing it.
- **Goals audit notes (10-09; she wants a proper audit later, not fixes now):**
  - The webinar goal's closes step counts ALL InstallrHub closes in its dates (6), not webinar registrants (only PlumbGuy's).
  - Close totals are too low: no "closed won" is logged for My Energy Care or Southernsolar, and 5 prospects (Zoe English, Legra, Renewables Sales & Service, Eco Solutions, Harvard) sit in "closed" with no win.
  - 56 Discovery/Demo calls aren't marked shown or no-show, so the show rates are unusable.
  - Text sign-ups are counted as organic (goals.js:104).
  - "ERC" doesn't exist in the code.
  - "Closes from ads" was verified correct (30 days: 9 closes, 2 from ads).
  - Only the "6 of 0" label is being fixed now (fix/goals-of-label).
  - Point 5 (credit a booking to the latest sign-up) is still to explain.
  - **Agreed for the audit:** goals (especially one-off) link to the campaigns whose spend she wants tracked, and spend is pulled automatically from them. Each step shows its cost (cost per sign-up, booked call, close…). A "Money collected" £ step gives ROAS = money ÷ spend. The "6 of 0" label is already fixed and merged (fix/goals-of-label).
- **Placements (agreed 10-09):**
  - Name the two fields clearly everywhere: "Ad placement (Meta)", from utm_medium={{placement}} on landing-page ads, and "Site button (our website)", from ih_place. Each lead type is only checked for the fields it can have.
  - Build the missing daily Meta placement breakdown sync (ads_insights_breakdown_daily has 0 rows; it's the empty Performance Breakdowns tab), with a backfill of months.
  - Store Facebook vs Instagram (the Graph lead `platform`) on instant-form leads, with a ~90-day backfill.
- **Removing a design from a task** that was only ever on that task should offer "Also delete it from the Library?". Example: Erin's two "Speach Clip" uploads on 10-09 stayed in the Library. That one still needs her OK; it was offered, not yet agreed.
- **Messages = staff talking to staff only** (agreed 10-09): a person writing to a person, from a task comment, an action note, "Ask about this" or a direct message. Anything the Hub or a client triggers (client approved or rejected ads, auto-made tasks, reminders) goes to Actions, the client card and the task (new/unread on the task card), NEVER Messages. Example of drift: "Redo rejected ads: Elect" landed in her Messages. In the stock-take: list every automatic hub_task_flags writer with where it goes now vs where it should go, agree the list with her, then move them all and clear the old automatic notes out of Messages (they stay on tasks and client cards).
- **Status walk-through with Charlotte**, including her idea of AMBER when a LIVE client's ad account spends £0 for 24h (today that shows as a plain "Spending: No", never red unless Meta reports a payment or delivery fault). Decide it in the walk-through; maybe also a client-facing explanation.
- **Status walk-through:** what each section checks, and what is real vs a false alarm; reword anything confusing.
- **Build follow-ups she answered:**
  - one Status ack (merge "I've checked" into Mark handled);
  - Mark handled expires after 7 days for item-less problems;
  - Sign-ups campaigns get the untested-campaign card;
  - Cost of supply splits AS-code spend across installers sold the same survey;
  - name paused clients on Actions cards;
  - Goals: credit a booking to the latest sign-up. She doesn't understand this one yet, so explain it during the Goals KPI card review, which she wants before Creative Testing.
- **Helix (a real client, "ready to go", not live yet):** its 2 leads in lead_intake_events (to 27 Aug) arrived with NO ad id (utm_content), so they can't be credited to ads. Before go-live, check its lead route sends the Meta ad id.
- **Greener and Outlook:** confirm the booking phone numbers in GHL before they go live. Don't change them now.
- **Record Meta leads on arrival** (mirror_to_ingest): this belongs to the GHL-removal task, not now.

Related: [[feedback_confirm_understanding_before_fixing]], [[project_marketplace_client_model]].

**10-10 later:**
- **Audit order (Charlotte 10-10, supersedes the README line):** skip the rest of Clients (Funnels, Analytics, Reports, Testing are mostly unused; come back later to make them useful). Next audit = **Crew** (Workspace, Website builds, Logo/Google/Social/Content), "the meatiest after Creative Testing". Then InstallrHub (KPIs incl. Goals, Sales Model, Sources, Blog/Email), Admin, Global; Analysis area plan; Serafim list last.
- **Calendar IDs:** build ONE Parameters setting "Calendars: what each is for" keyed by calendar_id, used by broadcast goals, nurture exits, booking attribution, email_performance demo/discovery, onboarding call. Charlotte will classify the calendars when we reach it in the audit (or sooner if the "your call is booked" nurture sequences next week need it). Calendars: Discovery yEw664fX6up5dLb7TL75 (was named "InstallrHub Demo"), Demo dcUoRKkUzUQV3rpy8IQw, Onboarding o3IPDucRtZtsioEQDiNB, Kornelius or7oKcp7yZcdHRxtS0bw + Y53GkLtIG9JWwuvGsy7p, CallBack 58bEOeqNCwiz7iN10Kzr, Brad 4JD14FRYTRz65CnboEnf, Brad catch-up 6ggFBGtzBNRH7ctKmw1l.
- **Status Lead flow redesign APPROVED:** one line per client (tick "all leads arrived (N from Meta forms)" / cross "N Meta form leads didn't reach us -> see who"), drop the "Not from a Meta ad" row and the columns from the main view; click a client for the full numbers to see and reconcile; website forms get the same one line.
- Library catch-up switch: remove once Charlotte says older-ad linking is done.

---
name: project_next_session_pickup
description: "Next-session pickup after 2026-07-23: read current-handoff.md. Next big task = Phase 2 InstallrHub onboarding (discovery-first). Waiting on Serafim's campaign_creative_cpl re-bound (run the verify query when he confirms)."
metadata: 
  node_type: memory
  type: project
  originSessionId: aa2b40e6-5935-4d29-9645-f66f9d2bc770
---

# Pickup after the 2026-07-23 session (START HERE)

Read `marketing-agent/.claude/docs/current-handoff.md` (2026-07-23) first, it's the canonical state.
14 PRs shipped: Design Performance rebuild, Clients onboarding home (/clients), and a full DB-load
hardening pass (rpcTimeout + rpcCached + refire fix) after an app.installrhub saturation incident.
- **Next big task:** Phase 2 = onboard InstallrHub via discovery-first flow. See
  [[project_clients_onboarding_home]] + `current-plan.md`.
- **Waiting on Serafim:** re-bound `campaign_creative_cpl` (unbounded, root cause of the incident). When
  he confirms applied, run `SELECT pg_get_functiondef('campaign_creative_cpl'::regproc);` to verify it
  reads `ad_performance_windowed`. Also: app test-lead filter (165/169), OPEN 2, OPEN 4 (Breakdowns tab).
  See [[reference_marketing_rpc_guards]] + `serafim-pending.md`.
- The 2026-07-22 items below (nurture, blog, Arktek) are DONE (Arktek committed #310, nurture source
  synced #314). Kept for reference.

# Pickup after the 2026-07-22 session

## SERAFIM: items for next session (nurture edge fns)
1. **Instant first-send: RESOLVED 2026-07-22 via cron.** Serafim changed `nurture-run` to run EVERY
   MINUTE (was every 20 min), so a 0-delay resource email now sends within ~1 min of enrolment. Did
   NOT use the enrol-kick approach. **OPEN sub-question for Charlotte:** the 08:00-20:00 London send
   window still applies, so an out-of-hours resource request waits until 08:00. Decide whether the
   Resources (requested-content) email should bypass the window and send at any hour, if yes, small
   follow-on for Serafim (send the first step of a funnel sequence even outside the window). If
   overnight-hold is fine, nurture is fully done.
2. **`nurture-run` prospect→client exit (QUEUED, no urgency).** Exit enrolments where the prospect has
   `installer_prospects.converted_company_id` set. Spec: `docs/serafim-nurture-conversion-exit.md` +
   `.claude/docs/serafim-pending.md`. No-op until sequences run at scale, so lowest priority.

Older Serafim items (unverified, reporting/cosmetic, NOT urgent): OPEN 2 (lead-only clients show 0
leads on Tech/Destinations), OPEN 4 (`ads_insights_breakdown_daily` empty), OPEN 5 (`crew_seed_audits`).

## Serafim DONE + verified this session
`nurture-enroll` **customData fix** (deployed + verified): GHL nests webhook custom data under a
`customData` object, the fn now merges it up before reading `funnel_key`/`email`/`ghl_contact_id`.
This unblocked enrolment. He also fixed the `NURTURE_ENROLL_SECRET` mismatch (now `gt_webhook_s3cr3t_2026`).

## Nurture Resources funnel: LIVE end-to-end (proven 2026-07-22)
Full chain works: site form → n8n (creates GHL contact + tag) → GHL "Resources Funnel" workflow
(webhook action, `X-Nurture-Secret` header + custom data) → `nurture-enroll` → enrolment →
`nurture-run` → Resend send. Verified an enrol landed and a send fired (`sent:1`). Debug trail that
cost the session: (a) GHL tag-added trigger does NOT fire on n8n API-added tags reliably, fixed by the
trigger; (b) secret was `X-Webhook-Secret` not `X-Nurture-Secret` + wrong value; (c) GHL nests custom
data under `customData` (the real blocker, Serafim fixed). **Email merge field is `{{first_name}}`
(and `{{company}}`), NOT GHL's `{{contact.first_name}}`** which is only for the GHL custom-data side.
Resources = a SINGLE resource-delivery email (not a drip). See [[project_greentide_inhouse_forms]].

## Blog YouTube embeds: FIXED + merged (2026-07-22)
Root cause: Quill editor silently dropped pasted YouTube iframes on save, so 0 of 29 posts ever held
an embed (not a publish-side strip). Two merged PRs: (1) marketing-agent `RichTextField.jsx` adds a
video toolbar button + handler (URL or Share→Embed → video blot → persists as `iframe.ql-video`);
(2) site-installrhub `api/blog.js` adds responsive `.post-content .ql-video` CSS (public page doesn't
load Quill's stylesheet). Public renderer injects body raw, no CSP, so it renders. **First-task next
session: test it** (add a video to a post, confirm content now contains `ql-video`), then re-add
videos to posts that were meant to have them. Public blog is `site-installrhub/api/blog.js` (separate
repo from the editor).

## Arktek: DONE + LIVE (2026-07-22 updates)
Client confirmed: (1) address = `Jupiter Centre, North East Business & Innovation Centre, Sunderland,
SR5 2TA` (dropped the old "Unit JC9"/"Wearfield"; SR5 2TA settles the old 2TA-vs-2TJ); applied in
`build-pages.mjs` (schema/footer/registered-address) + rebuild + swept 16 hand-maintained policy
pages. (2) Finance = boilers, solar, solar+battery, NOT battery-only; the battery page's band is the
SOLAR+BATTERY offer, correctly kept, so NO finance change needed. Deployed live via `vercel --prod`
+ re-alias (the `016-arktek` folder is now linked to the Vercel `arktek` project, so future deploys
are just `vercel --prod --scope blc-promotions` from that folder + re-alias `arktek-installrhub`,
which stays pinned). Uncommitted: today's website-factory rebuild (build-pages.mjs + regenerated html)
is deployed but NOT git-committed. See [[project_website_delivery_workflow]].

## Parked from before
Green Tide budget decision (SORTED per Charlotte, no action). [[project_dashboard_leads_card_is_meta]]
RESOLVED (card reads CRM now). CREW Serafim items ([[project_crew_serafim_open_items]]).

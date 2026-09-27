---
name: project_crew_socials_engine
description: "CREW social posting engine: fixed + shipped 2026-07-31 (#470) but NEVER YET RUN; paused pending Serafim's data hygiene, resume with the 3 steps below"
metadata: 
  node_type: memory
  type: project
  originSessionId: 2d7508d9-d165-4c26-9ed8-fe15e093f40f
  modified: 2026-07-31T11:13:58.083Z
---

The CREW Socials tab (Crew > client > Socials) generates a 30-day Facebook content plan and publishes
to the client's page. **Engine repaired and deployed 2026-07-31 in #470 (main `91f4a93`), but it has
still never produced a single real post.** Charlotte paused the first live run because Serafim was
doing top-level data hygiene; resume only when she gives sign-off.

## What was wrong (all three fixed, all had shipped broken)
1. **The AI had never once run.** `api/crew-generate.js` asked OpenRouter for
   `anthropic/claude-haiku-4-5`; that slug does not exist (OpenRouter uses a DOT). Every call 400'd,
   the error was swallowed, and `buildDemoPlan()` was silently substituted. HQ Group's "brief" in
   prod is the verbatim hardcoded demo string. Now `anthropic/claude-opus-5` with
   `reasoning: {effort:'medium'}`, overridable via `CREW_WRITE_MODEL`, and failures now THROW.
2. **"Approve & schedule all" scheduled nothing**, it only flipped a status field in the jsonb; there
   is no cron for CREW. Now books each post with Facebook's NATIVE scheduled publishing
   (`published=false` + `scheduled_publish_time`), so Facebook holds and fires it, no cron needed.
3. **Unschedule / Delete only changed local state**, so a "cancelled" post still went live. Both now
   DELETE on the Graph API first.
Also: post types clamped to image|text (reels/carousels/polls were generated but are unpublishable),
`client.links` wired (was dead code), Instagram publish path added but UNTESTED (no crew client has an
IG account connected, and IG cannot be scheduled via the Graph API).

## To resume, in order
1. Run `scripts/seed-installrhub-intake.sql` (on main). Verified safe: single-row UPDATE of
   `crew_clients.intake` for `installrhub`, currently NULL, no triggers on the table, only
   `crew-generate` + `crewBrain` read it, does NOT touch `status`. Undo: `set intake = null`.
2. Charlotte, in the hub: Crew > InstallrHub > Socials > Run SocialScore audit > Generate the brief >
   review > Create the posts.
3. Claude reads the captions out of `crew_clients.content_plan` and shows every one BEFORE anything
   publishes. Charlotte's standing instruction: show the caption first, publish nothing unprompted.

## Facts worth not rediscovering
- InstallrHub FB page `616455654886195`, 216 fans, reachable by the system token (non-expiring
  SYSTEM_USER, has `pages_manage_posts` + `instagram_content_publish`). Nothing blocks publishing.
- No crew client has an Instagram account connected. All `ig_id` / `ig_username` are null.
- **Images are base64 inside the `content_plan` jsonb.** HQ Group's row is already 2.26 MB from ONE
  image, and every per-post edit rewrites the whole blob. Migration
  `supabase/migrations/20260731090000_crew_social_images_bucket.sql` fixes this (public-read
  `crew-social` bucket, authenticated-staff writes via a new `has_crew_access()`), but it is
  **Tier-2 and still needs Serafim's review + apply**. Until then `generateImage` falls back to
  inline base64: fine for Facebook, blocks Instagram.
- **TWO Tier-2 migrations are queued for Serafim, not one**, both held until Charlotte says go:
  this one (`...090000_crew_social_images_bucket`) and another session's funnel constraint change
  (`...100000_installrhub_forecast_funnel`, on local branch `fix/testing-crash-and-nonenergy-funnels`,
  unpushed as of 2026-07-31). Timestamps don't collide and ordering is correct.
- `crew_clients.intake` is now only populatable by the onboarding engine, see
  [[project_intake_forms_retired]] and §6a / B11 of `docs/serafim-onboarding-handoff.md`.
- Full write-up: `docs/serafim-crew-socials-2026-07-31.md`.

See [[feedback_silent_fallbacks_hide_dead_features]] for the pattern all three bugs shared.
Related: [[project_crew_workspace]], [[project_crew_next_session_pickup]].

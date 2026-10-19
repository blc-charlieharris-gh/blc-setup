---
name: project_website_rulebook
description: "The website rule book (10-14) is for building premium NEW client sites (research, design, copy), not auditing old ones; SWH + Arktek are the design benchmark; Elect is the first build"
metadata:
  node_type: memory
  type: project
  originSessionId: 3f881c5f-f0a6-420d-b97b-044f8e7f15e0
  modified: 2026-10-14T16:07:10.278Z
---

Charlotte 2026-10-14: "this rulebook is about creating premium, well researched, visually stunning, strong copywriting websites for our new clients going forward". The audit/broken-link checks are only the last safety net, not the point. Older live sites are out of scope.

Decisions: design benchmark = SWH Electrical and Arktek ("premium in design", will change); research = the client and THEIR AUDIENCE (so we write the site the best way for them with the right info), not competitor or keyword research; Hub build-list ticks blocked until their checks pass, with a reasoned "sign off anyway"; first build to use it = Elect (Jones and Baker nearly done on the old process). Plan written as .claude/docs/current-plan.md (portal audit plan moved to plan-portal-audit.md), then a "build a client website" Claude skill, then Hub buttons.

Plan merged 10-14 (03a7bec0, .claude/docs/current-plan.md, 7 stages). Charlotte took the plan's recommendations as they stand ("will do for now, when we work on Elect's site we can improve it as we build"): no self-rated stars in schema, Crew/Clients tick can sign off anyway with a shown reason, in-flight jobs (Jones and Baker) exempt, sticky phone call bar standard, rule changes via code read in the Hub, Elect in the Elect Group look. Refine rules during the Elect build.

Status 2026-10-15: Stages 1, 2, 3 and 6 (6a false passes, 6b new checks + coverage test) DONE and merged; 90+ rules incl. Trustpilot link-only, favicon/share card, indexing (thank-you/404/legal), UK GDPR section, header (DES-18), motion feel (MOT-02), same width (DES-17), every logo a premium SVG drawing (BRAND-02, checks logo_svg/logos_svg/favicon_drawn; Elect's logos still raster, parked by Charlotte). Stage 4 built 10-15 (branch feat/website-rulebook-stage4-1015, 265732b6): 12 design checks inside the existing site check (api/_audit/design.js, staff-only, run on Push audit) + Copy design brief on the job's Brief; Charlotte doesn't want the mechanics explained, just 'sorted like the rest'. ALL 7 STAGES MERGED 10-15 (Stage 4 #2006, Stage 5 907887e1 + SQL 20261015192900, Stage 7 skill .claude/skills/build-client-website). Rollout started: Jones and Baker done 10-15 (381e5c47, preview jones-and-baker.vercel.app, 0 blockers; Charlotte to Push audit, sign off steps, send preview). Next: Gas Worx, Stage 7 (skill), then roll out to sites in build (Gas Worx gaps listed in known-issues), then Hub site design for Erin ([[project-rulebook-rollout-then-hub-design]]).

Status 2026-10-19 (blc-83): J&B brought fully to the rule book and the new job flow; preview published and emailed for approval 10-19 (With the client), waiting on the client (photos, form key, accreditation, VAT/ICO numbers). Website job now: plain questions, Your review list (step 6), Run audit, step 7 Publish (portal only) then Email the client moves the stage, Crew test form key until theirs, Add to logo bank. Next: Helix as Charlotte's own test run of the kit route (zip route never used live yet).

**Why:** websites kept needing rework and gaps were found late; one rule book the Hub, GPT copy prompts and the skill all read stops drift.
**How to apply:** frame website work around research, positioning, design, imagery, copy, conversion first; checks last. Related: [[project_crew_deliverables_to_skills_to_hub]], [[feedback_gpt_writes_all_content]], [[feedback_never_swap_client_web3forms_keys]].

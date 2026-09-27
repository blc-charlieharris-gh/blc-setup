---
name: project-swh-website-imagery-pass
description: "SWH Electrical site imagery pass plus solar/battery/EV page split (2026-09-03); committed via PRs #743-745, merged to main"
metadata: 
  node_type: memory
  type: project
  originSessionId: 11297753-1e82-475a-a9e8-3feccea1ffa2
  modified: 2026-09-04T13:00:23.740Z
---

Two rounds of work on the SWH Electrical Solutions client site (`website-factory/clients/swh-electrical/`) in one session, both steered live by Charlotte as she reviewed pages.

**Round 1, imagery.** Added a real photo band to pages that had none (previously only the homepage and why-swh.html had any photography, matching the site's own meta.json pre-launch note that imagery was still placeholder). Reused unwired stock already sitting in `assets/` (`electrics.webp`, `heating.webp`, `heat-pump.webp`) on their matching service pages, sourced Pexels stock for the rest. Charlotte then asked to remove the new bands from the homepage, contact.html and faq.html (felt the homepage already had enough, didn't want them on those two utility pages), so those are back to their pre-session state. get-a-quote.html kept its band. Added 3 more bands to the (then still combined) solar page, one per sub-topic, since she asked for "a few" images there.

**Round 2, split the solar page into 3.** Charlotte then flagged unprompted that the combined solar/battery/EV page was too long, roughly 3x any other service page. Asked whether to split into pages, trim the content, or leave it; she chose split. Now `services-solar.html` / `services-battery.html` / `services-ev-charge-points.html`, filenames matched to what `sitemap.xml` had already stubbed out (a stale leftover from the original template fork that turned out to be the right naming to use). See [[feedback_swh_solar_split_mechanics]] for the how-to if this pattern comes up again, e.g. if services-electrical-installs.html ever needs the same split.

**Real photos.** The user then shared a client Google Drive folder of solar install photos and drone footage, mostly commercial work, a handful of genuine home installs. Swapped the best one in (`solar-installer-real.webp`, an SWH-branded engineer fitting roof-batten brackets) replacing a Pexels stand-in on the solar page. Battery and EV pages still use Pexels stock since no real battery/EV photos existed in that folder.

**Why:** Charlotte asked to add imagery across the whole site using stock photos for now, wanted to see where images look best on each page, then course-corrected per-page as she reviewed, then asked for the solar page split once she saw how long it had become.

**How to apply:** Full detail is in `website-factory/docs/CHANGELOG.md` under 2026-09-03. Update 2026-09-04: this round IS now committed, 3 PRs (#743, #744, #745) merged to `main`. Things that still matter:
1. `SERVICE_LINKS` in build-pages.mjs is the single source of truth for the nav dropdown and mobile menu (both render from that one array).
2. Correction (verified 2026-09-04): the `<footer>` services/company/legal columns ARE centrally sourced from the shared `FOOT` constant in build-pages.mjs, and DO auto-propagate to the hand-authored files (template.html, why-swh.html, terms.html, privacy.html, cookies.html) via the nav/footer sync loop at the bottom of build-pages.mjs, just run `node build-pages.mjs` after editing `FOOT`. No hand-editing needed for footer changes; this memory previously said otherwise, that was wrong (or true only for a stray "ben" card / stand-alone CTA link that sits in hand-authored BODY content outside the synced nav/footer regions, which does still need a direct per-file edit). See [[project_swh_legal_compliance_cleanup]] for a worked example.

Also fixed, unrelated to the imagery work: a broken `solar-home-graphic.png` reference in build-pages.mjs (only the `.webp` exists) left uncommitted by the prior session's in-progress "sharpen the real photos site-wide" work, reverted to `.webp` since it was 404ing on the live solar page. See [[project_worktree_handoff_tagmodal_thumbnails]] and [[feedback_shared_scratch_docs_get_clobbered]] for the general pattern of picking up mid-session state left by another Claude session on a shared tree.

See [[feedback_website_factory_manual_deploy_gap]] for what still has to happen before this is visible on a real domain, client sites don't redeploy on merge by default.

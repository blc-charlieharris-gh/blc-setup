---
name: project_retrofit_seo_audit_pending
description: "Retrofit Group website SEO audit — deeper audit completed and delivered 2026-09-03 (sitemap, schema, image weight, orphan page, og:image dims)"
metadata: 
  node_type: memory
  type: project
  originSessionId: cbb3d71a-1e61-43c2-99e7-373f106d1321
  modified: 2026-09-03T14:30:51.210Z
---

Cammi (Retrofit Group client contact) asked 2026-08-26 whether retrofit-group.com was custom-built. Charlie replied confirming it's a custom hand-coded static site, and pitched a deeper "internal SEO auditing process." On 2026-09-01 Charlie told her he'd "run the full SEO audit this week" (unconditional promise, not contingent on her replying yes). On 2026-09-03 Charlotte asked for a genuinely thorough (not just eyeball) pass since the first quick audit had missed things, and it was completed and delivered same day.

**Site location:** `marketing-hub/marketing-agent/client-sites/retrofit-group/site` in the `marketing-agent` repo. The whole `client-sites/` directory is **gitignored** (confirmed via `git check-ignore`), so this is a local-only working copy with zero git involvement, editing it never touches the shared repo state other sessions are using. See [[reference_retrofit_group_deploy_is_zip_not_git]] for how it actually ships (corrects an earlier wrong assumption in this file that pushing deploys it).

**Findings from the 2026-09-03 full audit, ALL FIXED and delivered:**
1. Sitemap was missing 8 live, nav-linked service pages (bathroom-fitting, ev-charging, electric-storage-heaters, funding, garage-conversions, gas-boilers, insulation, kitchen-fitting) — added.
2. Zero structured data anywhere — added LocalBusiness/HomeAndConstructionBusiness JSON-LD to all 22 pages, Service schema to the 11 service pages, FAQPage schema (11 real Q&As) to faq.html.
3. **New find, not in the original quick audit:** `warm-homes-plan.html` was a fully-built, sitemapped (priority 0.9) page with zero internal links pointing to it anywhere on the site — both homepage "Register Interest" buttons actually pointed to a shorter `funding.html#warm-homes-plan` section instead. Fixed by repointing just those 2 hrefs (Charlotte explicitly wanted zero wording/content changes, only the destination URL).
4. Image weight: 22 images recompressed in place (same filenames/formats, no markup changes) via Pillow, quality=78 progressive JPEG + 256-colour palette PNG quantization (`Image.FASTOCTREE` method, required for RGBA). 7.8MB → 3.2MB (59% smaller); `og-image.png` alone went 2.0MB → 146KB. Visually verified lossless via headless-Chrome screenshots.
5. `og:image:width`/`height` meta tags claimed 1200×1200 on 19 pages; actual file is 2384×968 — corrected. Could have caused Facebook/LinkedIn to mis-crop the link preview.
6. privacy/terms/cookies.html were missing canonical + OG/Twitter tags — added, matching the rest of the site.
7. **Checked and NOT a bug:** logo `alt=""` on 11 pages, correct as-is since visible "Retrofit Group" text sits right next to it in the same link (avoids screen-reader double-announcement).

**Delivery:** packaged into `retrofit-group-site-2026-09-03.zip` (66 files, same structure/naming convention as prior deliveries), verified clean first (every image/asset actually referenced, no unused files, no internal/BLC content, no stray system files). Charlotte sent it to Cammi via WeTransfer 2026-09-03, replacing a Google-redirect-wrapped link Claude had put in a Gmail draft. See [[feedback_gmail_mcp_wrong_account_and_thread_break]] for why the Gmail draft route didn't work.

**Still outstanding:** Cammi has never sent a GA4 tracking ID despite being asked twice (2026-09-01 email, and again in the 2026-09-03 delivery email) — analytics wiring is blocked on that, not on any work here.

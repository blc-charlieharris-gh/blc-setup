# Changelog

## 2026-09-25

### Manage Clients board
- Two or more pieces awaiting client approval fold into one card with a pill each; click a pill to approve. Website drop onto Awaiting client approval no longer snaps back (#1015). [project: installrhub]
- Website card follows the website page status both ways; empty Awaiting note shows "Awaiting sign-off" (#1016). [project: installrhub]
- Site page Status dropdown shows 7 plain stages; Onboarding emails moved to the bottom of the client card (#1015). [project: installrhub]

### Legal elements
- Heat pump and Solar guides in four steps, prices £4,000 after grant / £7,000, grant facts, client cards show only their products (#1017). [project: installrhub]
- No wording under a plain price, monthly price moved out of the legal block, every block editable in place with Back to automatic (#1018). [project: installrhub]

## 2026-09-23

### BLC moved out of iCloud to ~/code/BLC
- Confirmed `Documents/BLC` really was inside the iCloud container (same inode as the CloudDocs path, Desktop & Documents sync on), the cause of the recurring git corruption. Copied to `~/code/BLC` with `rsync -aH`, dropping node_modules, 2.3 GB of dead browser-profile scratch and iCloud `" 2"` conflict files. 4.8 GB became 2.5 GB. Verified file by file: 792 tests pass, vite build clean. Old copy untouched as rollback until ~2026-10-07. [project: blc]
- Cleaned all five repos to clean trees in sync with GitHub. 69 stale local branches removed (49 in installrhub-static, 20 in marketing-agent), each verified merged first. Green Tide merged and pushed. Stray `index 2.html` removed from creative-library. [project: blc]
- Fixed a hardcoded home path in `site-greentide/scripts/verify-split-test.js` (now relative, 25 tests still pass) and a LocalWP theme symlink broken since June. [project: blc]

### Backups and service isolation
- `meta-access` is now a private repo `blc-charlieharris-gh/meta-access`: ten Meta API scripts plus the ops SOP that previously existed on one Mac only. `.env` and 400 MB of generated media excluded. [project: meta-access]
- `client-landers` and `lead-routing-architecture.md` merged into `marketing-agent`. The merge broke the preview deploy (three lint errors in `template/main.js`, and `npm run build` is `eslint . && vite build`); fixed by fencing `client-landers` in globalIgnores, as was already done for website-factory. [project: installrhub]
- Vercel CLI default scope was Charlotte's personal account while 8 of 9 projects sat on `blc-promotions`. Corrected. Retrofit and Renerji transferred to the team, `offer-remap-temp` deleted; the personal account is now empty. [project: blc]
- Shared `prime-project` and `handoff` rebuilt in house at `~/code/shared-agent-skills`, symlinked into `~/.claude/skills` and `~/.agents/skills`. `prime-project` is read-only; `handoff` never commits, pushes or deploys. `find-skills` removed everywhere except Serafim's repo. Verified no secret has ever been committed to any repo; `.env` permissions tightened to 600. [project: blc]


## 2026-09-21

### InstallrHub telesales caller ID switch
- Confirmed the GHL number change (07446 919125) does not carry over to the app dialer, which uses our own Twilio account. Diagnosed via Supabase: no telesales number was set as default, so calls fell back to the AGENT_CALLER_NUMBER secret (07447 180243). Brad bought 07307 212762 in the app's Settings and set it as the telesales default; calls confirmed going out on it from ~15:00. 07446 919125 was never used, so it's to be released in GHL. Loose ends: label the new number, keep 07576 597601 as a spare and 07447 180243 for callbacks. [project: installrhub]


## 2026-06-12

### Crew by InstallrHub — subscription model v2
- Fable review of the Crew tiers + new tools agreed (Job-Photo Engine, Weekly Pulse, Rosie-lite in Growth, Network Benchmarking, Neighbourhood Blitz, Patch Watchdog, EPC prefill, Margin Guard; Compliance Autopilot feasibility-gated; Savings & Grant Checker parked). Built v2 pitch page in the original Crew style (master `crew-pitch-fable.html`) targeting internal.installrhub.com/subscriptionmodel-fable via marketing-agent branch `feat/subscriptionmodel-fable` — merge conflict vs main resolved, PR awaiting merge in browser. [project: blc]


## 2026-06-08
- Retrofit Group custom site: swapped the Web3Forms access_key on all 6 enquiry forms (index, contact, book-survey, warm-homes-plan, funding, facilities) from our shared key (04a75e23-…) to Retrofit's own (c5c30c62-…). Re-bundled the full custom-sites source as client-sites-source-2026-06-08.tar.gz and deleted the superseded 06-02 bundle. Produced a client-clean retrofit-group-site-2026-06-08.zip (files at zip root, internal .vercel/debugging/design-brief/dev scripts excluded) for Retrofit to upload to their own host. [project: clientsitegenerator]


## 2026-06-03
- Connected Higgsfield visual generation to the meta-access project via the official `@higgsfield/cli` (browser OAuth, BLC Promotions team workspace). Ran a test influencer-style heat pump break-even ad with gpt_image_2 (9:16/2k), saved to outputs/. Removed the redundant Python SDK scaffold and added a project changelog. [project: meta-access]


## 2026-05-14
- Completed major InstallrHub blog work: tag archive pages, homepage-style hero redesign with grid pattern and green glow, two-column CTA banner with lead card mockup, related posts section, tag autocomplete and bulk-apply modal in Marketing Hub CMS, post status filters and calendar view, fixed approve-never-force-publishes, and added Blog to site nav and footer. [project: installrhub]


## 2026-05-13
- Built a custom blog CMS for InstallrHub: admin at internal.installrhub.com/blog with Quill editor, draft/publish, separate CM auth (BLOG_PASSWORD/BLOG_SESSION_KEY), and public blog at installrhub.com/blog rendered via Vercel serverless function. Debugged GitHub tokens, domain aliases, and routing. Blog pipeline confirmed working end-to-end. [project: installrhub]
- Built and iterated the BLC Promotions rebrand redirect page: standalone HTML with InstallrHub branding, live badges, value cards, and how-it-works sections. Deployed to installrhub.com/blcpromotions via Vercel and prepared index.html for upload to blcpromotions.co.uk WordPress root. [project: installrhub]


## 2026-05-11
- Renerji custom site: added APHC and HIES accreditation logos to hero bar and footer strip, replaced Coming Soon heat pump card with live Spruce embed, moved quote tools section to top of homepage, updated all nav CTAs to Get Your Instant Quote, fixed Free Home Assessment wording across 3 pages, fixed book-survey.html topbar inconsistency, and removed Soon badges from footer. [project: clientsitegenerator]


## 2026-05-08
- Updated Retrofit Group Trustpilot rating from 4.2 to 4.5 with Rated Excellent label and gradient half-star SVG, deployed to production. [project: clientsitegenerator]
- Retrofit Group site: swapped all service and hero images, added Chief Morale Officer dog overlay on about page, ran full site audit (GDPR/cookies/privacy all clear), compressed images from ~45MB to ~5MB total, removed dead Feather Icons script, added lazy loading and hero preload, boosted PageSpeed score significantly on desktop. [project: clientsitegenerator]


## 2026-05-01
- Built the Green Tide Energy landing page from scratch at Greentide/landing/index.html using Retrofit template structure adapted for homeowner B2C: sky blue hero with form card, live orange social proof ticker in topbar, white trust strip with coloured icons, 3-column benefit cards replacing corporate numbered USPs, stats strip, how-it-works, grant section, review cards, FAQ accordion, and footer. Iterated through topbar, badge, navbar, logo SVG, and overall colour palette to shift from agency-dark to homeowner-friendly. [project: greentide]


## 2026-04-29
- Renerji client site: iterated on hero trust bar, footer accreditations (frosted, hero images, dividers), mobile services grid, SEO tags across all 13 pages, inline form success messages replacing redirects, dead code removal, OG image, Google review link, and Facebook URL. Deployed to Vercel at renerji-ltd.vercel.app. [project: clientsitegenerator]
- Set Renerji preview URL to https://renerji-ltd.vercel.app and status to awaiting in clients.json, resolving a merge conflict with remote formData in the process. [project: clientsitegenerator]
- Deployed retrofit-group custom site to production on Vercel with GDPR form updates: privacy consent and mailing list checkboxes added to index.html, warm-homes-plan.html, and facilities.html. [project: clientsitegenerator]
- Added Wistia VSL to InstallrHub hero section: video in a TV bezel frame, 16:9 survey mockup overlay on top-right corner with seamless auto-scrolling cards, asymmetric grid layout, widened container to 1400px, rolling live pill moved to left column, pushed live. [project: installrhub]


## 2026-04-27
- Completed cookie consent system (Meta Pixel gated behind localStorage consent banner), removed inline pixel from all 22 HTML pages, added honeypot spam protection and privacy/mailing list checkboxes to all three forms (contact, book-survey, funding WHP), deployed to Vercel production. [project: clientsitegenerator]
- Built the Green Tide Energy Room by Room Guide lead magnet as a 9-page A4 HTML document with photo headers, consistent logo placement, and a working PDF export pipeline using Puppeteer screenshot-to-PDF assembly. Fixed logo SVG rendering (viewBox/width fix), converted pages 2 and 8 to photo-header format, added white border to all pages, and resolved PDF image rendering issues by switching from CSS-based PDF generation to a screenshot-per-page approach producing a 2MB output. [project: greentide]


## 2026-04-21
- Fixed design generation (en-dash header bug, model switching, token overflow), auto-save copyData after generation, added Skip to Preview on Step 2, added per-card Preview button in design picker, reduced to 2 design variants to fit Haiku token limit, and exported Retrofit Group brand brief. [project: clientsitegenerator]


## 2026-04-17
- Continued InstallrHub careers page work: added Descript video to RPM card, fixed video layout/size, added hero perks pills with homepage badge style, built custom application form for Revenue & Partnerships Manager with role-specific questions, updated apply.js to output all fields dynamically, made all form fields required except LinkedIn. [project: installrhub]
- Added Revenue & Partnerships Manager job card to InstallrHub careers page (removed test job), switched video embeds from Wistia to Descript, added hero perks pills with homepage badge style, added salary/rate support to job cards and add-job skill. [project: installrhub]
- Built full InstallrHub careers page: collapsible job cards with inline application forms, CV upload via busboy/Resend, Wistia video support, SVG icons, thank-you page, and /add-job and /remove-job skills. Also rebuilt session-start/end system to be fully autonomous with per-project state tracking. [project: installrhub]

## 2026-04-16
- Updated session-end skill to automatically include a memory update step after running the script, so Claude updates project memory files every session without being reminded
- Added Vectorise with Quiver button and Upload Image button to logo field in generator. Fixed logo colour extraction overwriting client intake colours. Added View Intake Form popup in topbar showing raw client submission. Added Internal Notes section for BLC to store follow-up context. Fixed intake summary modal ID clash. Reset retrofit-group brand colours to match intake. Updated intake to default to black/white when no colours provided. Fixed clients.json bloat from large logo data URIs and updated GitHub API to handle files over 1MB.
- Fixed BLC intake notification emails by switching from Web3Forms (blocked by Cloudflare server-side) to Resend. Set up blc-promotions.com as verified sending domain. Fixed session-end script sed bug on macOS. Added upsell interest banner in generator client view showing which additional services the client ticked on intake form.
- Fixed BLC notification emails: Web3Forms was getting 403d by Cloudflare on server-side calls from Vercel, switched to Resend (domain blc-promotions.com verified, RESEND_API_KEY added to Vercel, notifications now working). Fixed form_option other mapping in generator: added purple notice banner showing client notes when they select the other enquiry option. Deployed and aliased both domains. [project: /Users/charlotteharris/Documents/BLC/ClientSiteGenerator]

## 2026-04-09
- Migrated InstallrHub site to Vercel, set up domain DNS, OG image, email DNS records, domain redirects, site copy updates
- 
- Converted InstallrHub website from WordPress to static HTML/CSS
- Created GitHub repo and pushed site files
- Set up Vercel deployment pipeline

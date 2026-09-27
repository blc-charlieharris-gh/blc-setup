---
name: Project: ClientSiteGenerator
description: BLC internal tool for generating and deploying client websites. Covers architecture decisions, known gaps, and current state.
type: project
originSessionId: 9bc88962-cd7c-4ec0-9ad4-722987e7dd57
---
# ClientSiteGenerator

Internal tool for BLC to generate client websites from a crawl + intake form, preview them, and deploy to Vercel. Clients get a unique intake URL; BLC uses a generator UI to build and deploy.

Live URLs: generator at `internal.installrhub.com`, client intake at `website.installrhub.com/{id}-intake`.

## Current state (as of 2026-05-11)

Two real clients in the system:
- **retrofit-group** (Retrofit Group) - status: DEPLOYED, awaiting client green light for DNS cutover to their own domain. Custom site at `CustomSites/retrofit-group/`, live on Vercel at `retrofit-group.vercel.app`. All service images updated with real client photos. Hero flipped horizontally with CSS scaleX(-1) on ::before pseudo-element. About page has Chief Morale Officer dog overlay (130px, bottom-right of van photo, navy pill label). Finance section on funding.html simplified to get-in-touch panel (client confirmed finance offering still under review). Full site audit passed: GDPR/cookies/privacy all clean, zero broken links, Web3Forms production endpoint, Meta Pixel gated behind consent. DNS cutover checklist: update sitemap.xml and index.html meta canonical/og:url/og:image from retrofit-group.vercel.app to live domain, then redeploy.
- **renerji** (Renerji) - status: DEPLOYED to `renerji-ltd.vercel.app` (Vercel project: `renerji`, personal scope `charlieharris-4909s-projects` - not BLC team scope yet). Custom site at `CustomSites/renerji/`. Domain `renerji.co.uk` not yet pointed at Vercel. Awaiting client sign-off and domain switch. Major client-requested updates applied 2026-05-08/11 (see Renerji details below).

## Renerji custom site details

Path: `/Users/charlotteharris/Documents/BLC/CustomSites/renerji/`
Vercel: `vercel deploy --prod` from that folder, alias `renerji-ltd.vercel.app`

Key technical facts:
- Web3Forms access key: `f17d1e8d-8a1c-4912-8936-d331ab72b307`
- Cookie consent: `js/cookie-consent.js`, localStorage key `renerji_cookie_consent`. GA4 slot present (`G-XXXXXXXXXX`) - client hasn't provided real ID yet.
- All 4 forms use inline success message (no redirect): fetch handler in `js/main.js`, styled with `.form-success` in CSS.
- Hero: left-column frosted accreditation bar (`hero-accred-bar`) with TrustMark, MCS, NAPIT, APHC, HIES logos. APHC inline style `height:52px` (smaller). HIES has `border-radius:8px`. White dividers between each.
- Footer accreditations strip: dark background, frosted white container (`accred-static`), same 5 logos (TrustMark, MCS, NAPIT, APHC 60px, HIES rounded), `accred-div` separators.
- Accreditation images: `images/APHC-logo.png` (506x298px), `images/HIES_ACS_Logo_Standard_Horizontal_UK.png` (1600x874px). Both already in images folder.
- All 13 pages have canonical, OG, and Twitter card tags. JSON-LD LocalBusiness schema on index.html.
- OG image: `images/og-image.jpg` (hero.jpeg cropped to 1200x630).
- Google Reviews link: `https://share.google/jRVewX9U5fgMdA8fl` (live, all pages).
- Facebook: `https://www.facebook.com/renerji.uk` (all pages).
- Instagram: `https://www.instagram.com/renerji.uk/` (all pages).
- Services grid: 2-col at 768px, 1-col at 480px. Image height 160px at 768px, 180px at 480px.
- `.rg-tools` CSS has `align-items: start` so cards don't stretch to equal height.

**Quote tools section (updated 2026-05-08):**
- Section moved to second position on homepage (right after hero), visible immediately on load.
- Layout: 2-column `rg-tools` grid (`align-items: start`), Solar PV card left, Heat Pump (Spruce) card right.
- Solar PV card: visual mockup powered by easy-pv.co.uk (not a real embed yet).
- Heat pump card: live Spruce embed `<iframe src="https://app.spruce.eco/renerji_ltd/embed" style="border:0;width:100%;height:500px">`. Spruce asked not to adjust height but 1500px had too much blank space; reduced to 500px. May need adjusting if form steps need more room.
- `.tool-card-body` has `padding:0` on the Spruce card so iframe is flush.
- Section background: `linear-gradient(135deg,var(--dark) 0%,#1e2a3a 50%,var(--darker) 100%)`, padding `88px 0 40px`.
- Same Spruce embed also on `book-survey.html` (id: `heat-pump-quote-tool`).

**Nav CTAs (updated 2026-05-08):**
- All pages: nav-cta and mobile-cta text changed from "Get a Free Quote" to "Get Your Instant Quote".
- index.html only: nav/mobile/hero CTAs link to `#quote-tools` (not book-survey.html).
- Other pages: CTAs still link to `book-survey.html`.
- book-survey.html page header updated: "Get Your Instant Quote", eyebrow "No-Obligation Estimates".

**Free Home Assessment wording (updated 2026-05-08):**
- Client confirmed assessments outside Dorset are chargeable, so "free" was removed.
- index.html process step: "Free Home Assessment" -> "Home Assessment", "No charge, no obligation" -> "No obligation".
- contact.html: "free home assessment" -> "home assessment", "Book Free Assessment" -> "Book Your Assessment".
- heat-pumps.html trust band: "Free Home Assessment" -> "Home Assessment Available".

**Outstanding:**
- GA4 ID from client.
- Domain DNS switch to Vercel (`renerji.co.uk` not yet pointed).
- OG image replacement with proper screenshot.
- Large image compression (services-heatpump.png 4MB, area-dorset.png 3.3MB, services-evcharger.png 3.2MB).

## Retrofit Group custom site details

Path: `/Users/charlotteharris/Documents/BLC/CustomSites/retrofit-group/`
Vercel project: `retrofit-group`, deployed to `retrofit-group.vercel.app`

Key technical facts for future sessions:
- Web3Forms access key: `04a75e23-e1b5-4b1b-bfbc-601e91639881`
- Meta Pixel ID: `101976209278337` (gated behind cookie consent)
- Cookie consent: `js/cookie-consent.js`, localStorage key `rg_cookie_consent`, values `accepted_v1` / `declined_v1`. To add new marketing scripts, paste into `loadMarketingCookies()` in that file.
- Forms with honeypot + privacy/mailing checkboxes: contact.html, book-survey.html, funding.html (WHP section), index.html (eligibility form), warm-homes-plan.html, facilities.html
- Honeypot field name: `_honey` (Web3Forms native, no extra config needed)
- HES grant amounts: £7,500 standard, £9,000 rural/island
- Hero background: CSS ::before pseudo-element with `transform: scaleX(-1)` and `latest-hero.jpg`. Overlay darkening via ::after. Mobile overrides `background-position: center 35%` on ::before.
- Image format: all service/hero images converted from PNG to JPEG (80-85% quality, sized to 1200-1440px). No Feather Icons dependency (was unused, now removed). All content images have loading="lazy". Hero has rel="preload".
- Finance section on funding.html: simplified to get-in-touch panel. No bullet list, no "coming soon" language. Client still reviewing finance offering.
- Trustpilot widget: client asked about live score updates. Currently hardcoded at 4.5 / "Rated Excellent". Star display uses SVG linearGradient half-star (IDs: hsg-hero, hsg-reviews) in index.html for the 5th star, replacing the old opacity:0.5 approach. To add live widget: need Retrofit Group to share Trustpilot business account access or embed code (business.trustpilot.com, Integrations, TrustBox widgets). Replace hero-tp section with TrustBox div + script.
- Outstanding: DNS cutover (update sitemap + meta tags to live domain), Trustpilot live widget once client provides account access.

## Hub rename (2026-05-14)

Tool renamed from "Client Site Generator" to "Marketing Hub":
- `generator/index.html`: `<title>` -> "Marketing Hub", sidebar logo text -> "Marketing Hub", hub body heading -> "Client Sites"
- `generator/blog.html`: `<title>` -> "Blog -- Marketing Hub", sidebar logo text -> "Marketing Hub"

## User/access management system (built 2026-05-14)

Multi-user auth with email+password, replacing single shared password.

**Files:**
- `api/_github_users.js`: PBKDF2 (100k rounds, sha256) password hashing, HMAC-SHA256 stateless tokens (30-day TTL, format: `base64url(userId):expiry:hmac`), reads/writes `data/users.json` via GitHub Contents API
- `api/auth.js`: POST `{email, password}` returns `{ok, token, user}`; GET `?token=` returns `{ok, user}`. No more single `BLC_HUB_PASSWORD`.
- `api/users.js`: CRUD. GET (list) + POST (create) + PUT (update) + DELETE. Ultra admins manage all; regular users can update own notifications and password only (must provide currentPassword).
- `data/users.json`: seeded with 3 ultra admins (Charlotte: charlieharris@blc-promotions.com, Brad: bradclark@blcpromotions.com, Serafim: serafimparente@blc-promotions.com). Initial temp password: `InstallrHub2026!`
- `generator/index.html`: email+password gate, sidebar shows user name + role + sign-out button, Blog and Users nav links shown conditionally (blog: `permissions.blog`, users: `role=ultra_admin`)
- `generator/blog.html`: unified auth via `/api/auth`; role derived from `user.role` (`ultra_admin` = approver, `user` with blog permission = cm); `applyRole(user)` now shows user name in role indicator
- `generator/users.html`: user management UI. Lists users with permissions/notifications. Add/edit/delete users, toggle permissions and notifications, change own password. Ultra admin only. Route: `/users`.

**Token storage:** `blc_hub_token` (token string) + `blc_hub_user` (JSON user object) in localStorage.

**Role mapping (blog):** ultra_admin = approver (can approve/reject); user with `permissions.blog=true` = cm (editor only).

**Permissions tracked:** `client_sites`, `blog`. More sections can be added.

**Notifications tracked:** `post_pending_approval`, `post_approved`, `post_rejected`, `post_published`.

## Key architecture decisions

- Client data stored in `data/clients.json` on GitHub, read/written at runtime via GitHub Contents API. Files over 1MB: GitHub returns `content: null` and `download_url` - `_github.js` now handles this fallback.
- `intakeData` = raw client submission, never modified after submit. Source of truth.
- `formData` = what BLC edits in the generator. Starts as a copy of intakeData, can diverge.
- `copyData` = AI-generated copy, stored per client.
- Logo SVGs can be 1MB+ data URIs. Only stored in `formData`, NOT duplicated in `intakeData` (was causing file bloat).

## Colour handling

- Intake form: client enters brand_primary (hex), brand_secondary (optional), brand_accent (optional). No default - blank = no preference.
- On intake submit: brand_primary defaults to #000000 if blank. brand_secondary maps to brand_primary_dark and brand_btn_bg. brand_accent overrides brand_btn_bg. Text always defaults to #ffffff.
- Logo colour extraction in generator: only auto-applies extracted colours if no client colours are loaded (flag: `window._clientHasIntakeColours`). Never overwrites intake colours.

## Logo workflow

Generator brand section has: paste SVG textarea, Upload Image button, Vectorise with Quiver button, Remove Logo, Download Logo.
- Upload Image: reads file as data URI, sets as logo
- Vectorise with Quiver: calls `/api/vectorise` (server-side proxy, requires `QUIVER_API_KEY` env var in Vercel). Sends base64 image to `POST https://api.quiver.ai/v1/svgs/vectorizations`, model: arrow-preview. Returns SVG which replaces the image.
- Nav and footer logos have `filter: brightness(0) invert(1)` in CSS - always renders white on dark backgrounds, no extra work needed.

## Email notifications

BLC notified when client submits intake form. Uses **Resend** (Web3Forms was blocked by Cloudflare 403 on server-side Vercel calls). Sends from `notifications@blc-promotions.com`. Requires `RESEND_API_KEY` env var in Vercel. Domain `blc-promotions.com` verified in Resend. `BLC_WEB3FORMS_KEY` kept for client contact forms on deployed sites (browser-side, unaffected).

## Generator UI features (key ones)

- **View Intake Form** button in topbar: shows when client has intakeData. Opens popup with every intake field and value, blanks shown as "(blank)". Reads from intakeData only - true source of truth.
- **Internal Notes** section at top of form: free-text BLC notes (blc_notes field), saved with client record. Not used in copy generation.
- **Upsell panel**: always shown in Client Details section. Shows which of 4 services client ticked (brand, social, SEO, GBP) and which they didn't. Data from intakeData.
- **Form preference notice**: shows client's enquiry form preference (embed / email / other) with relevant details.

## Vercel deployment

Every push to main auto-deploys. After each deploy, must re-alias domains manually:
```
npx vercel alias set <url> internal.installrhub.com --scope blc-promotions
npx vercel alias set <url> website.installrhub.com --scope blc-promotions
```
Get latest URL from `npx vercel ls --scope blc-promotions`.

## Design generation (api/design.js)

Generates 2 CSS override designs (Foundation + Signal archetypes) via OpenRouter using `anthropic/claude-haiku-4-5`. Returns `{ designs: [{ archetype, label, description, fonts, css }] }`.

Key constraints learned:
- Haiku has 8192 output token cap. 3 designs at ~6000 chars CSS each overflows. 2 designs fits.
- CSS prompt uses CSS custom properties in `:root` first, then targeted overrides only. Target: under 80 lines per design.
- en-dash characters in HTTP headers cause ByteString errors - all header values must be ASCII only.
- gemini-2.5-flash times out at 55s on this prompt size. gemini-2.0-flash-001 hits Google AI Studio rate limits via OpenRouter. Haiku is reliable.
- Design variants and selection saved to client record via PATCH.

## copyData persistence

`copyData` is now auto-saved to the client record immediately after successful generation (PATCH call in btn-do-generate handler). Previously only saved on manual Save Draft or deploy. PATCH handler in `api/clients.js` now accepts `copyData` and `formData`.

When a client is loaded via `fillFromRecord`, if `record.copyData` is non-empty, `window._generatedCopy` is restored AND the topbar tag is set to "Generated".

## Step 2 navigation

- If copy exists when clicking the Step 1 footer button, goes directly to Step 3 preview with copy editor open (skips Step 2).
- "Skip to Preview" link appears on Step 2 header when copy already exists in memory.
- `updateStep1Footer()` controls Step 1 footer state: shows "Edit Copy" + "Preview & Deploy" when copy exists, "Continue" when not.

## Returning client / update workflow (not yet built, not urgent)

Most returning clients can be handled by editing their existing record with no crawl. Hard case (re-scrape needed) has no clean automated merge yet.

---
name: Project - InstallrHub
description: BLC's product InstallrHub — a UK heat pump survey marketplace for installers
type: project
originSessionId: d7e50000-770d-4b19-861d-ba2a8c0eff36
---
InstallrHub is a marketplace where heat pump installation companies sign up, prepay with credits, and access an exclusive custom app to claim pre-booked homeowner surveys.

**Why:** To become the UK's #1 source of heat pump surveys, targeting mid-size and larger installation companies wanting to scale.

**How to apply:** When helping with content, design, or features, emphasise the no-monthly-fee model, pre-booked/pre-qualified surveys, exclusive app access, and UK-wide ambition.

Key details:
- Business model: Credits prepaid, no monthly subscription, credits never expire
- Target customer: Mid-size to large heat pump installation companies wanting to scale
- Core value prop: Pre-booked surveys ready to claim (homeowner already confirmed), no cold calling
- App: Custom-built, exclusive to members, shows live survey availability
- Coverage: UK-wide
- Logo: Dark charcoal (#2d3748) + green (#4a9e4f), bold sans-serif — file at `/Users/charlotteharris/Documents/BLC/installrhub-logo.jpeg`
- Homepage mockup: `/Users/charlotteharris/Documents/BLC/homepage-mockup.html`
- Tone: Mix of professional and energetic/gamechanger — "this changes everything for installers"

## Homepage hero (updated 2026-04-29)

The hero section of `InstallrHub/installrhub-static/index.html` now has a video-first layout.

**Layout:**
- Asymmetric two-column grid: `440px` left (text/CTAs), `1fr` right (video)
- Container widened to `1400px` (padding `32px`)
- Grid and hero overrides live in an inline `<style>` block in `index.html` (not sections.css), to avoid CSS caching issues during static file serving

**Video:**
- Wistia embed (`media-id: 15x7bset09`) via `<iframe>` with `padding-bottom: 56.25%` responsive container
- Wrapped in `.hero-screen-frame`: dark TV-bezel style (`border: 10px solid #111318`, layered box-shadow rings), `border-radius: 16px`
- Wistia scripts loaded in `<head>` (player.js + media embed.js)

**Survey mockup overlay:**
- `.hero-mockup-wrapper`: `position: absolute; top: -36px; right: -24px; width: 38%; aspect-ratio: 16/9; overflow: hidden`
- Hidden on mobile (`display: none`), shown on desktop (`display: block`)
- Contains `.app-mockup` with 8 survey cards (Manchester, Leeds, Sheffield, Birmingham, Bristol, Edinburgh, Nottingham, Cardiff) duplicated for seamless loop
- Cards scroll continuously via CSS animation: `.survey-scroll { animation: hero-survey-scroll 16s linear infinite }` translating `-50%` to loop through the duplicate set
- Cards are non-clickable (`cursor: default`, hover state disabled)
- "View all" in footer links to `#contact`
- Internal font/padding scaled down for the small overlay size

**Left column:**
- Rolling live-activity pill (`#live-badge`) moved from below hero to left column, after the two hero pills (left-aligned)
- Hero pills: "Zero monthly fees", "Homeowners confirmed"

## Careers page (live at installrhub.com/careers/)

Built 2026-04-17. Key details:

- **File:** `InstallrHub/installrhub-static/careers/index.html`
- **Thank-you page:** `InstallrHub/installrhub-static/careers/thank-you/index.html` (noindex)
- **API handler:** `InstallrHub/installrhub-static/api/apply.js` — Vercel serverless function
  - Uses `busboy` to parse multipart/form-data (CV upload)
  - Sends formatted HTML email via Resend REST API with CV as base64 attachment
  - Recipients: bradclark@, serafimparente@, charlieharris@ (all @blc-promotions.com)
  - Reply-to set to applicant email; 5MB file size limit
  - Redirects to /careers/thank-you/ on success
- **package.json:** `InstallrHub/installrhub-static/package.json` — `busboy ^1.6.0`
- **Env var required:** `RESEND_API_KEY` in Vercel project (InstallrHub scope)

**Job card architecture:**
- Cards are collapsible: click header to expand description, click "Apply for this role" to expand inline form
- `job-card-body[hidden]` and `job-card-form-wrap[hidden]` use `display: none !important` to override grid layout
- Jobs with Descript video: `has-video` class on `.job-card-body` → `grid-template-columns: 1fr 420px`; video wrapped in `.job-card-video-col` with `.job-card-video-label` ("Hear more about this role") above iframe; apply row uses `job-card-apply-row-full` to span both columns (`grid-column: 1 / -1`)
- Descript embed URL: replace `/view/` with `/embed/` in the share URL
- Salary/rate badge: optional `.job-card-salary` element shown below meta line; green-light background, green-dark text
- A general application section with 5 role area cards (Telesales, Sales & Appt Setting, Marketing, Social Media, Automations & AI) sits below specific job listings
- Both job-specific and general forms post to `/api/apply` — role is passed via hidden field

**apply.js (updated 2026-04-17):** Now outputs all submitted fields dynamically in submission order. Has a `FIELD_LABELS` map for known field names; unknown names get auto-formatted. Only requires `role`, `name`, `email` server-side. All other validation is handled by HTML `required` attributes. URL-shaped values rendered as links. Works with both standard and custom forms without changes.

**Hero pills:** Three perks pills on careers hero: "Flexible hours", "Fully remote", "Fast growth". Style matches homepage `.hero-badge`: `rgba(74,158,79,0.15)` background, `rgba(74,158,79,0.4)` border, `var(--green-mid)` text. Class: `.careers-hero-pill`.

**Skills for managing listings:**
- `/add-job` — asks 8 questions one at a time (salary/rate as Q5, Descript URL as Q8), generates polished copy, shows for approval, inserts card HTML, deploys
- `/remove-job` — lists current jobs, confirms removal, deploys; restores empty state if no jobs remain

**Current job listings (as of 2026-04-17):**
- Revenue & Partnerships Manager (Sales, Full-time, Remote UK) — live, Descript video (share ID: gvKahOYLirw), custom application form
  - Custom form fields (all required except LinkedIn): full name, email, mobile, current role, revenue experience, why this role, confidence statement, objection handling response, Loom/Drive video link, CV upload, LinkedIn (optional)
  - Uses custom field names: `current_role`, `revenue_experience`, `appeal`, `confidence`, `objection`, `video`

**Footer link:** "Join Our Team" added to footer on all pages (index, contact, privacy, terms, thank-you, book-a-demo)

## Blog (built 2026-05-13, major updates 2026-05-14)

Custom CMS hosted at `internal.installrhub.com/blog`. Public blog at `installrhub.com/blog`. Full pipeline confirmed working end-to-end.

**Architecture:**
- Posts stored as `data/blog-posts.json` in `installrhub-site` repo
- Admin writes to that file via GitHub API using `INSTALLRHUB_GITHUB_TOKEN` env var
- When a post is saved, Vercel redeploys `installrhub-site` and the post goes live in ~60 seconds
- Public pages rendered by `InstallrHub/installrhub-static/api/blog.js` (serverless function, reads bundled JSON)
- Domain aliases must be manually re-run after every installrhub-site deploy: `npx vercel alias set <url> installrhub.com --scope blc-promotions` and same for `www.installrhub.com`

**vercel.json rewrites (installrhub-static):**
- `/blog/sitemap.xml` -> `?action=sitemap`
- `/blog/category/:slug` -> `?action=category&slug=:slug`
- `/blog/tag/:slug` -> `?action=tag&slug=:slug`
- `/blog/:slug` -> `?slug=:slug`
- `/blog` -> default

**Public blog features (installrhub-static/api/blog.js):**
- Archive index with latest posts grid (3 up) + category sections + two-column CTA banner
- 5 category archive pages (Installer Lead Generation, Growing Your Installation Business, Winning More Work, Running a Profitable Install Business, Heat Pump & Solar Industry News) -- only shown when posts exist in that category
- Category/tag archive hero: `text-align:center` to match main blog hero. p tag has `margin:0 auto`. Breadcrumb stays centered as flex row.
- Tag archive pages at `/blog/tag/:slug`
- Single post page: dark hero with breadcrumb + title + meta + tag links, post content, related posts (tag-matched, 3-up compact cards), CTA banner, "More in category" thumbnail strip (3 posts) above CTA
- All dark hero sections (index, category, tag, single) have homepage-style grid pattern overlay and green radial glow
- CTA banner is two-column: copy/button on left, survey lead card mockup on right
- Related posts: 3 posts sharing most tags with current post, compact `blog-related-card` style (smaller than featured cards)
- XML sitemap at `/blog/sitemap.xml`
- JSON-LD Article + BreadcrumbList on single posts; BreadcrumbList on category/tag pages
- `published()` filter includes both `status=published` AND `status=approved` posts with past `scheduledDate`
- Footer has Blog link on all pages including static pages (careers, contact, privacy, terms, thank-you, book-a-demo); nav does NOT have Blog (avoids clickoffs from landing page)

**Admin CMS (client-site-generator: generator/blog.html + api/blog.js):**
- Hub renamed to "Marketing Hub" in page titles and sidebar
- Two roles: approver (hub session key) and CM (blog password from settings)
- Status flow: draft > pending_approval > approved > published
- Approve action: ALWAYS sets `status=approved`, never force-publishes. Public site shows it live via `published()` filter. Cron sets to `published` within the hour.
- Status filter tabs with live counts: All / Pending / Drafts / Scheduled / Published
- Calendar view: monthly grid showing posts by scheduled date, colour-coded dots (blue=scheduled, green=published, amber=pending), click dot to edit post
- Post list shows scheduled date column; warns "No date" if missing
- Approved posts with past scheduledDate show "Live" badge in list
- Tags: autocomplete dropdown while typing (from existing tags); "Click to add from existing tags" panel below input (all existing tags as clickable pills); when a brand-new tag is added, bulk-apply modal shows all other posts as checkboxes to optionally apply the same tag
- Focus keyword field with live 7-point SEO checklist
- Image upload to GitHub (`images/blog/` folder in installrhub-site repo)
- Settings: approver email, CM email, CM password (stored in `data/blog-settings.json` in installrhub-site)
- Emails via Resend: CM gets email on approve/reject; approver gets email on submit for approval

**WordPress theme (installrhub-theme):**
- `header.php` updated to include Blog as 4th nav link (from Customizer, defaults to `/blog`)
- `footer.php` updated with a new Resources column: Blog, Lead Generation, Grow Your Business links
- These files are NOT in a git repo — must be manually uploaded to WordPress hosting

**OG image auto-generation (not yet built):**
- Currently falls back to coverImageUrl if no explicit ogImage set
- For branded dark-overlay-with-title OG images, need `@vercel/og` (Satori) as a new `/api/og` endpoint
- Flag for future session when more posts are live

**Pending / known gaps:**
- CM access permissions toggle in settings (currently CMs can only access blog, no toggle yet)
- `@vercel/og` for branded OG image generation
- WordPress theme files need manual upload to hosting after header.php/footer.php edits

## BLC Promotions rebrand redirect (built 2026-05-13)

A standalone rebrand page announcing "BLC Promotions is now InstallrHub".

**Files:**
- `InstallrHub/rebrand-redirect/index.html` — source file, upload this to blcpromotions.co.uk WordPress root as `index.html` to replace the homepage (Apache serves index.html before index.php, so WordPress is bypassed for the root URL only; all other WP pages stay intact)
- `InstallrHub/rebrand-redirect/rebrand-homepage.php` — WordPress page template alternative (upload to theme folder, assign to a page, set as static front page in Settings > Reading)
- `InstallrHub/installrhub-static/blcpromotions/index.html` — deployed copy, live at installrhub.com/blcpromotions

**Design:** InstallrHub branding (dark gradient hero, green accents). Hero sequence: BLC Promotions SVG logo, "is now", InstallrHub SVG logo (white Installr + green Hub), subheading, CTA button, pills, live activity badge. Sections: trust bar, 2x2 value cards, how it works (3 steps), CTA, footer.

**Key decisions:**
- No app mockup card (removed after iterations)
- Section heading color: `#01071a` (dark navy), set via inline style on each h2 to override any theme CSS
- Footer background: `#01071a`, white text, green link
- noindex removed from the blcpromotions.co.uk version (want SEO value preserved)
- Longer term plan: 301 redirect the whole blcpromotions.co.uk domain to installrhub.com once traffic is confirmed transferred

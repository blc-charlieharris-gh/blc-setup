---
name: Project - Green Tide Energy
description: Greentide is a heat pump lead generation brand — they run ads, collect homeowner enquiries via forms, then sell those surveys to installers. They do NOT carry out surveys themselves.
type: project
originSessionId: 6eaf3f43-6aa6-4bf3-af05-6bf5857b73e3
---
Green Tide Energy runs cold ads (Facebook etc.) targeting homeowners interested in heat pumps. Homeowners fill in a form and become a lead/survey. Green Tide then sells that survey to an installer via their marketplace (InstallrHub).

**Why this matters for copy:** Never write "our surveyor" or imply Green Tide carries out the survey. Never say "free survey" — some installers charge, some don't. The SMS/email journey is from Green Tide to the homeowner after form submission.

**How to apply:** In all homeowner-facing copy, Green Tide facilitates the process and connects them with a local installer. Don't promise what the installer will or won't charge. Don't imply Green Tide employs surveyors.

Key details:
- Brand: Green Tide Energy
- Logo: inline SVG available (vectorised, used in landing page). External PNG at https://greentideenergy.com/wp-content/uploads/2024/11/greentide-logo.png
- Colours: Sage green #6b9635, sky blue hero #78bce8/#4a9dd4, dark #252525, red accent #c0392b, orange ribbon #e07000
- Fonts: Barlow (headings) + Urbanist (body) — used in landing page. Urbanist / Plus Jakarta Sans used in home guide.
- Post-booking project files: /Users/charlotteharris/Documents/BLC/Greentide/post-booking/
- Files: index.html (hub), thank-you.html, what-happens-next.html, email-templates.html, sms-templates.html
- Grant: £7,500 Boiler Upgrade Scheme — can reference this
- SMS 1 (locked): "Hi [First Name], it's Green Tide Energy 👋 Thanks for taking the first step towards cutting your energy bills. We'll be in touch shortly to book your heat pump survey. Any questions, just hit reply!"

## Landing Page (new, 2026-05-01)

File: `Greentide/landing/index.html` — single-file homeowner landing page, Retrofit template structure adapted for B2C.

**Design system:**
- Fonts: Barlow (headings, font-weight 800/900) + Urbanist (body)
- Hero: sky blue gradient (`#0f4c8c` to `#2a9cd8`), two-column grid: left text + right white form card
- Hero H1 highlight (`em`): warm yellow `#ffe066` on sky blue
- Topbar: dark (`#181818`), left side has pulsing green dot + "Now Accepting Applications", right side has orange social proof ticker badge (slides in/out from right, varied timing, 15 rotating messages with first names and UK cities)
- Navbar: floating white pill (`border-radius: 50px`), becomes fixed flat bar on scroll. Inline SVG logo. Padding-top: 72px to clear topbar.
- Trust strip (below hero): white background, 4 pills with coloured icon badges — orange (grant), green (MCS), blue (no obligation), purple (UK-wide). Dark text.
- Stats strip: 4 columns, white bg, green numbers
- How It Works: 3 step cards on green-pale bg, large number watermarks, green icon squares
- Benefits section (replaces old numbered USPs): light blue bg (`#f7fbff`), 3 white cards with large coloured icon circles, benefit headline, description, colour-coded factoid tag. Orange for bills, blue for grant, green for home value.
- Grant section: near-black bg, two-col: left feature list + right large grant card with `£7,500` in white
- Trust/reviews: 3 testimonial cards on green-pale bg, orange stars, location tags
- FAQ: accordion, 6 questions, slide-open with `grid-template-rows` animation
- Footer CTA: green gradient banner
- Footer: dark bg, inline SVG logo with white text paths

**Key technical notes:**
- Form is JS-handled (no backend yet): simulated 900ms delay then shows success message. Needs Web3Forms key or real endpoint wired up before going live.
- `og website/1.png` through `8.png` are screenshots of the old WordPress site, NOT usable as hero images. Hero uses CSS gradient only.
- Topbar ticker: 15 messages array, random start index, varied hold (3.5-6s) and gap (0.8-2.2s) timing via `rand()` helper. Slides in from `translateX(440px)`, exits to `translateX(440px)` (right). Wrapper is `width: 420px; overflow: hidden`.
- Footer SVG logo uses separate CSS class prefix (`ft-cls-*`) to avoid collision with navbar SVG classes.
- Phone number in topbar FAQ CTA is placeholder `0800 000 0000` — needs real number.

**Outstanding (landing page):**
- Wire up form to Web3Forms or real endpoint
- Add real phone number
- Add real hero photo when available (currently CSS gradient)
- Continue section-by-section iteration with user (stopped after benefits section redesign)

## Lead Magnet: Room by Room Home Guide

File: `post-booking/home-guide.html` — 9-page A4 HTML lead magnet

**Structure:**
- Page 1: Cover (cover.png)
- Page 2: Contents / intro (home2.png, photo-header format)
- Pages 3-7: Room pages — Living Room, Kitchen, Bathroom, Bedroom, Loft (photo-header format)
- Page 8: "The Bigger Picture" / heat pump upgrades (heatpump.png, photo-header format)
- Page 9: Back cover (back-cover.png)

**Design system:**
- All pages: `width:210mm; height:297mm; overflow:hidden; position:relative; border:2px solid white`
- Photo header pattern: `height:94mm` with `<img>` + dark gradient overlay + absolute-positioned logo (top:18px, left:18px), page label, eyebrow/title/pills
- Logo on every page: inline `<svg width="101" height="38">` (HTML attributes, no viewBox on outer SVG — symbol already has one). `color:white` with `drop-shadow`. CRITICAL: never use `width:auto` on position:absolute SVG without viewBox — it expands to container width
- Orange ribbon on cover: `background:#e07000`, "2026 Edition"
- Savings banner on page 2: dark green `#2f4f00`, framed as "Following this guide, UK homeowners save / Up to £2,300 per year" — deliberately doesn't show the split (undermines the guide's premise)

**Local images** (in `post-booking/images/`):
cover.png, home2.png, livingroom.png, kitchen.png, bathroom.png, bedroom.png, loft.png, back-cover.png, heatpump.png

**PDF generation:**
- Script: `post-booking/generate-pdf.js` (Puppeteer + pdf-lib)
- Run: start server first (`python3 -m http.server 3333` from post-booking dir), then `node generate-pdf.js`
- Serves from `http://localhost:3333/home-guide.html` (not file://)
- Uses `waitUntil: 'load'` (not networkidle0 — Tailwind CDN keeps connections open, causes timeout)
- Screenshots each `.a4` div individually as JPEG quality 85, deviceScaleFactor 1.5, 120dpi
- Assembles with pdf-lib into 595.28x841.89pt A4 pages
- Output: `greentide-home-guide.pdf` (~2MB, 9 pages)
- CSS-based PDF (page.pdf(), headless Chrome print) does NOT work — complex CSS (overflow:hidden, object-fit, absolute stacking) fails to render images

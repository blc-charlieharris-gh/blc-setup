---
name: project_sales_kit
description: "Sales kit page under Hub INSTALLRHUB (reviews bank, portfolio builder, Crew guide); one portfolio, installrhub.com/portfolio folds in; mock-up 10-12"
metadata:
  node_type: memory
  type: project
  originSessionId: 49016966-34a7-4583-96b8-133f92485277
  modified: 2026-10-12T14:52:30.008Z
---

Charlotte 2026-10-12: build a "Sales kit" for the sales team in the Hub's INSTALLRHUB section (marketing-agent). Was asked 10-01/10-02 ("end of the whole audit"), never built.

- **Reviews bank:** eventually all sources: our Hub review form (hub_clients.review_*, none submitted yet), Google reviews, uploads (video clips, screenshots of client messages), pasted text. Public-OK flag per review.
- **Portfolio builder:** pick sites/ads/audits/reviews per prospect -> short link (copy), copy-paste message, or plain OR branded email. Link must be short.
- **ONE portfolio only:** the public installrhub.com/portfolio (site-installrhub static, inline JS arrays, ADS/AUDITS empty, assets unused) must be brought into the Hub bank, not kept separate.
- **Crew guide = features explained, NOT sales scripts** (10-12: "they know how to sell, they're just not technical"). Per feature: what it is + what it does for the installer; plus a tech-words glossary. No prices in the guide, ever (10-12: "that's for sales").
- **Short link = installrhub.com/p/xxxx, 4 characters** (10-12 OK), lowercase + digits, no look-alikes.
- **Every pack starts from a GHL contact** (search the Hub's GHL mirror `mailing_contacts`); link saved on the contact (field + note), emails sent via GHL, opens noted on the contact.
- Everything prospect-facing (pack page, emails, public page) is InstallrHub-branded in installrhub.com's style.
- **Built 10-12 (live):** Crew guide (#1737, lib/crewGuide), Reviews bank (table sales_reviews + bucket sales-reviews + rpc sales_form_reviews, SQL run 10-12; blur-on-upload, AI words via api/creative-ingredients mode 'review'), quote graphic (lib/quoteGraphic). Reviews have who, company, tech, optional stars, public_ok; no product tag (Charlotte didn't want it). Review forms for Crew + campaign to come, feed the same bank. Google = installer reviews of OUR listing, not set up yet. NEXT: Portfolio + GHL short links, then installrhub.com/portfolio reads the bank.
- Clickable mock-up (v2 10-12): claude.ai/artifact/NhyvYcuAGe4Xtv4e181TgV (approved 10-12). Order proposed: guide -> reviews -> portfolio + links.

**Portfolio plan (agreed 10-12, 4 steps, each live before the next):**
1. Library tab (Sales kit > Portfolio): websites (hub_clients name + homepage pic `client-site-files/<id>/preview.jpg` + live link), ads (creative_assets), audits (InstallrScore, legacySitescore slugs), reviews (public_ok yes). Each: tech + "on public portfolio" tick. Seed installrhub.com/portfolio SITES/ADS/AUDITS arrays once.
2. Packs: GHL contact search (mailing_contacts is emails-gated -> new installrhub-gated DEFINER RPC returning name/company/email/phone only; reuse emails/ViewAs picker), pick items + intro, link installrhub.com/p/xxxx. Site repo: vercel.json `/p/:code` -> `api/p.js` (copy api/t.js pattern) + DEFINER RPC; page in installrhub.com style + book-a-call. Tell site-installrhub session first.
3. GHL (InstallrHub location, GHL_INSTALLR_*): "Portfolio link" custom field (resolve id like broadcasts customFieldIds, PUT /contacts) + note on send (ghlAddNoteOnce), note per open, email via /conversations/messages type Email (never done before: test on Charlotte's own contact first), plain or branded. Sent links tab with opens.
4. installrhub.com/portfolio reads the library (ONE portfolio).
Open questions (unanswered 10-12): audits in packs = picture+score only, or link to full password page (password = slug)? Ads = any Creative library ad, or only ones ticked OK to show?

**Portfolio contents (Charlotte 10-13, replaces the item list in step 1 above):**
- Websites: hub_clients at transferred / deployed (Live) / ready_to_preview (with client), Vercel link OK; picture = the preview-audit screenshot client-site-files/<id>/preview.jpg (same one the client saw). NO before/after for websites (she never asked).
- Social: socialScores() before/after + Facebook page before (fb_now_*) / after (fb_cover/profile/pinned). Elect first; still being thought through.
- Google: googleScores() before/after + a profile preview mockup "from the customer's eyes" that the Google build will make (blc-1b asked 10-13, not built yet; it will send the files kind + bucket).
- Logos: before (crew_deliverables files kind 'source') -> after, + brand mock-up (kind 'mockup', Core has one); or a gallery of logos with mock-ups.
- Campaigns: good reports chosen by Parameters rules (per tech), shown as an anonymised portfolio card: tech + broad area (e.g. North West, OK'd), cost per lead, cost per booked survey, booking rate, campaign length, momentum chart if with us 90+ days; "From a real InstallrHub client report". Plus gallery of top heat pump / solar ads (creativeRank high).
- Audits IN (10-13 later): prospect_audits (site kind, score, page_slug -> public/sitescore/<slug>), shown anonymised ("Solar installer, England" + score). Where the prospect became a client we built for (Arktek, Gas Worx), the website item shows the audit score as its 'before'.
- 10-13: scrap the old installrhub.com/portfolio entirely (its 20 ads, 5 sites, 5 audits are NOT carried over); Green Tide off; no hand-added items. The Hub Library is the only source.
- Public pack page (/p/xxxx) and public portfolio must be PREMIUM: "10k style", premium animation, InstallrHub branding, the works. Links agreed: installrhub.com/portfolio (public, ticked items) + installrhub.com/p/xxxx per pack. blc-5c / next site session makes the site changes.

**10-13 later (live):** Library = admins approve by adding (Ready to add + Edit + Retake pictures admin-only, sales read-only, no public tick; nothing public except packs). Audits are NOT items: a SiteScore only shows as a website's before. Google items draw GoogleProfilePreview from a saved googleProfileView copy (photos copied). installrhub.com/portfolio to be designed together later.
**Before/after SiteScore (Charlotte 10-13, Crew side handed to blc-1b):** SiteScore of the old site at the start of every website job (internal if not bought), SiteScore of our site on the handover checklist; client sees it only when after >= 90 (before + after + why each); no old site = after only; backfill afters for the 8 built sites. Portfolio card to show "SiteScore 45 -> 92" once blc-1b adds the before/after marker (suggested prospect_audits.stage).

**Status 10-13 end of day (all merged + live):** Library (admin approves), campaign cards (Find campaign stories, sales see beats-target only), top ads, logo bank (Library > Elements > Logos), PACKS live: Sales kit opens on Packs, crew.installrhub.com/p/<4-char code>, PackPage = post-call PORTFOLIO (Charlotte: "not the landing page; send after the call, keep warm, show on screen"), approved mock claude.ai/artifact/3C6yUob8ZZ4yfpfxYAH5pe v6. Calendars only in Parameters > Calls (1-1 calls list: Brad 6ggF..., Kornelius sMCu...). NEXT: Charlotte tests a pack; step 3 GHL sending (link on contact + note, email via GHL, note per open); installrhub.com/p/ redirect (site session); public /portfolio design; campaign cards look better + easier to add. Booking link has no ?cid (public GHL id) unless she OKs.

**Why:** sales need proof and the right words on calls. **How to apply:** don't add a second portfolio list anywhere; see [[feedback_no_duplicate_solutions]] and [[feedback_confirm_understanding_before_fixing]].

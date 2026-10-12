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

**Why:** sales need proof and the right words on calls. **How to apply:** don't add a second portfolio list anywhere; see [[feedback_no_duplicate_solutions]] and [[feedback_confirm_understanding_before_fixing]].

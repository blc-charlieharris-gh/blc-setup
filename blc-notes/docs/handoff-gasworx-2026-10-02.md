# Handoff, 2026-10-02 (Gas Worx legal numbers + audit)

Lives outside the repo (keeps the shared tree clean); `marketing-agent/.claude/docs/current-handoff.md` belongs to the Hub-audit session.

## What we worked on
- #1307: his business details answers (hub_clients `gasworx` info_requests) on the site. VAT 266503696, Gas Safe 502860, NAPIT 70593, MCS NAP-70593 in the footer (template.html, all pages), terms (lede, section 16, end block) and the contact info row (build-pages.mjs). ICO and OFTEC answered No.
- #1307 audit: `businessDetailsFindings` takes the client's No answers (`businessDetailsNotApplicable` in src/lib/businessDetailsRequest.js, passed as `business_na` from runSiteAudit and liveWatch) and lists them as "doesn't apply"; `videoTagInfo` counts `data-poster` as a poster.
- #1316: 20 Soro blog posts had a shortened registered office; build-pages.mjs rewrites it to the full address when building (source .md untouched, future Soro posts covered).
- Both deployed (`vercel deploy --prod` from the gasworx folder) and checked live; address verified on all 125 pages.

## Current state
Hub audit all clear and signed off. Gas Worx site work complete.

## Next steps
1. (done 10-02) Phone overflow signed off; ICO checked with him.
2. Optional: audit could compare the postal address itself (it says "checked by hand").
3. Harvard: Charlotte is tightening copy in GPT next; no per-page copy audit was ever done (that was Core).

## Decisions and open questions
Blog text from Soro is never edited at source; fixes go in the build.

## Working tree and other sessions
Clean, main (behind origin by others' merges, not pulled). Merged branches `fix/gasworx-legal-numbers-1002` (deleted) and `fix/gasworx-blog-address-1002` (local + remote still there). blc-32 informed.

# Handoff, 2026-10-25 (Helix Power website build, session blc-86)

## What we worked on
- Researched the Brief, then built the site from the Hub kit: 27 pages incl. `/blog` (10 of 21 old posts), one generator `build-pages.mjs`, package explorer.
- New H1s: only Home and Areas name the place (`H1` list in `build-pages.mjs`).
- 53 old addresses redirected; the 11 left-out posts go to their closest page.
- Audit fixes: texture misread as a file, duplicate title, blog headings, dead LinkedIn removed, hours + geo, container, menu breakpoint.

## Current state
Latest build is saved on the Hub job (https://internal.installrhub.com/sites/helix-power-ltd). All local copies deleted at Charlie's request 2026-10-25: the Hub is the only copy.

## Next steps
1. On the job, accept: thank-you page "reached by sending any form (CONV-03)"; ICO helpline 0303 123 1113; "leading" = Dave's role; Trustpilot link (blocks checkers, opened by hand).
2. Change the 11 left-out post lines in the Brief redirect list to the site's closest-page targets (`_old-site-redirects.json` in the build).
3. Update the Hub copy: new H1s and the Home title ("Helix Power: solar panels in ...").
4. Client asks: Web3Forms key, Chamber OK, Trustpilot widgets, MCS/TrustMark/RECC, ICO number, phone hours, reply time, photos, new LinkedIn link. Us: GA4/pixel IDs, final domain.

## Decisions and open questions
Reasons for every hold, left-out post and AI image are in `_client/missing.md`, `blog-keep.json`, `ai-images.json` inside the Hub build. Reviews page kept despite COPY-REV-01: decide.

## Working tree and other sessions
No git repo touched. Other sessions told this session holds nothing in marketing-agent.

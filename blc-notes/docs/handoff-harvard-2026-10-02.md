# Handoff, 2026-10-02 (Harvard Renewables website rewrite + audit fixes)

Lives outside the repo so it can't clash with the Hub-audit session's `marketing-agent/.claude/docs/current-handoff.md`.

## What we worked on
- Charlotte's new copy on every main page: home, heat pumps (costs merged in, `costs.html` 301s to `heat-pumps.html#costs`), air con, servicing, grants (big £9,000 / £7,500 cards), FAQ (30 Qs + FAQPage schema), about. New site-wide footer text.
- Areas page retired (`areas.html` 301s to `contact.html#areas`). Areas live on contact + end of home, with a drawn SVG map. A real Google Map loads only after consent or "Show Google Map".
- Google reviews: 12 reviews from Harvard's Google listing in a carousel under the home hero, first name + surname initial only, Google "Excellent 5.0" block. The hero card shows the Google rating.
- Premium pass: gradient buttons, navy sections with orbs, wider layout, home cards = heat pump / air con / servicing, prettier cost table (cards on phones).
- Cookies: Spruce estimate + Google Map are blocked until consent or click. Fonts self-hosted. Cookie + privacy policies rewritten to match. Footer "Cookie Settings" button.
- Audit fixes: WebP images (6.8 MB to 2.1 MB) + width/height, phone-sized hero images + preload, 404.html, 7-day caching, minified CSS, skip link, heading order, contrast (a11y 100), reduced motion, titles/descriptions, Apple icon, `/index.html` 301 to `/`.

## Current state
Live on https://harvard-renewables.vercel.app (Vercel project `harvard-renewables`, blc-promotions). Deployed by CLI from the site folder, not from git. Future deploys go from `marketing-agent/website-factory/clients/harvard-renewables` (it has the `.vercel` link) after pulling main. Merged as #1340 (main matches the branch exactly). The worktree and local branch have been removed. Harvard have NOT been sent the site.

## Next steps
1. Area pages need 800-900 words each to protect rankings (theirs were 850-960; ours are ~340). Charlotte is getting a new OpenRouter key from Serafim, which goes in `~/code/BLC/.env.local` (the current key returns 401). Or Claude writes them directly if Charlotte prefers.
2. Ask Harvard for: company number, registered office, ICO number or exemption, MCS / TrustMark / RECC numbers, their own Web3Forms key (forms use ours, df2c89ee). Charlotte asked them on 10-02; waiting on replies. ("Sarah T., Bromley" review confirmed fine by Charlotte.)
3. Rerun the Hub audit to confirm page speed on the Bromley and estimate pages.
4. Hub bug (blc-32 owns it, first fix next session): running a site audit closes the "Build website" task. It should only move when the preview email is sent. Charlotte drags Harvard's task back out of Done meanwhile.

## Decisions and how-tos
- CSS: edit `css/style.css`, run `./_build-css.sh` (writes `style.min.css`, which the pages load), then bump `?v=` on the stylesheet links, because CSS is cached for 7 days.
- Deploy: `vercel deploy --prod --yes --scope blc-promotions` from the site folder. Check `git status` first, because the deploy uploads untracked files.
- No Co-Authored-By lines in this repo's commits (CLAUDE.md). The branch was cleaned of them.
- Anything third-party that sets cookies goes behind `data-consent-src` + the consent script, and the CSP in `vercel.json` must allow its domain.

## Working tree and other sessions
The shared tree (`marketing-agent`, main) was untouched by this session. All work is on main via #1340. The shared tree is 1 commit behind origin (the merge), with nothing uncommitted. The audit session (blc-32) has been told the PR one-liner for CHANGELOG/handoff.

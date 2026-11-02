# Handoff, 2026-11-02 (Elect: boiler wording + Boilers and heating page)

## What we worked on
- Elect kit round (`elect-energy-ai-kit-2026-11-02.zip`): Charlotte asked that the wording stop painting boilers negatively, and for a boilers and heating service page.
- 26 lines on 11 pages in `_client/copy.json` reworded ("tired/ageing boiler", "boiler worries", "fresh start", "fuel deliveries" gone). Case study fact "18 boilers replaced" kept.
- New page `/boilers-and-heating` (old site's own address, so no redirect): Vaillant installs + 10-year parts and labour warranty, gas central heating incl. first-time, breakdowns and repairs, How it works, boiler or heat pump. Facts from electenergy.co.uk/boilers-and-heating and electbm.com. No Gas Safe claim (no number found) and no ECO "free boiler" offer (ECO has ended).
- In `build-pages.mjs`: menu, footer, Home link and Service markup. `assets/site.js`: SplitText `aria: 'none'` on the `.h1-brand` span (the round's Lighthouse ARIA flag).

## Current state
- Done: SQL run by Charlotte (site map 17 pages; Page words for the new page, 6 sections). The Hub copy check passes when run locally. `elect-energy-site-2026-11-02.zip` was being uploaded in step 6 at handoff; the audit result isn't known yet.
- Not done: the round's "logos not SVG" item (no official SVGs; previous sign-off).

## Next steps
1. Check step 6's audit; fix anything red in the zip.
2. Once Latest zip shows today's upload, Charlotte deletes `~/Code/BLC/elect-energy-ai-kit-2026-11-02.zip` and `~/Code/BLC/elect-energy-site-2026-11-02.zip`.
3. The client's questions are in `_client/missing.md` (Gas Safe number, warranty, free boiler visit, boiler photos).

## Decisions and open questions
- The other 10 pages' softer wording is only in the zip; the Hub's Page words for them still have the old lines. The built site's words win in later rounds, but a Hub Rewrite would bring the old lines back.

## Working tree and other sessions
Clean. No repo was changed; `_deploy/elect-boilers-page.sql` is the SQL that has already been run.

# Handoff, 2026-11-02 / 11-03 (Elect: boiler wording, Boilers and heating page, AI post pictures, EcoHeat rename)

## What we worked on
- Elect kit round (`elect-energy-ai-kit-2026-11-02.zip`): Charlotte asked that the wording stop painting boilers negatively, and for a boilers and heating service page.
- 26 lines on 11 pages in `_client/copy.json` reworded ("tired/ageing boiler", "boiler worries", "fresh start", "fuel deliveries" gone). Case study fact "18 boilers replaced" kept.
- New page `/boilers-and-heating` (old site's own address, so no redirect): Vaillant installs + 10-year parts and labour warranty, gas central heating incl. first-time, breakdowns and repairs, How it works, boiler or heat pump. Facts from electenergy.co.uk/boilers-and-heating and electbm.com. No Gas Safe claim (no number found) and no ECO "free boiler" offer (ECO has ended).
- In `build-pages.mjs`: menu, footer, Home link and Service markup. `assets/site.js`: SplitText `aria: 'none'` on the `.h1-brand` span (the round's Lighthouse ARIA flag).

## Second round (11-02 late / 11-03)
- AI post pictures: Make with AI / New AI picture for the pinned post and the 10 posts, beside upload own / use theirs, using the picture model in Parameters (PR serafimparente-blc/marketing-agent#3057, merged). Test list P89-P90.
- Stuck job "AI suggestions for Elect's Facebook" cleared by SQL (`_deploy/clear-elect-ai-suggest-job.sql`, run; Charlotte confirmed gone).
- Elect solar page had heat pump photos: three AI solar pictures (roof, battery, close-up) made, listed in `_client/ai-images.json` so the Hub's images question asks for real ones. The boiler-photo line I'd added to `missing.md` removed (the images question covers it).
- All 21 inline styles moved to classes in `assets/site.css` (the round's inline-styles item); checked in the browser, no visual change.
- New zip rebuilt as `~/Code/BLC/elect-energy-site-2026-11-02.zip` (2.1 MB), ready for Upload zip in step 6. Upload not confirmed yet.
- EcoHeat rename: `_deploy/rename-ecoheat-all.sql` run 11-03 and checked: CRM company (Ash Pearce), hub_clients and crew_clients all "EcoHeat Renewables Ltd"; no row keeps the old name. Hub slug left as `ecoheat-plumbing-heating-renewables-ltd` so sent links still work. A separate CRM company "Eco Heat" (Mark Crawford) was never the long name and was left alone. What Serafim needs (CRM side) went to the Prime project session, not from here.

## Current state
- Done: SQL run by Charlotte (site map 17 pages; Page words for the new page, 6 sections). The Hub copy check passes when run locally. `elect-energy-site-2026-11-02.zip` was being uploaded in step 6 at handoff; the audit result isn't known yet.
- Not done: the round's "logos not SVG" item (no official SVGs; previous sign-off).

## Next steps
1. Upload `elect-energy-site-2026-11-02.zip` (the 11-02 late rebuild with the AI solar pictures) in step 6 if not yet done, then check the audit; fix anything red in the zip.
2. Once Latest zip shows today's upload, Charlotte deletes `~/Code/BLC/elect-energy-ai-kit-2026-11-02.zip` and `~/Code/BLC/elect-energy-site-2026-11-02.zip`.
3. The client's questions are in `_client/missing.md` (Gas Safe number, warranty, free boiler visit); photos come through the Hub's images question from `ai-images.json`.

## Decisions and open questions
- The other 10 pages' softer wording is only in the zip; the Hub's Page words for them still have the old lines. The built site's words win in later rounds, but a Hub Rewrite would bring the old lines back.

## Working tree and other sessions
marketing-agent: #3057 merged, nothing local. `_deploy/` SQL files elect-boilers-page, clear-elect-ai-suggest-job and rename-ecoheat-all have all been run; `serafim-note-ecoheat-rename.sql` is NOT to be run (the note went via the Prime session). Two local preview servers (ports 8765/8766) from this session end when it closes.

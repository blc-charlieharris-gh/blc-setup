# Creative backfill: prep (27 Sep 2026)

Status: PREP ONLY. Waiting for the audit (session blc-76, page 5 Creative Testing) to review and merge
`feat/creative-workflow-preview` (frozen 742e1089) and apply migration 20260927120000. Nothing written to the DB.

## Goal
Every creative that spent in the last 90 days sits in the Library (all 3 sizes), is AI tagged, and is linked to the
Meta ads that ran it, so "Why it works" has real history to learn from on day one.

## Shopping list (`creative-shopping-list.csv`, visual page: https://claude.ai/artifact/8PEWFZuLQJnHBM36uJDyAS)
Pulled 27 Sep from live (ads_insights_daily 90 days, ads_ads, creative_merges, creative_tests). Read-only.
- 389 ads spent £70,921. Grouped by the Matcher merges (never ad names, no auto visual key): **255 creatives**.
- **66 already have a file** (uploaded to Creative Testing, £28.6k of spend). No upload needed: copy them across.
- **189 need a file from Charlotte** (£42.3k). Top 10 = 62% of that spend, top 25 = 83%, top 50 = 93%.
  96 of them spent under £25 (£564 in all, about 1%): suggest skipping them.
- 113 of the 189 are still running.
- Tech: 126 of the 189 show "not set": the campaign tech setting (added today) isn't filled in for most campaigns yet.
  Re-pull the list once the audit wires it in, or fill tech on the client cards first.
- Columns: rank, group key, top ad name, clients, tech, ad count, spend, Meta leads, Meta CPL, first/last day,
  running?, have_file, every Meta ad id in the group, thumbnail (to recognise it).
- Only 59 of the 255 are merged (more than one ad). Unmerged duplicates will show up as separate rows, so a
  Matcher pass on the top 50 before uploading saves double work.

## Steps once the branch is live
1. **Matcher pass** (Charlotte, ~15 min): merge duplicates in the top 50, then re-pull the list.
2. **Copy the 66 existing files**: creative-uploads -> creative-library, one creative_assets row each
   (master size = the file's size), other 2 sizes made by the blurred-copy fill.
3. **Charlotte uploads the rest** in rank order: drop files in one folder, named anything.
4. **Match file -> creative**: image similarity against each group's Meta thumbnail (64px thumbs are fine for
   images; videos match on a first frame). Anything below a confidence line goes to a "please confirm" list.
5. **Charlotte confirms** matches (one screen: file | thumbnail | ad name | spend, tick or fix).
6. **Resize + AI tag**: 3 sizes each, then api/creative-ingredients.js (tags + video transcripts).
   Charlotte spot-checks tags on the AI check page.
7. **Link to ads**: one creative_launches row per Meta ad in the group (status launched, meta_ad_id set),
   so spend/leads flow back into Why it works.

## Mapping to the branch (PROVISIONAL until the audit's review)
| Backfill needs | Branch table / code |
|---|---|
| Library item | creative_assets (format, master_slot, files{square,portrait,landscape}, techs) |
| Files | bucket creative-library (200MB limit, check vs project limit) |
| Tags | creative_ingredients, subject_key asset:<id>, lib/ingredientTaxonomy.js |
| Link to ads that ran | creative_launches (asset_id, client_id, meta_ad_id, status launched) |
| Existing files | creative_tests.upload_path (bucket creative-uploads), keyed upload:<id> in creative_merges |
| Tech | public.campaign_tech() / src/lib/campaignTech.js |

## Open questions for Charlotte
1. Include creatives that spent under £25? (Suggest no: 96 files for about 1% of spend.)
2. 60 or 90 days? (List is 90.)
3. Where are the source files (Drive, Erin's folders, a local folder)? Decides whether step 3 is a folder drop or a Drive pull. Not Canva (no longer used).

## Update 27 Sep, after Charlotte's review of the page
- Helix Power removed: their campaigns ("IF | ..." in their own ad account, untracked in the Hub) are their own ads, not ours.
  Can't filter on is_tracked in general: Greentide + InstallrHub have untracked campaigns that ARE ours.
- Duplicates: the Hub Matcher is manual-only (adKey), and nobody has merged these, so every "Copy"/re-upload is its own card.
  Page now folds cards whose thumbnails are the same picture (256-bit dHash, <=8 bits apart; near-black video frames skipped,
  they falsely matched 22 different InstallrHub videos). Result: 124 creatives to find (was 189), £37.0k, top 25 = 88% of spend.
- The CSV is the FIRST raw pull (stale: excludes the 66, includes Helix/Eco Green). page/page-data3.json is the current list.
- Thumbnails: ads_ads.thumbnail_url is a signed fbcdn URL that expires; re-fetch via Graph (creative thumbnail_url). InstallrHub videos
  had pure-black first frames: fixed with GET /{video_id}/thumbnails, first frame with mean brightness > 25. Eco Green (ex-client) = no
  access, 5 cards without a picture. Cross-account video pairs (Greentide "Video" = Arktek/SWH "Vid1") folded by hand.
- Source files: Charlotte will put them in a Google Drive folder and share the link (not Canva). Plan: Drive MCP / meta-access
  drive_download.py pulls them, match each file to a card by picture (videos by frame), she confirms, loaded once the Library is live.
- Eco Green dropped (ex-client, not live, Charlotte 27 Sep).
- Untested backlog (creative_tests status ready_to_test): 45, all with files in creative-uploads. 41 usable as-is (22 square, 9 landscape
  1260x650, 7 portrait 9:16, 2 4:5, 1 2:3) -> copy into creative-library + creative_assets, no action from Charlotte. 4 are small
  screenshots (162x132, 544x582, 458x462, 394x396): originals needed, shown as B1-B4 on the page. The bulk copy should also carry the
  "why" text (all 45 have it) into the asset notes.
- CORRECTION (Charlotte, 27 Sep): the Hub has NO original creative files, creative_tests uploads are screenshots/copies (43 of 79 tested
  are literally Screenshot_*). Bulk copy dropped. List now = every creative that ran in 90 days (172 cards after folding, £64.5k,
  top 25 = 81%, top 50 = 91%; 64 have a Hub copy as fallback) + all 45 untested backlog as B1-B45. Charlotte adds originals for all.
- Hooks (Charlotte, 27 Sep): same creative with a different hook = a separate file and a separate Library item. creative_hooks
  (74 ads tagged, keyed by ad_external_id) used to split cards: "Ad2" (22 ads) and "Ad1" (9 ads) had merged "Sorry" + "Not me realising".
  Their untagged ads (Ad2: 19 ads, £9.8k) sit in a "hook not tagged" card, needing a hook tag in the Matcher to split properly.
  Library link-to-ads must match on hook as well as picture: videos need the card number in the file name.
- BLOCKER (27 Sep): Charlotte asked for a Matcher DATA audit first (page 5 start, blc-76). Backfill matching waits until the
  Matcher is clean (coverage, mixed a:/v:/c: key eras, hooks, possible localStorage-only merges, cross-account dupes).

## Handed off (27 Sep, blc-ee -> audit session blc-76), Charlotte's call
Charlotte handed the whole backfill to the audit session. It ends with the upload of her originals.
- Live list page: https://claude.ai/artifact/8PEWFZuLQJnHBM36uJDyAS (republish from another session by passing `url`).
- Page source + data in `page/`: template.html (placeholders __DATA__ / __BACKLOG__), page-data3.json (176 cards, final),
  backlog45.json (B1-B45 with Hub-copy thumbnails), creative-backlog.html (built page), hooks.txt (creative_hooks snapshot),
  bl_paths.txt (creative-uploads paths for B1-B45, same order).
- Found-ticks are keyed by first ad id (main list) and "B<n>" (backlog), localStorage 'backlog_found_v3'. Don't renumber cards
  once Charlotte starts naming files by card number; if the list is re-pulled, keep the old numbers.
- Thumbnails: Meta Graph via meta-access .env META_ACCESS_TOKEN (read-only GETs); black video frames -> /{video_id}/thumbnails.
Order: Matcher data audit + clean-up -> re-pull list against the clean Matcher (keep card numbers) -> Library merged + migration
-> Charlotte shares Drive folder -> match files (card number / B number in name first, then picture), she confirms -> upload into
the Library, link each asset to its ads (one hook per asset) -> AI tag.

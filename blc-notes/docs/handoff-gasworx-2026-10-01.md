> **UPDATE 1 Oct night: all done.** Video B merged #1296 and live on gasworx.vercel.app, option A branch unused; business details per item merged #1298, site-feedback v25 pasted; client clips deleted. Worktrees removed. Only open item: Charlotte adds the business details question on his site page, then numbers go in the footer. Current state lives in marketing-agent/.claude/docs/current-handoff.md.

# Handoff, 2026-10-01 (Gas Worx site + business details question)

## What we worked on
- Gas Worx site (`marketing-agent/website-factory/clients/gasworx`, live at gasworx.vercel.app, his real domain is still Wix). Merged and deployed: #1276 mobile fixes, single-room air con £2,337, blog paged 12 per page; #1277 Why list centred; #1287 care plan PDF + air con photos; #1288 brand wording (Haier only as price basis); #1289 his Web3Forms key (ff6ae294…) + air con photo in servicing panel; #1295 audit meta fixes.
- Client footage: 24 Gas Worx clips in the Hub library. Fixed 0492 (was squashed): `meta-access/outputs/gasworx-video/other/DJI_0492_landscape_fixed.MP4`.
- Homepage video, option B (big panel on the energy-savings strip, opens to full width on scroll, word-by-word headline, sound button). Branch `feat/gasworx-home-video-b`, PR NOT merged. Preview: gasworx-q6areilte-blc-promotions.vercel.app (Vercel login).
- Business details question as Yes/No per item with X to remove: branch `feat/business-details-per-item-1001`, PR NOT merged; edge fn copy at `~/code/BLC/_deploy/site-feedback.ts` not deployed.

## Next steps
1. Charlotte: replace the warped 0492 in the Hub with the fixed file.
2. Charlotte reviews video preview; on merge of video-b: deploy (`vercel deploy --prod --yes --scope blc-promotions` from the gasworx folder on main), then DELETE her local media in `meta-access/outputs/gasworx-video/other/` (she asked). Delete branch `feat/gasworx-home-video-a` (unused).
3. Merge business-details PR, Charlotte pastes site-feedback, then add the standard question on Gas Worx's site page.
4. When he answers: add VAT/ICO/MCS/NAPIT/Gas Safe/OFTEC numbers to the footer.
5. Remove worktrees `marketing-agent-gasworx` and `.claude/worktrees/agent-ad441abe55815e826` once those PRs merge.

## Decisions
Forms not tested by us (client tests at handover). Photos go in existing page slots, never behind the banner.

## Working tree
Main clean and level. Hub handoff (`marketing-agent/.claude/docs/current-handoff.md`) belongs to the other session, left untouched.

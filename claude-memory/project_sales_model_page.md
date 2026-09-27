---
name: project-sales-model-page
description: "Sales Model board at internal.installrhub.com/model: board.js is plain-DOM source of truth, data in public.pipeline_board, migrations run page-side"
metadata: 
  node_type: memory
  type: project
  originSessionId: 17372e3a-a593-4324-9b71-a3011727d3cb
  modified: 2026-09-17T18:23:04.826Z
---

Built 2026-09-17. One page consolidating the two-day sales meeting: what we sell, what brings
leads in, the processes at each step, and a map of the journey from lead to close, plus a goal
model and a shared notes list. Live at `internal.installrhub.com/model` (marketing-agent,
`src/pages/SalesModel.jsx`), in the INSTALLRHUB sidebar section.

**The board is NOT React.** `src/lib/pipelineBoard/board.js` is ~1500 lines of plain DOM code
exporting `mountBoard(root, db)` which returns a cleanup function. React only mounts and unmounts
it. Styles are `board.css`, scoped under `.ihpb` with every id prefixed `pb-`, which is a
deliberate exception to the repo's Tailwind-only rule (noted in both file headers).

**It began as a claude.ai Artifact, which has since been DELETED (2026-09-17).** It was generated
from that HTML by a throwaway script in a session scratchpad. That script is gone. **`board.js` and
`board.css` in the repo are now the source of truth: edit them directly.** Do not go looking for a
generator.

**Data lives in one table**, `public.pipeline_board`, primary key `(collection, doc_id)` with a
jsonb `data` column, plus `pipeline_board_merge(text, text, jsonb)` for shallow server-side merges
so two editors don't clobber each other's fields. Collections: sources, sequences (funnels),
processes, packages, notes, settings. The adapter is `src/lib/pipelineBoard/supabaseDb.js`, which
presents a tiny document-store API over that table. Named outside the `sales_*` namespace on
purpose, to avoid the separate sales pipeline work (see
[[project-concurrent-sales-pipeline-session]]).

**The page no longer seeds itself (changed 2026-09-17, after it destroyed live data).**
`runMigrations()` now only stamps a version. All the one-off content steps were removed;
starting content lives in `20260917190100_pipeline_board_seed.sql`. If you ever add a
step back, it must only AMEND documents it can see, never recreate them, and it must not
run off a read that might be unauthenticated. See
[[rls-empty-read-looks-like-empty-table]] for why.

**The goal model** (settled 2026-09-17 after several rounds). It reads backwards from the money,
which is how Charlotte reasons about it: goal, ÷ average deal → closes, ÷ close rate → demos,
÷ triage-to-demo → triage calls, ÷ lead-to-triage → leads, × cost per lead → ad spend needed.

- The goal is GROSS PROFIT, so the plan must pay for its own ads. That is circular if you use
  today's spend, so it is solved as `revenue = goal / (1 - CAC/avgDeal)`. The result does NOT move
  when you change current spend, which confused her twice: the headline is now "Still to add"
  (the gap, which does move), with the total underneath.
- **Five rates (settled 2026-09-18, after going 5 → 3 → 5).** Lead→triage booked and
  triage→demo booked are QUALIFIER rates; booked→triage and booked→demo are SHOW rates; then the
  close rate. She collapsed them to three once, then the team pointed out the steps in between are
  where the real losses are, so they came back, named. The chain is driven by the `STAGES` list, so a
  step is a one-line change. `normaliseModel()` maps an old three-rate board on read by assuming the
  default show rate and backing out the qualifier rate, so end-to-end figures survive. Levers are
  ad spend, cost per lead, the five rates, and the deal mix.
- Ad spend and CPL are INPUTS (what we do), everything else is derived. Manual entry of current
  performance was built and then removed: nobody was going to keep six counts up to date by hand.
- A package cannot show Live while any deliverable in it is amber or red.

**Per-source journeys (2026-09-18).** Sources don't all run the same way: a lead magnet lead is
called straight away and triaged on that call, where an ads lead books a triage first. The map
shows one source at a time (Ads by default, remembered per viewer); funnels and processes limited to
other sources grey out, and an empty `fromSources` means "applies to all". Showing the difference
properly is a DATA job, not code: the relevant records need the right sources ticked.

**Processes have a `mode`**, manual or automated (missing means manual). Everything was manual as of
2026-09-18.

**Verifying changes without the app:** bundle `board.js` with esbuild into an IIFE, mount it in a
bare HTML page with a mock db, and drive it with puppeteer. That caught three real bugs the build
could not (see [[feedback-puppeteer-screenshots]]).

**Carry-over fix (2026-09-18, #812).** The live startup path loaded `settings/model` with a plain defaults merge and skipped `normaliseModel()`, so old boards got default qualifier rates. Now both paths call it. (#814 is an empty duplicate merge of the same branch, harmless.) If you add a model field, make sure it goes through `normaliseModel()`, not just `MODEL_DEFAULTS`.

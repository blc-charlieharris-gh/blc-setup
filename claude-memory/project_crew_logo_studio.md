---
name: project-crew-logo-studio
description: "CREW logo package automation (upload → traced SVG → approve → brand pack), built 2026-09-18 on branch feat/crew-logo-studio, LIVE #815, bucket migration applied 09-18"
metadata: 
  node_type: memory
  type: project
  originSessionId: 1312d02d-d7f5-468d-b65b-8a706e92649e
  modified: 2026-09-18T15:12:53.315Z
---

Logo studio on /crew/logo/:id (marketing-agent), built 2026-09-18 in worktree `.claude/worktrees/logo-studio`, branch `feat/crew-logo-studio`, commit 6c7cbb6. Merged as #815 and verified LIVE on internal.installrhub.com 2026-09-18. Not yet used on a real client (Core Electrics row waiting).

Migration `20260918170000_crew_logo_bucket_brand_pack.sql` (crew-logo bucket accepts EPS + ZIP, 50MB) APPLIED by Charlotte 2026-09-18, verified live. Hub-only bucket, so no Serafim review needed ([[feedback_hub_only_migrations_no_serafim_review]]).

**Why:** logos became a sellable package on 2026-09-17; the delivery page only had manual PNG/SVG/PDF slots.

**How to apply:** tracing gotchas are in the commit message and the logoTrace.js header. vtracer colorPrecision ≥7 breaks it, its colour mode leaks the transparency key colour, and its spline mode mangles thin strokes, so we use binary+polygon per colour and fit curves ourselves. Potrace is GPL, don't swap it in. Staff-only file kinds `source`/`svg_draft` live in the same `files` jsonb; LogoDelivery.jsx filters to client kinds.

**2026-09-18 quality fix (branch fix/logo-studio-gradients, merged as #817 and verified LIVE 2026-09-18):** first real logo (Core Electrics, 3D gradient ribbon) traced badly. Tracer now does gradient panels (split on sharp colour edges, fit multi-stop linear gradient per panel, split bent panels), presence-aware edge classification, and fixes a crop bug. Pack writers carry gradients to SVG/PDF shading/EPS L3 shfill; mono decides per shape. Test harness + logos were in the logo-studio worktree .scratch, REMOVED at handoff 2026-09-19 (puppeteer tips: headless "shell", poll with evaluate not waitForFunction).

**2026-09-18 round 3 (branch feat/logo-brand-guide, merged as #819 and verified LIVE 2026-09-18):** brand fonts (FontPicker, stored as "Headings: X. Body: Y." in brand_fonts, no migration), icon picker (drag box / auto-pick, fractions on svg_draft.icon), brand-guidelines.pdf (canvas → JPEG pages), icon + favicon set + Google font TTFs (from github.com/google/fonts, CORS-open, 60 req/hr unauth) in the pack, client page shows logo/icon/colours/fonts. "Preview page" was read as the client delivery link page, stated to Charlotte.

**2026-09-18 round 4 (merged as #820, verified LIVE 2026-09-19):** Charlotte wants light/dark versions to KEEP colour where it reads (Core's gradient C approved on white and black), not flat mono. backgroundVersion() judges per colour group (contrast >= 2.2 OR Lab difference >= 40), gradients as one group, badge plates and enclosed shapes untouched; staff can override per colour in the studio. Mono files kept only for single-colour print.

**2026-09-19 round 5 (branch feat/logo-palette-roles, pushed, PR pending):** Schneider curve fitting + despeckle/presence fixes for smoother SVGs; 5-colour palette (3 core ticked + text + background, "Brand: … Text: … Background: …" in brand_colours); sample text "This is a headline / sub headline / body…"; client page = logo on white | on dark, then colours/fonts/icon row (PublicShell wide), complete package + individual files dropdown, format advice per place. Brand guidelines redesign ON HOLD: Charlotte wants to talk it through first. Harness note: headless 'new' mode stopped painting on this machine, use headless: 'shell'.

**2026-09-19 round 6 (merged #822, SQL applied + verified 2026-09-19):** 7-page guidelines; mockup upload (kind 'mockup', PNG); approval gate: files hidden until approved (migration 20260919120000_logo_approval_gate.sql, Charlotte to run by hand: RPC returns only preview_* + mockup pre-approval, submit rejects approve+notes, signoff_history, approval ticks client_onboarding.checklist.logo_design); approval terms DRAFT in src/lib/logoApprovalTerms.js (logo-approval-v1, needs Charlotte/solicitor check); staff feedback card + Resend for approval; actions "Logo feedback from X" red + "X approved their logo" green; boardCards folds done tracks during onboarding. Open ideas offered: tone of voice, photography style, applied examples (van/email signature/social).

**2026-09-19 round 7 (merged, LIVE 2026-09-19):** delivery link card = Copy / Preview / one adaptive Send button (review, "Send updated version" reopens review after feedback, "Send download link" after approval) via SendEmailModal + src/lib/logoEmail.js (kinds logo_review/logo_delivery). Blocked states from logoSendState/logoPackStaleReason in crewDeliverables.js. Removed Resend button + Notes box on logo page; studio button now "Build brand pack". Charlotte wants no duplicate buttons doing the same job.

**2026-09-19 round 8 (branch feat/logo-where-to-use, commit 640fe3e, pushed, PR pending):** where-to-use as icon cards with plain-English `use` + `file` fields (APPLICATION_CHECKLIST_ITEMS, also feeds guidelines p4); studio On white/On dark preview shows backgroundVersion output. Charlotte wants client-facing copy jargon-free.

**2026-09-19 round 9 (branch feat/logo-brand-inks, commit 53fcc1a, pushed, PR pending):** light/dark versions recolour with the brand text/background colour (backgroundVersion `inks`), client page font card bigger headline + panel + brand text colour, bigger icon, approval note trimmed, guidelines cover "DELIVERED BY" + IH logo, favicon snippet sizes="32x32" + site.webmanifest. Core's palette: Brand #038DAD #6DEC8B #05C7EB, Text #333333, Background #F8F8F6, fonts Montserrat/Roboto.

**2026-09-19 end state: build complete end to end, all merged (#815-#830) and verified live.** Core Electrics rebuilt on latest code 12:17 UTC (grey #333333 lettering, "Delivered by" cover), test feedback cleared via SQL, ready for "Send to client". Open items for Charlotte: check approval disclaimer wording (logoApprovalTerms.js, ideally solicitor), optional guideline extras (tone of voice, photography, applied examples). Gotcha seen: building right after a merge ran the OLD bundle in a stale tab; hard refresh before rebuilding.
Handoff 2026-09-19: logo-studio worktree + 10 local branches removed (content verified on main); remote feat/logo-* branches still on GitHub for the branch-cleanup backlog; handoff note passed to Charlotte's other session to write into docs/current-handoff.md.

---
name: project_client_weekly_reports
description: "Clients > Reports weekly client report — design/logic state + next-session items"
metadata:
  node_type: memory
  type: project
  originSessionId: abb305e4-98ac-4841-82a4-26eb4e794ede
  modified: 2026-08-10T14:15:11.131Z
---

Clients > Reports (`/clients/reports`): per-retainer-client weekly performance report, InstallrHub-branded, becomes a print/PDF. Files: `src/pages/hub/ClientReports.jsx`, `src/components/reports/ReportView.jsx` + `WeeklyNumbers.jsx` + `BenchmarkReference.jsx`; libs `reportNarrative.js`, `reportBenchmarks.js`, `reportStats.js`, `reportEmail.js`.

**Big design+logic pass shipped 2026-07-27 (merged):** Concept 1 unified metric cards (value + "vs last wk" delta + "last wk X · avg Y" line + rating chips; compare toggle hides ALL comparison when off), auto **Summary** block (renamed from "In plain English"), hand-built SVG **Momentum** twin panels (cost per lead + cost per booking, each with expected band; NO leads bars; auto-hidden under 4 weeks with an operator toggle), **journey** labelled by elapsed time (Launch/30/60/90 days) with a "Now" pinpoint at the true fractional position, Since-launch band + cost-per-survey tile, auto-saved "Saved reports" list (mail-tick when sent), tidy print pagination.

**Narrative rewritten 2026-08-10 (#549, #551) — the hero is the report's copy now.** `weekTone()` classifies every week as **good / steady / setback** off two axes kept separate: LEVEL (cost per lead vs the corridor for the campaign's age) and TREND (week on week, sub-10% = flat). setback = the week moved materially backwards OR the level is genuinely off target (past the corridor by >EARLY_GRACE at any age, or past it at all once mature). good = not a setback AND (beating the corridor OR moved forward). steady = everything else, and exists so the honest majority of weeks are neither dressed up nor written down. Tone picks the template AND the order of the four beats (cost, surveys, trend, run rate); a setback caused by the WEEK pulls the trend ahead of surveys so the decline is read early, one caused by the LEVEL already leads with it.
Also: the auto **Summary** block is now OFF by default (it duplicated the hero word for word); it only prints if an operator writes one, with "Draft from the numbers" to pull the long version in. Prose spells small counts + campaign age in words ("month one", "Three leads"); money/percentages stay digits. `fmtRate` is shared by hero chip + prose so they can't disagree.

**HONEST narrative (critical — do not regress):** phase-aware verdicts — a mature (month 3+) campaign below its range reads "Off target" / "above the range we'd want", NEVER "settling in / normal this early"; small-sample guard `LOW_VOLUME_LEADS=4` suppresses rate chips/pills so 100% lead-to-booking off 1 lead isn't celebrated. A struggling client must not see delusional spin.

**Benchmarks now editable** via Parameters > "Client report benchmarks" (`marketing_parameters` group `reportBench`, flat scalar params generated from `DEFAULT_PHASES`). `reportBenchmarks.js` exports `let PHASES/BENCHMARKS` (ES live bindings) + `applyReportConfig(rb)`; ClientReports calls it from `useParametersCtx`. PR `feat/report-benchmark-params` (confirm merged).

**Verify method (use it, don't ship report changes blind):** dev-only `/__reportpreview` (`src/pages/ReportPreview.jsx`, local/uncommitted) renders ReportView with fixtures, no auth; screenshot/PDF via headless Chrome (`--headless=new --print-to-pdf`, `print-color-adjust:exact` keeps backgrounds). recharts printed clunky → momentum is hand-built SVG now.

**NEXT SESSION (agreed):** (1) hosted client report page `crew.installrhub.com/:slug/report` (slug-first, reuse the crew ClientApp pattern + crew-report-style edge-fn-by-slug + `hasClientSession`) + **server-side PDF** (reliable 1-page; the browser zoom-to-fit was unreliable — `reportPrintFit.js` is a parked stub) + **link-only email** (rework `buildReportEmail` → warm, figure-free, no catch-up, one "View report" button pointing at the hosted URL). Serafim deps: apply `client_reports` table (still pending) + a token/slug data edge fn. (2) **lead-only clients**: drop bookings metrics (cost per booking, lead-to-booking, surveys).

**Today's fallback:** email still has figures + catch-up; PDF = 2 pages, clean breaks, via Chrome Save-as-PDF + Background graphics ON. Uses [[reference_marketing_rpc_guards]] (rpcCached) for the shared DB; leads model per [[reference_lead_counting_model]].

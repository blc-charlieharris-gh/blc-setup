---
name: project_crew_audit_funnel_build
description: "CREW audit-funnel build scope + decisions (scoped, not started as of 2026-07-07) and the HQ curated-override"
metadata: 
  node_type: memory
  type: project
  originSessionId: d440ca97-e5b8-4c5d-9314-6d5bc68801a5
---

The CREW audit-funnel build (turn the hand-built SiteScore quality into an on-demand + on-form-submit auto engine, then the client dashboard). Scoped but NOT started as of 2026-07-07.

**Decisions made:** screenshots via **ScreenshotOne free tier** (recommended, awaiting final confirm; OpenRouter cannot screenshot, it is LLM-only; Microlink free gives only whole-page, no section slices). URL is **slug-first**: `crew.installrhub.com/<slug>/installrscore` (confirmed, matches code + spec).

**Why queueing is needed:** `api/crew-audit.js` runs all evidence-gather + a single OpenRouter vision call in ONE request with a 240s model timeout, which exceeds Vercel's serverless limit. Split into per-pillar steps (the staff console already calls `runAudit(id, pillar)` per pillar) and drive them sequentially.

**Screenshot infra gap:** Puppeteer can't run in a Vercel fn. Hand-built quality depends on section-sliced shots (the `clip`-loop in `site-greentide/post-booking/generate-pdf.js`). ScreenshotOne selectors/clips are the low-effort path; self-hosted `@sparticuz/chromium` is the fallback.

**Phases:** 1) section-sliced capture + de-timeout per-pillar (frontend/`api` only, no Serafim); 2) trigger on-demand (staff) + on-form-submit (public landing, needs Serafim's `crew-request-public`), queued; 3) password-gated prospect report reading the real DB (needs Serafim `crew-report` read path / RLS); 4) prospect→client: intake sets own password (needs Serafim client-auth backend), same URL then resolves to the dashboard (`ClientDashboard.jsx` stub exists).

**HQ Group audit:** now a bundled curated override, NOT from the DB/auto-engine. `crewSeedAudits.js` holds the official site+social audit; `CrewContext.fetchClients` replaces the DB row's `scores` for any `SEED_AUDITS` slug. See [[project_crew_workspace]] and [[project_sitescore_method_and_crew_gap]]; limitation logged in known-issues (a re-run audit is ignored until the slug is dropped from `SEED_AUDITS`).

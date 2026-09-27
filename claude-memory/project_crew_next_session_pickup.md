---
name: project_crew_next_session_pickup
description: "Handoff for the next session (after 2026-07-08): build today's hand-built audit intelligence into the CREW auto-engine, plus the parked CREW items"
metadata: 
  node_type: memory
  type: project
  originSessionId: 5da3a23e-b254-47a3-aeeb-fed5f043d9d8
---

Pickup for the session after 2026-07-08. Today we hand-built a very strong Heatzen + Proximus website audit (now LIVE at installrhub.com/sitescore/heatzen, pw `heatzen`; the client is Proximus Solutions Ltd, passed on manually). The whole point of tomorrow: **fold that audit's intelligence + design quality into the CREW auto-audit engine** so it produces this bar automatically.

**The reference audit** (study it, it is the target): `meta-access/outputs/sitescore-heatzen/` — `report.src.html` (source), `build-report.mjs` (inlines gauges + base64 imgs + InstallrHub SVG), `build-gated.mjs` (pw gate), `report-img/` (crops). Deployed via a `sitescore/heatzen` branch in installrhub-static.

**What "next level of intelligence" means (build into `api/crew-audit.js` + the CrewReport generator):** everything in [[project_crew_audit_engine_learnings]] — that file is now the full spec. Headlines:
1. Headless-browser capture worker (Cloudflare-proof) modelled on `site-greentide/post-booking/capture-audit.js`; crawl money pages not just home.
2. Detections: trust-asset under-use (Trustpilot collection-badge vs TrustBox), schema/topic-vs-goal mismatch, missing/blank OG image, sister-site ownership, Google Safe Browsing "Dangerous" flag.
3. The "two businesses / one front door" + merge-under-trusted-brand diagnosis pattern.
4. The signed-off **cost-of-gap worked-example box**: close-rate lever on their existing survey pipeline, MARGIN not revenue (~£2k-£4k/job), visible sum, no promise, sourced. Exact final copy in the reference file + the learnings memo.
5. The InstallrHub house-style report (co-brand, scores front + tabbed, findings with shots, roadmap), equal depth per site on multi-site audits.

**Also parked (from 2026-07-08 session), pick up when relevant:**
- **CREW website-builder** big plan: **RECOVERED + PERSISTED 2026-07-09 to `marketing-agent/docs/crew-website-builder-plan.md`** (was scratchpad-only and nearly lost). Full 6-phase plan: Task A copy 4 audits + simple-pw prospect gate, B audit a new client, C build Arktek's site as the first real `website-factory` job, D1 template gallery (factory→builder, biggest new piece), D2 merge OG `/sites` intake into CREW intake (superset), D3 build→gated preview (pw+noindex), D4 new Site-QA engine (SEO/speed/security/a11y/pixel/GA/links/sitemap/OG), D5 review/approve/billing, D6 paid→live/transfer. marketing-agent now free. crew_clients has arktek loaded; gasworx+synergi seed rows still pending Serafim.
- **HQ Group Client-tag bug:** 2-line fix in `marketing-agent/src/pages/hub/Crew.jsx:330` — the chip there uses `brand_type` (shows "Client" for prospects) while the header chip uses `recordKind`. Make :330 use recordKind or drop it. DB is already correct (packages all false).
- **Serafim's 3 open items** still stand (see [[project_crew_serafim_open_items]]): count-all-spend RPC line, crew-request-public edge fn, seed migration.
- **Green Tide solar calculator** to build ([[project_greentide_solar_calculator]]).

See [[project_crew_audit_engine_learnings]], [[project_crew_workspace]], [[project_sitescore_method_and_crew_gap]].

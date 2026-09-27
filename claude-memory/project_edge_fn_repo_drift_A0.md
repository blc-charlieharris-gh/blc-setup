---
name: project-edge-fn-repo-drift-a0
description: "Two live edge fns (meta-sync v42, marketing-status-check v19) were dashboard-hotfixed 2026-07-30; repo copies are behind live and must be mirrored or next deploy reverts the fix"
metadata: 
  node_type: memory
  type: project
  originSessionId: e306d040-3199-4d38-bd90-f2686f851312
---

Handoff from a parallel session (2026-07-30). Two Supabase edge functions were hotfixed straight to the LIVE project via the dashboard (that session's MCP was read-only), so the repo copies are now BEHIND live. Nothing is broken now; risk is that the next `./scripts/deploy-edge.sh` of either fn REVERTS the live fix. Live = source of truth (Supabase dashboard → Edge Functions → Code).

**Functions to sync:**
- **meta-sync (live v42)**: per-creative Instagram thumbnail fallback. For any ad whose `creative.thumbnail_url` is blank: `GET /{creative_id}?fields=effective_instagram_media_id` then `GET /{ig_media_id}?fields=media_type,media_url,thumbnail_url`, set `thumbnail_url = thumbnail_url ?? media_url` (try/catch, blank ads only). DO NOT add `effective_instagram_media_id` to the bulk `/ads` `creative{...}` expansion, that was broken v41 (Meta 500s Greentide full sync, "reduce the amount of data"). See [[feedback_matcher_thumbnails_root_cause]].
- **marketing-status-check (live v19)**: no-leads tripwire removed (`leads_ok` no longer feeds `clientIsRed()`, floor const + dedup gone). See [[feedback_never_starve_shared_prod_db]].

**Do:** copy each `index.ts` from the dashboard over `supabase/functions/<fn>/index.ts`, commit, PR. No behaviour change vs live. Exact deployed source already staged in marketing-agent repo at `.claude/docs/tier2-deployed-source/` (README + both index.ts); logged as item **A0** in `.claude/docs/serafim-pending.md`; merge PR `docs/tier2-deployed-source` if not already merged.

**Guardrail:** do NOT run `deploy-edge.sh` for either fn from the old repo before the mirror.

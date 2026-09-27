---
name: feedback-serafim-signoff-and-handoffs
description: "Never bypass Serafim's sign-off; instead make cross-repo handoff notes surgical and fully actionable"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: d2dc718a-d398-4063-a361-62506810f62a
  modified: 2026-09-17T17:25:22.514Z
---

Never self-deploy or otherwise bypass Serafim's review/sign-off on shared-Supabase or his-repo changes (edge functions, migrations, the InstallrHub app). The fix for slow ping-pong is NOT to do it yourself, it is to make the handoff note so clear his Claude executes all of it in one pass.

**This rule is Tier-2 ONLY. Do not over-apply it (2026-08-10).** `marketing-agent`'s CLAUDE.md is
explicit: trunk-based, branch off `main` → PR → **self-merge when the build is green**. The other
dev's review is required only for **Tier-2**: `supabase/migrations/**` or edge fns, because the DB
is shared. Ordinary app code, docs and UI are **Tier-1** and Charlotte merges them herself.
The repo living on `serafimparente-blc/marketing-agent` does NOT make it his to gate: Charlotte has
`push: true` (check with `gh api repos/<owner>/<repo> --jq .permissions` rather than inferring from
the org name). Blocking a Tier-1 change on Serafim wastes her time and she will, correctly, push
back. When unsure which tier: does the diff touch `supabase/migrations/**` or an edge fn? If no,
it's hers to merge.

**Who applies a migration: ask, don't assume (corrected 2026-09-17).** The old rule here said
"Charlotte never runs SQL herself, all DB applies go through Serafim, always." That is no longer
right. For the hub-only `pipeline_board` migration she asked "whats the sql", took it, ran it in the
Supabase SQL editor herself, and confirmed. She also pushed back hard when I framed a hub-only
migration as needing Serafim at all: "why is serafim needed this is being pushed to my internal no?"
See [[hub-only-migrations-no-serafim-review]] — I over-applied that rule and she was right.

Current shape: for a Tier-2 change that genuinely touches shared surfaces, Serafim reviews. For a
hub-only migration, it is hers to merge AND hers to apply if she wants to. Give her the SQL
paste-ready (write it out as your own text, not a tool result, per
[[paste-ready-code-must-be-own-text]]) and let her choose. **You still cannot apply it yourself**:
the auto-mode classifier blocks writes to the shared prod DB ("Modify Shared Resources"), and the
Supabase MCP has no `apply_migration` tool, only read-capable `execute_sql`. Reads through that MCP
work fine and are the right way to verify afterwards.

Practical notes from that apply: Supabase's editor warns "this query includes destructive
operations" on any script containing DROP or ALTER, even when nothing exists yet. Check reality
first (`pg_tables` / `pg_proc` / `pg_policies`) and say plainly whether it is a real finding; also
offer the script with the unnecessary `drop policy if exists` removed. Merging a PR does NOT apply
migrations: per `.claude/docs/deploy-runbook.md`, "The Vercel pipeline only builds + serves the SPA.
It does not touch edge functions or migrations."

**Scope (Charlotte, 2026-06-22):** the Serafim sign-off rule is an InstallrHub / shared-infra / his-repo thing ONLY. It does NOT apply to the Green Tide site (`site-greentide`, Vercel project blc-promotions/greentide), which is BLC's own lead-gen brand. Claude may deploy Green Tide to prod (`vercel deploy --prod --yes --scope blc-promotions` from `site/`) with Charlotte's go-ahead, no Serafim sign-off needed. See [[project-greentide-site]].

**Why:** Charlie (2026-06-04) was frustrated that the blog + meta-sync items kept bouncing. Root cause was a vague note, not Serafim being slow: "redeploy the main app" was ambiguous (his Claude redeployed/relied on app.installrhub.com where the post already showed, and never touched the stale public www site), and meta-sync was phrased "whenever you get to it" so it was deprioritised and skipped. Charlie's words: "we should never be avoiding serafims sign offs, i just want to streamline, your original handoff clearly wasnt clear enough."

**How to apply:** For anything that lands in Serafim's repo / shared infra, write the note with: (1) DONE items explicitly marked NO ACTION so they aren't redone; (2) the exact file + exact before/after diff; (3) the exact deploy command (e.g. `./scripts/deploy-edge.sh meta-sync`); (4) any data-heal step (e.g. re-invoke with `client_id`); (5) a copy-paste verification (curl/SQL) with the expected result. Name the exact surface (which Vercel project / which domain), never "the app." Do not start a production deploy on shared infra without an explicit "deploy it" from Charlie. See [[reference-installrhub-domains]].

---
name: reference_internal_installrhub_is_marketing_agent
description: internal.installrhub.com is now served by the marketing-agent repo (the merged Hub); the old internal-installrhub repo is archived
metadata: 
  node_type: memory
  type: reference
  originSessionId: d7f4619a-b326-408f-a1d0-4937bf075174
---

**The `internal.installrhub.com` DOMAIN is now served from the `marketing-agent` repo**, not the old `internal-installrhub` repo. Confirmed by Charlotte 2026-07-05.

- `marketing-agent` (React 19/Vite/Tailwind/Supabase, at `marketing-hub/marketing-agent/`, origin `github.com/serafimparente-blc/marketing-agent`) is the **merged Hub**: it absorbed the client-site-generator + blog. Its routes include the ads command center (`/`, `/performance`, `/creative-testing`, `/ai`, etc.) AND the hub surfaces `/sites`, `/sites/:id`, `/blog`, `/branding`, `/users` (pages in `src/pages/hub/`). `/sites` reads Supabase table `hub_clients` via `ClientsContext`. Nav is `src/components/layout/navItems.js` (sectioned `NAV_SECTIONS`).
- The old **`blc-charlieharris-gh/internal-installrhub` repo is ARCHIVED** (read-only on GitHub, last push 2026-05-29). It was vanilla-HTML + Vercel serverless + GitHub-JSON (`data/clients.json`). A local clone sits at `internal-installrhub/` in the BLC root; treat it as dead/reference only, do NOT push to it.
- This SUPERSEDES the older memories [[reference_vercel_domains]] and [[reference_installrhub_domains]] which mapped internal.installrhub.com to `client-site-generator` and website.installrhub.com to marketing-agent. The client-site-generator = the now-archived internal-installrhub.

So: to change anything behind internal.installrhub.com (incl. the CREW tab, see [[project_crew_workspace]]), work in `marketing-agent`. Its git status/eslint/esbuild hang (incomplete node_modules) — commit via temp-index plumbing on origin/main, hand push to user; see [[feedback_commit_via_temp_index_on_main]] and [[reference_git_auth]].

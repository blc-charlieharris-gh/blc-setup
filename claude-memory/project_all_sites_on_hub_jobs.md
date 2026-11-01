---
name: project_all_sites_on_hub_jobs
description: Since 2026-11-01 every client website lives only on its Hub job (build files zip); no client folders in the repo or on devices; hosted blogs kept up by the Hub's daily run
metadata:
  type: project
---

Since 2026-11-01 every client site, Gas Worx included, lives only on its Hub website job as saved build files
(Supabase `client-site-files/<hub_client_id>/source.zip`). `website-factory/clients/` is gone from the marketing-agent
repo, the gasworx-soro-sync GitHub Action is gone, and this Mac holds no client site. To work on a site: Download the
build files (or a fresh AI kit) from the job, change it, Save the build files, then delete the local copy. Hosted sites
whose Their blog (step 12) has a feed get new posts from the Hub's daily run at 05:23 UTC (plan-site-blogs.md).

**Why:** Charlotte (10-31/11-01) wants nothing depending on a device or the repo, so she and Erin can both work from the Hub.
**How to apply:** never re-add a client folder to the repo or a per-client robot; when moving off Supabase
([[project_leaving_supabase_for_cloudflare]]) the client-site-files bucket must come too. Related:
[[feedback_client_site_changes_via_hub_not_merge]].

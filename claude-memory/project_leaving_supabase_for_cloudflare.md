---
name: project_leaving_supabase_for_cloudflare
description: Charlotte plans to move off Supabase to Cloudflare soon (said 2026-11-01); Supabase usage-limit warnings are fine until then
metadata:
  node_type: memory
  type: project
  originSessionId: d80fdc4c-8731-452e-ae2a-31cef37fe874
  modified: 2026-11-01T10:21:07.518Z
---

Charlotte (2026-11-01): "we're leaving supabase soon for cloudflare, its fine for now", when the InstallrHub project showed "Exceeding usage limits".

**Why:** a planned platform move, not yet scheduled in anything I've seen.
**How to apply:** don't chase Supabase usage warnings or plan big Supabase-only investments. Anything stored in Supabase storage (client site build zips in `client-site-files/<hub_client_id>/source.zip` and `site.zip`, see [[feedback_client_site_changes_via_hub_not_merge]]) must be carried over in the move.

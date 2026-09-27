---
name: installrhub-dashboard-repo-not-local
description: "app.installrhub.com's source (serafimparente-blc/InstallrHub-Dashboard) is not cloned anywhere under BLC — only reachable via Supabase MCP"
metadata: 
  node_type: memory
  type: reference
  originSessionId: 7dcaef2d-315e-45ea-9443-0b77866f1529
  modified: 2026-09-03T07:45:21.389Z
---

The actual `app.installrhub.com` dashboard frontend (`serafimparente-blc/InstallrHub-Dashboard` on GitHub) is **not cloned locally** anywhere under `/Users/charlotteharris/Documents/BLC`. Confirmed by an exhaustive Explore agent search (grepped for Supabase auth calls, dialer-specific code, checked every local `.git` remote) on 2026-09-02: zero hits.

What IS local, and easy to mistake for it:
- `site-installrhub/installrhub-static/` — the public marketing site (installrhub.com), see [[reference_installrhub_git]]. Not the dashboard.
- `internal-installrhub/internal-hub` — serves internal.installrhub.com / website.installrhub.com, a client-microsite generator. Not the dashboard.
- `marketing-hub/marketing-agent` — serves internal.installrhub.com / crew.installrhub.com / website.installrhub.com. Shares the **same Supabase project** as the real dashboard app, but is a different codebase.

**Why:** All three local repos share the InstallrHub Supabase project (`ozmyjrzleejbqxqphbut`), which makes it tempting to assume one of them IS the dashboard. It isn't — the dashboard's source simply isn't checked out anywhere in this tree.

**How to apply:** For anything about app.installrhub.com's actual frontend behavior (sign-in flow, error strings, component logic), don't burn an Explore agent searching BLC for it — it's not there. Reason instead from the shared Supabase project directly (schema, auth.users/profiles state, RLS) via the Supabase MCP, the same approach [[project_installrhub_dialer_stuck_call]] and the `fix-stuck-agent-call` skill already use. If real source-level detail is ever needed, the repo would have to be cloned first.

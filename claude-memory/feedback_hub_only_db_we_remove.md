---
name: feedback-hub-only-db-we-remove
description: Hub-only DB objects (tables, crons, RPCs) we remove ourselves; Serafim only gets items that affect the app
metadata:
  type: feedback
---

When archiving or cleaning up, database objects only the Hub uses (tables, pg_cron jobs, RPCs, Hub edge fns) are removed by us: a Hub-only migration that Charlotte runs. Only things that touch the InstallrHub app, or that change affects him, go on Serafim's end-of-audit list.

**Why:** Charlotte 2026-09-29: "serafim may not want it, only if it impacts him should he need it."

**How to apply:** before listing something for Serafim, check whether the app or its tables use it (FKs, views, app-side writers). If Hub-only, write the SQL ourselves. See [[feedback-hub-only-migrations-no-serafim-review]], [[feedback-serafim-items-batched-at-end]].

---
name: feedback_textedit_stale_window_paste_deploy
description: open -e on a paste file TextEdit already has open shows the OLD text; a stale hub-action-alerts got deployed 10-16
metadata:
  node_type: memory
  type: feedback
  originSessionId: 69a9ec87-cc18-4cd6-af26-1ee194941677
  modified: 2026-10-28T14:04:42.285Z
---

`open -e <file>` on a file TextEdit already has open just brings the old window forward, without reloading. On 2026-10-16, hub-action-alerts was opened once for a morning deploy, rebuilt later, then "opened" again; Charlotte pasted from the stale window and the live function lost two changes (v45 = old code).

**Why:** the paste file name was reused within one session, and TextEdit doesn't reload on open.

**How to apply:** for a second paste of the same function in a session, copy to a fresh name (`<fn>-<date>b.ts`) before `open -e`, and after every paste-deploy compare the live code (get_edge_function) against the local file rather than trusting the version number. Also (2026-10-19): words typed into the open TextEdit window land in the paste file itself ("did i // @ts-nocheck" failed to bundle). Tell her not to type in that window, and if a deploy fails to parse, rebuild a fresh copy from the repo (bundle-edge-fn.py), never reuse the edited file. Same for SQL (2026-10-28): a stray "y" typed into the window made the SQL fail silently ("done" but nothing ran); after she says SQL is done, check the object exists, and if not, `xxd` the _deploy file's first bytes, then copy a fresh one from the repo migration and say "click in, Cmd+A, Cmd+C, type nothing". Related: [[feedback_paste_deploy_open_the_file]]

---
name: feedback_her_tab_runs_old_code_after_merge
description: After a Hub merge, check the live bundle has the change, then tell her to hard reload before she tests
metadata:
  type: feedback
---

10-19: twice Charlotte pressed a button straight after merging and got the OLD behaviour (Publish moved J&B to With the
client again), because her open tab still ran the previous build.

**Why:** a merge takes a few minutes to go live and an open tab keeps the old code; she reads the old result as "it
doesn't work".
**How to apply:** after she merges, wait for the Vercel Production deploy to be Ready, grep the live App chunk for a new
string, then say "live now, hard reload (Cmd+Shift+R)" before giving her the steps. Related: [[feedback_build_check_every_pr]].

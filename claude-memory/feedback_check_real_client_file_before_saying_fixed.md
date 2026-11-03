---
name: feedback-check-real-client-file-before-saying-fixed
description: "Logo/visual fixes - run the change on the client's actual file and the exact button she pressed before saying fixed (Energe 11-03 took 4 rounds)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: c1ff63d7-3e6d-4b10-b706-b8126aca76b9
  modified: 2026-11-03T11:19:44.543Z
---

Before telling Charlotte a visual fix (logos, dark versions, traces) is done, run it on the client's real file through the
same path she used (Make the dark version vs Make SVG vs Keep are different code paths) and look at the output.

**Why:** Energe's dark logo on 2026-11-03 took four merges: lazy-load placeholder, white box/letter holes, grey edges,
then the Make SVG window's hasLightLettering guess, then a 60s storage cache serving the old blank. Each time I fixed one
path and said "should be right"; she got angry ("YOU'RE NOT MAKING IT BETTER"). Her ask was simple: black text white on dark.

**How to apply:** ask which button/screen she used (or read her screenshot) first; reproduce on the real stored file;
check every path that produces the same output; only then push. Related: [[feedback_storage_overwrite_read_back_stale]].

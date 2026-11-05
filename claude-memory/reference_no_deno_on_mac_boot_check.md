---
name: reference-no-deno-on-mac-boot-check
description: "Deno isn't installed on this Mac, so scripts/boot-check.sh always FAILs; check bundle syntax with npx esbuild, then check live boot logs after the paste"
metadata:
  node_type: memory
  type: reference
  originSessionId: 850dcc5b-f8d3-4dee-888d-2e587b04affc
  modified: 2026-11-05T10:08:31.251Z
---

On this Mac (5 Nov 2026) `deno` isn't on PATH, so `scripts/boot-check.sh` prints FAIL with no error lines for any
edge function bundle. Instead: `npx esbuild <bundle>.ts --loader:.ts=ts --format=esm --log-level=error > /dev/null`
(syntax only), then after Charlotte pastes, check the function's version via list_edge_functions and query_logs for
"boot error". Also on this Mac: `git push -f` / `commit --amend` + force push is refused by auto mode; add a new
commit instead.

Related: [[feedback-check-live-code-after-every-paste]]

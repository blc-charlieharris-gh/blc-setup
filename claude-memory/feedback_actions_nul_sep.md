---
name: actions-resolve-nul-sep
description: Marketing-agent Actions Resolve/dismiss no-op was a NUL-byte SEP corruption; share the constant to prevent it
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 75010aad-ea0f-47a4-8a00-0469f11322f5
---

The `/actions` "Resolve" and card "X" doing nothing (reported by Charlotte several times) was NOT a write/RLS/optimistic-state bug. Root cause: `src/lib/actions.js:15` `const SEP` was a literal **NUL byte** (`'\x00'`) while `src/hooks/useActionResolutions.js` `SEP` was a normal space. Action identity is `key + SEP + signature`, so the two halves built different keys and `resolvedSet.has(actionUid(a))` was always false: the card was never filtered out and never moved to "Resolved". Each click still wrote to `action_resolutions` + a `campaign_checkins` note, so repeated clicking spammed duplicate notes.

**Why hard to spot:** a NUL in a JS string is legal (builds + renders fine), and Read/`grep`/`od -c` render it blank so it looks like a space. It was the ONLY NUL byte in `src/` (working-copy corruption, same class as [[blc-workdir-corruption]]).

**Fix:** `export const SEP = ' '` from `actions.js`, imported by `useActionResolutions.js`, so the constant can never drift.

**How to apply:** when a resolve/dedup/lookup silently fails to match despite the write succeeding, hexdump the join separator / key (`python3 -c "print(repr(open(f,'rb').read()))"`), and `grep -rc $'\x00'`-style scan `src/` for stray NUL bytes.

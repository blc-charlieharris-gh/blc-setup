---
name: feedback-rebuild-deploy-files-before-paste
description: Always rebuild ~/Code/BLC/_deploy edge fn paste files right before Charlotte pastes; they are not synced between Mac and laptop
metadata:
  node_type: memory
  type: feedback
  originSessionId: 71d9eefa-1cc8-4bcb-9d47-42166ae1ad36
  modified: 2026-09-29T18:50:04.462Z
---

Always run `python3 scripts/bundle-edge-fn.py <fn>` (in marketing-agent, on up-to-date main) and `scripts/boot-check.sh` right before handing Charlotte an edge fn to paste, then `pbcopy < ~/Code/BLC/_deploy/<fn>.ts` one function at a time. Never trust files already sitting in `_deploy`.

**Why:** 2026-09-29 the Mac's `_deploy` still held 28 Sep copies while the #1164 versions had been built on the laptop; `_deploy` is not in git or blc-sync, and the handoff note wrongly said the Mac had them. Pasting would have put old code live.

**How to apply:** rebuild every time, whichever machine; give her the code via clipboard one by one (she asked for that), not in chat. See [[reference-blc-supabase-cli-wrapper]], [[feedback-paste-ready-code-must-be-own-text]].

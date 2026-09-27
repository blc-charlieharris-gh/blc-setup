---
name: feedback_artifact_publish_auto_opens
description: Charlotte finds artifact pages auto-opening on every publish disruptive; edit locally and only publish when she asks
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 486cbb86-5f13-43e5-9975-9df3a188183f
  modified: 2026-09-22T14:57:41.324Z
---

Every Artifact publish pops the page open in front of Charlotte, and she said it interrupts her (2026-09-22, while editing Erin's onboarding page, see [[project_erin_onboarding_plan]]). Publish has no option to stop this; `auto_open` only applies to creating from a type.

**Why:** she's working in other windows while Claude makes rounds of small edits.
**How to apply:** make edits to the local file, describe the change in chat, and publish only when she says to (or once, at the end of a batch she's signed off). Never call `action: "open"` unless she asks.

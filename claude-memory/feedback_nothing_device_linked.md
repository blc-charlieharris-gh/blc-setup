---
name: feedback-nothing-device-linked
description: "Charlotte doesn't want anything tied to one machine: no new local-only keys, files or setup; anything a later session needs goes in GitHub or a shared service"
metadata:
  type: feedback
---

Charlotte (2026-10-05): "I don't want anything linked to a device." She works on a Mac and a laptop, one at a time ([[reference_device_switching_blc_setup]]).

**Why:** a notes key that existed only on the Mac would have quietly broken Hub notes on the laptop. She only found out from a closing remark.
**How to apply:** don't create new secrets or state that live in one machine's files. Prefer auth that's already on both machines (e.g. hub-note checks the Meta token, [[feedback-log-client-meta-changes-in-hub]]), and put work files that matter in git (never keys or videos). If something device-local is truly needed, say so up front and plainly. Goal on the end-of-audit security pass (queued with the Hub session 10-05): one master set of keys both machines read (password manager), plus clearing junk .env lines.

---
name: reference-openrouter-key-location
description: "Local OpenRouter key lives in ~/code/BLC/.env.local (OPENROUTER_API_KEY); was dead (401 \"User not found\") on 2026-09-30, needs a fresh one from Serafim"
metadata:
  node_type: memory
  type: reference
  originSessionId: c9743f89-10d9-4cb9-9a11-64461f10cc18
  modified: 2026-09-30T15:12:42.811Z
---

The only local OpenRouter key is `OPENROUTER_API_KEY` in `~/code/BLC/.env.local` (workspace root, not a repo). marketing-agent's `.env.local` has it blank because it's a Sensitive Vercel var; Hub/Supabase copies are write-only.

On 2026-09-30 that local key returned 401 "User not found" from `openrouter.ai/api/v1/key` (revoked or account removed). Charlotte has no OpenRouter login; Serafim issues keys. When a new one arrives, replace the line in that file.

Used by `meta-access/outputs/gasworx-video/gen_music.py` (Lyria 3 music for ads, see [[project-gasworx-video-montage]]). Never grep the filesystem for keys: the auto-mode classifier blocks it as credential exploration; ask Charlotte where the key is.

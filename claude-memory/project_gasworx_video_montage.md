---
name: project-gasworx-video-montage
description: Gas Worx heat pump ad montage (09-30): local edit pipeline in meta-access/outputs/gasworx-video, v2 silent 20s done, music blocked on OpenRouter key
metadata:
  type: project
---

Gas Worx = heat pump installer (not solar). Footage: 26 DJI vertical clips from Drive folder 16BdhZ7h0h8gsRpi79-Kgr39F8zXK2TiA (link-shared), in `meta-access/outputs/gasworx-video/raw/` (gitignored). No install-in-progress footage, mostly engineer talking to camera + oil-to-heat-pump job; 0483/0484 downloads were cut off at the 1h limit, unchecked.

Pipeline (chosen over Borumi, which has an MCP but is for talking-head recording): `edit.py` shot list -> ffmpeg 9:16 + 4:5, captions/end card are Chrome-headless PNGs in `work/gfx/` (site font + colours). `gen_music.py` = Lyria 3 via OpenRouter, MUSIC slot in edit.py. Remotion installed in meta-access/video-studio but unused (licence >3 staff).

State 2026-09-30: v2 = 20s, no end card (Charlotte: "no end card"), silent. She can't add music in Meta for uploaded video, so music must be baked in. Blocked on a working key, see [[reference-openrouter-key-location]]. Website changes for Gas Worx still not specified; worktree `marketing-agent-gasworx` on feat/gasworx-updates-0930 is empty.

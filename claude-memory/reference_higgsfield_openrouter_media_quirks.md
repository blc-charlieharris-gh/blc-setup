---
name: higgsfield-openrouter-media-quirks
description: Higgsfield CLI hangs when backgrounded/parallel; voice ids via `higgsfield voices list`; OpenRouter Gemini is text-only, Lyria needs stream:true
metadata:
  type: reference
---
- Higgsfield CLI (1.1.26, updated 13/10; old 0.1.x login is refused): run `generate create ... --wait` in the FOREGROUND, one at a time. Backgrounded or parallel calls hang with no job created. Needs `higgsfield workspace set 07bf0227-6667-47e7-9e89-a4ddcce65d48` (BLC Promotions) after login.
- ElevenLabs v4 on Higgsfield: `--dialogue '[{"text":..,"voice_type":"element","voice_id":<uuid>}]'`; ids from `higgsfield voices list` (James-Professional-British-Male = 3a91faa7-359c-4f75-9196-f903dadfbb67). Spell names as said ("Installer Hub").
- OpenRouter (key in ~/code/BLC/.env.local, quoted value, strip quotes): google/gemini-3.8-flash is text only (no voice). Lyria music needs `"stream": true` and assembling base64 audio deltas (meta-access `access-videos/shared/music.py`).

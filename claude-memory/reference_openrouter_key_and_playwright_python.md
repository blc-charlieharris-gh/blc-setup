---
name: reference-openrouter-key-and-playwright-python
description: "This Mac: OpenRouter key is in ~/Code/BLC/.env.local (has a literal \\n to strip), marketing-agent's is empty; Playwright needs python3 without -I"
metadata:
  node_type: memory
  type: reference
  originSessionId: 88fa9621-c390-4023-8243-d2ae33f72f2f
  modified: 2026-11-02T19:29:22.411Z
---

On Charlotte's Mac (11-02): `marketing-agent/.env.local` has `OPENROUTER_API_KEY=""` (empty, gives 401). The working key
is in `~/Code/BLC/.env.local`, stored with a trailing literal `\n` inside the quotes: strip it before use. The
`/api/v1/models` list works with no key, so a 401 only shows on chat calls.

Playwright and Pillow are user-site installs for `/usr/bin/python3` (3.9): `python3 -I script.py` hides them
("No module named playwright"). Run our own render scripts with plain `python3`.

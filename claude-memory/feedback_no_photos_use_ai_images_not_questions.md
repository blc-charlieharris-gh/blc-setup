---
name: feedback-no-photos-use-ai-images-not-questions
description: "Client site with no fitting photo: make an AI image and list it in _client/ai-images.json; never add a photo question to missing.md"
metadata:
  node_type: memory
  type: feedback
  originSessionId: a2b36085-d735-480e-8ceb-f3bdb204655b
  modified: 2026-11-02T22:30:41.310Z
---

When a client site page has no real photo that fits (Elect solar page showed heat pumps, 11-02), make a super-realistic
AI image for it and list the place in `_client/ai-images.json`. Don't swap in unrelated photos, and never add "send us
photos of X" to `_client/missing.md`.

**Why:** the Hub already asks the client for photos from ai-images.json (one images question), so a missing.md line is
a duplicate ask. Charlotte 11-02: "we have an images question already, we use ai when we don't have images".
**How to apply:** kit INSTRUCTIONS step 2 Images; no real faces, no claimed jobs; take the entry out once their photo is in.

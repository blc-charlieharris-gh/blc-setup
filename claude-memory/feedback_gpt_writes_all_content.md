---
name: feedback-gpt-writes-all-content
description: "All client content (social posts, plans, briefs, page wording) is planned and written by ChatGPT via OpenRouter, not Claude"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 0b75b9a0-bf11-409b-927e-f0786028143c
  modified: 2026-10-08T07:25:19.851Z
---

All content for clients is planned and written by ChatGPT (OpenRouter `openai/...`, currently `openai/gpt-6.1-sol` in marketing-agent `api/crew-generate.js`, overridable by CREW_WRITE_MODEL). That covers the 30-day planner, briefs, post captions and the social set up page wording. Charlotte 2026-10-08: "all content should be planned and written by gpt its better at that".

**Why:** she judges GPT's marketing copy better than Claude's.
**How to apply:** any new content-writing feature uses the GPT writer; never switch it back to an Anthropic model. When picking a slug, check https://openrouter.ai/api/v1/models for the newest openai/gpt-* (they use dots). Images stay on the image model (Gemini) unless she says otherwise.

Related: changing the Facebook page itself (picture, cover, intro) is done by hand for now; automating it is a future upgrade ([[project-social-setup-area]]).

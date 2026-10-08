---
name: project-social-setup-area
description: "CREW social job (live 10-08, #1617/#1618/#1620/#1622): page picker, found/now score, GPT words, pictures, questions, approval page, first 10 posts; FB page edits by hand until Full control"
metadata:
  node_type: memory
  type: project
  originSessionId: 0b75b9a0-bf11-409b-927e-f0786028143c
  modified: 2026-10-08T08:32:58.916Z
---

Crew > Social job page (SocialProfileWork) is live since 2026-10-08: pick FB page, Read their page (always scores as found), found/now checklist out of 100 (Instagram optional), Questions (standard photo and video request, shared ClientQuestions block), GPT-written Intro/Details/IG bio (crewFacts.js), cover + profile picture with preview, client approval page /social-delivery/:token, "Put it on their page" (Put live needs FB Full control, else Download/Copy + Done by hand), "Their first 10 posts" card -> Crew Social tab plan (first10 = 10 posts / 14 days). Booking all 10 ticks social_setup/social_cleanup.

Pictures: client's uploaded photos first, then openai/gpt-5.4-image-2 with MEDIA_AI_RULE (src/lib/mediaPolicy.js). No opt-out for AI imagery (Charlotte 10-08) but never fake installs, reviews, team or customers; MEDIA_AI_NOTICE is the client wording.

**Why:** Elect bought social set up; Charlotte wants it repeatable for every client.
**How to apply:** Elect's page lacks MANAGE task (checked 10-08), so page edits are by hand until they grant Full control. CREW audit (two social scores, two social screens, no "start next month") and the one-client-page front door are owned by the Hub session doing Manage Clients (handed over 10-08). See [[feedback-gpt-writes-all-content]].

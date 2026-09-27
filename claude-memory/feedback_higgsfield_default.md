---
name: feedback-higgsfield-default
description: "Always use Higgsfield for any image or video generation; if the user did not name a model, ask which model before generating"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 7c025f6b-6d22-4f5d-a4c3-4119ac2951d9
---

For ALL image and video creation, use the Higgsfield CLI (see [[project-higgsfield]]). Do not reach for other image/video generators.

If the user has not specified which Higgsfield model to use, ASK them which model before generating. Do not pick one silently.

**Why:** Charlotte wants generation centralised on Higgsfield (billing, workspace, consistency) and wants control over which model is used since models differ in cost and output (e.g. nano_banana_2 = 2 credits, gpt_image_2 = 7 credits).
**How to apply:** Before generating, confirm BLC Promotions workspace, then either use the model the user named or ask. Estimate cost with `higgsfield generate cost <model> ...`. Related: [[project-higgsfield]], [[feedback-ads-location]].

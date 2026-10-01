---
name: feedback-hooks-videos-only-ingredients-for-analysis
description: Hooks only tell apart similar-looking videos; performance analysis runs on ingredients; statics never need a hook typed
metadata:
  type: feedback
---

Charlotte (2026-10-01): "ingredients are what we analyse performance on, hooks are just to help us differentiate different but similar looking videos." Statics don't need a hook typed in; they show "Static" automatically (lib/adHygiene STATIC_HOOK).

**Why:** hooks are a label for telling videos apart, not an analysis dimension.
**How to apply:** never require or prompt for a hook on statics/carousels; build creative performance analysis on creative_ingredients, not hooks. Related: [[project-hub-page-audit]]

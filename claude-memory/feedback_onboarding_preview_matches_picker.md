---
name: onboarding-preview-matches-picker
description: Hub /onboarding-preview must always mirror the real onboarding picker + form; any picker change goes on both
metadata:
  node_type: memory
  type: feedback
  originSessionId: 78dad3d1-e785-4f80-b6f6-8d87f8b97d72
  modified: 2026-10-14T09:22:35.339Z
---

Charlotte 2026-10-14: "preview should always be a complete up to date [copy] of the real onboarding or it's useless". Triggered when I added the "Note for marketing" box to OnboardingPicker inline and the preview didn't show it.

**Why:** staff use /onboarding-preview to see exactly what sales and clients get; a stale preview misleads them.
**How to apply:** any new picker card goes in components/clients/PackagePickFields as a shared component and on BOTH pages/hub/OnboardingPicker.jsx and OnboardingPreview.jsx (preview saves nothing). The guard is src/pages/hub/onboardingPreviewParity.test.js; only add a picker-only exception there with a real reason (no client in preview). Related: [[feedback_rules_not_one_off_fixes]].

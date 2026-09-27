---
name: feedback-shared-scratch-docs-get-clobbered
description: "current-plan.md, current-handoff.md, and CHANGELOG.md's top entry are single shared 'current state' files, not append-only logs. When another concurrent session merges to main, their write to these files replaces yours, even after your own PR already merged them. Happened twice in one session in marketing-agent."
metadata:
  type: feedback
  originSessionId: 51270093-683e-4896-8b2e-04b4672503df
  modified: 2026-08-25T11:54:28.457Z
---

Wrote `current-plan.md` for a feature, it got merged via PR. Started a second feature later the same session, `git checkout main && git pull` pulled in a concurrent session's (Serafim's, on the placement-signup work) own overwrite of `current-plan.md` back to THEIR content, silently discarding mine, even though mine had already been the merged, "current" version moments earlier. Same thing happened again to `current-handoff.md` and the top entry of `CHANGELOG.md` right at session-end handoff time.

**Why:** these files are treated as "the one active plan/handoff," not a log, by design (`/plan-feature` and `/handoff` both literally overwrite them). That's correct behavior for a single-session repo, but with two people/sessions working concurrently on the same repo, whoever's PR merges LAST wins, and there's no merge-conflict warning because both sides' edits are "valid" overwrites of the same file, git doesn't know one is stale content you still need.

**How to apply:** after writing `current-plan.md`/`current-handoff.md` and before it's needed again later in the same session (e.g. before running `/implement` on a plan just written, or before a second `/plan-feature` call), keep the content in your own context/scratchpad rather than assuming the file on disk will still hold it once you `git pull` again. If it does get clobbered, just re-write it from what you already composed, cheap to fix once you know it's coming, expensive if you don't notice and skip a step because you assume the file still has your content. For `CHANGELOG.md` specifically: always re-check the top entry is still yours before considering the changelog step done, don't just append-and-trust.

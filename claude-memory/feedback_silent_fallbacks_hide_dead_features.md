---
name: feedback_silent_fallbacks_hide_dead_features
description: "In this codebase, \"graceful degradation\" has repeatedly hidden features that never worked at all; check the fallback path first when auditing"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 2d7508d9-d165-4c26-9ed8-fe15e093f40f
  modified: 2026-07-31T08:29:20.987Z
---

When reviewing any feature in marketing-agent that "was set up a while ago" but has no results to show,
check the FAILURE path before the happy path. Three separate cases found in one session (2026-07-31),
all the same shape: an error was caught, replaced with a plausible-looking substitute, and nobody
could tell.

1. `api/crew-generate.js` asked OpenRouter for `anthropic/claude-haiku-4-5`. That slug does not exist
   (OpenRouter uses a DOT: `claude-haiku-4.5`). Every call 400'd, `crewCrudSlice` swallowed it and
   substituted `buildDemoPlan()`. HQ Group's "strategy" sat in production as the verbatim demo string
   for three weeks. The AI had never run once.
2. `api/crew-intake.js` returned `200 {ok:true, persisted:false}` when the service key was missing, and
   the page never checked the response before showing "Thank you, that's everything".
3. `approvePlan` set post status to `'scheduled'` in jsonb with no cron and no Graph API call, so
   "Approve & schedule all" scheduled nothing.

**Why:** a loud failure gets fixed in a day; a silent one looks like a working feature for weeks and
gets reported to the user as done.

**How to apply:** when auditing a feature here, (a) grep for `catch {` with no rethrow, (b) verify
external IDs against the provider's live list, never from memory (`curl openrouter.ai/api/v1/models`),
(c) check whether the thing that claims to schedule/send/save actually calls anything, and (d) look
for a row in prod whose stored output matches a hardcoded default string. Prefer throwing over
substituting: fake content going out under a client's name is worse than an error.
Related: [[project_intake_forms_retired]], [[feedback_spa_stale_bundle_vs_deploy]].

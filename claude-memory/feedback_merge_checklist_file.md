---
name: feedback-merge-checklist-file
description: When many PRs/SQL steps are in flight, keep ~/code/BLC/_deploy/MERGE-CHECKLIST.md current and finish with one full summary with every link
metadata:
  type: feedback
---

Keep a running merge checklist at `~/code/BLC/_deploy/MERGE-CHECKLIST.md` (ordered merge links, SQL files, edge-fn pastes, pending decisions) whenever several changes are waiting, and end the batch with ONE full summary message listing every link in order.

**Why:** Charlotte 2026-09-29: "need a full summary and all links to merge at the end as im losing your messages to me". Many parallel helpers produced a stream of links she couldn't track.

**How to apply:** update the file each time a branch is pushed or merged; put long SQL in `_deploy/*.sql` rather than chat; note merge-order dependencies (stacked branches) in the file. Related: [[feedback-charlotte-plain-explanations]].

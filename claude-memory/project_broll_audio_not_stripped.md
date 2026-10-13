---
name: project-broll-audio-not-stripped
description: "RESOLVED 10-13: all 16 general B-roll clips re-stored picture-only (clip-silent); B-roll sound (10-12, fix 10-13): strip now always remuxes picture-only, cleaned files named clip-silent; verify every B-roll file_path has clip-silent after Charlotte runs Remove sound"
metadata:
  node_type: memory
  type: project
  originSessionId: b62ab90b-7e0e-451a-a273-d6fc21fe85f9
  modified: 2026-10-13T12:36:32.621Z
---

Charlotte 10-12 and again 10-13 (angry, asked many times): B-roll must have NO audio. 10-13 finding: the 10-03 clips got new thumbnails from Tidy but their files were never re-stored, so lib/brollSound's "any audio track?" check returned none on them and skipped them; every upload since 10-05 went through the same check.

Fix (branch fix/broll-always-silent-1013): withoutSound always rebuilds the video track only (verified with ffprobe on aac and pcm test videos: output video-only); cleaned files are `<id>/clip-silent[-<t>].<ext>`; lib/broll mustBeSilent = any video of kind broll (general AND a client's B-roll; client interviews/installs keep sound); Tidy shows "Remove sound from B-roll (N)".

**Why:** b-roll is reused across ads; original audio leaks into edits.
**How to apply:** once merged and Charlotte clicks Remove sound on B-roll and Client footage, check by SQL that every `creative_broll` video with kind broll has `clip-silent` in file_path; any left = report the error shown. No service key locally, so files can't be probed directly. Related: [[project_client_drive_build]].

**Resolved 2026-10-13:** SQL check showed 16/16 general B-roll videos with clip-silent paths after Charlotte ran Remove sound. Client footage keeps sound by design (#1805); clips with sound left show red (#last-two).

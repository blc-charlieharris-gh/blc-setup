---
name: project-broll-audio-not-stripped
description: "PRESENT at next start (10-12): Charlotte says every general b-roll clip still has its original audio; stripping (lib/brollSound, 10-05) and Tidy older clips miss them"
metadata:
  node_type: memory
  type: project
  originSessionId: 2ce9a8c2-9e9c-4e30-a7d9-643584af5866
  modified: 2026-10-12T20:42:10.584Z
---

Charlotte 2026-10-12 night: "b roll should be stripped of audio, yet all the clips have original audio". Raise at the next marketing-agent prime and fix first.

Found so far (read only): creative_broll has 16 general clips (client_id null, 2026-10-03 to 10-06) and 22 client footage clips (2026-10-01, keep sound on purpose). Stripping on upload (src/lib/brollSound.js withoutSound, src/hooks/useBroll.js ~152) only started 10-05. "Tidy older clips" (lib/broll needsTidy -> soundLeftOn) only spots a clip by the `/clip-sound.<ext>` name marker, which none of the 16 has, so the 10-03/04 ones are never redone. If the 10-05/06 uploads also have sound, withoutSound itself isn't working.

**Why:** b-roll is reused across ads; original audio leaks into edits.
**How to apply:** download a 10-04 and a 10-06 clip from the b-roll bucket and probe for an audio track; fix the strip if needed; make Tidy detect audio from the file (or re-strip every general clip once) rather than the filename; client footage untouched. Related: [[project_client_drive_build]].

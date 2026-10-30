---
name: reference-video-cut-at-word-edges
description: "How to cut a section out of a talking-head video cleanly: YouTube caption timings, faster-whisper word timestamps, ffmpeg trim+concat"
metadata:
  node_type: memory
  type: reference
  originSessionId: 0697ae11-2b8f-436a-b184-1157e928e77f
  modified: 2026-10-29T16:06:21.235Z
---

Cutting part of a VSL (done 2026-10-29 for /webinar, see site-installrhub #236):

- YouTube embeds can only trim start/end (`start=`, `end=`), never a middle section. Middle cuts need the file re-edited and re-uploaded, or YouTube Studio Editor > Trim & cut.
- Captions: re-fetching the `api/timedtext` URL returns an empty body (needs the player's pot token). Hook XMLHttpRequest/fetch in the watch page, then reload the captions module so the player itself fetches it. That gives phrase-level timing only.
- Word edges: `python3 -m venv` in the scratchpad, `pip install faster-whisper`, model `small.en` with `word_timestamps=True` (~460 MB download to ~/.cache/huggingface, ~10 min for 3 min of audio on CPU). Delete the model afterwards.
- Cut with an ffmpeg `trim`/`atrim` + `concat` filter (re-encode, crf 18), 40 ms audio fades at each join; then transcribe the output around the joins to check no word is clipped.

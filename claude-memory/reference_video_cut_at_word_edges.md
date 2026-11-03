---
name: reference-video-cut-at-word-edges
description: "How to cut a section out of a talking-head video cleanly: YouTube caption timings, faster-whisper word timestamps, ffmpeg trim+concat"
metadata:
  node_type: memory
  type: reference
  originSessionId: 0697ae11-2b8f-436a-b184-1157e928e77f
  modified: 2026-11-03T11:32:28.092Z
---

Cutting part of a VSL (done 2026-10-29 for /webinar, see site-installrhub #236):

- YouTube embeds can only trim start/end (`start=`, `end=`), never a middle section. Middle cuts need the file re-edited and re-uploaded, or YouTube Studio Editor > Trim & cut.
- Captions: re-fetching the `api/timedtext` URL returns an empty body (needs the player's pot token). Hook XMLHttpRequest/fetch in the watch page, then reload the captions module so the player itself fetches it. That gives phrase-level timing only.
- Word edges: `python3 -m venv` in the scratchpad, `pip install faster-whisper`, model `small.en` with `word_timestamps=True` (~460 MB download to ~/.cache/huggingface, ~10 min for 3 min of audio on CPU). Delete the model afterwards.
- Cut with an ffmpeg `trim`/`atrim` + `concat` filter (re-encode, crf 18), 40 ms audio fades at each join; then transcribe the output around the joins to check no word is clipped.

Reels from a 16:9 VSL (2026-11-03, Webinar 2 reel; Charlotte rejected v1 as "cropped weird, cut mid word"):
- Whisper word edges can be 0.25s off and it hides a clipped tail: Charlotte heard "scheme" before "you can register" that whisper didn't report. Cut at the 20 ms RMS minimum inside each gap (cut before -45 dB), and test each cut on its own with padding, not just the joined file.
- The IH VSLs have burned-in captions (green bottom band; white italic kinetic words in the hook, off-centre). A 9:16 crop slices them mid-word and blur leaves a green smear: paint them out with cv2.inpaint (mask = green or white text plus dark stroke near it), then draw your own captions.
- Brad moves and the VSL has several framings: track the face (OpenCV haar cascade, opencv-python-headless<5; v5 has no CascadeClassifier) with heavy smoothing, render frame by frame in Python, pipe to ffmpeg.
- This Mac's ffmpeg has no drawtext/subtitles filter: draw text with PIL.
- Lyria (meta-access shared/music.py): a "clean ending" prompt ends at ~26s of 29; ask for "no ending, no fade" and fade it yourself.

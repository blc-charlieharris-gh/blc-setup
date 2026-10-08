---
name: reference_google_meet_webinar_files
description: "Google Meet webinar outputs: recording, attendance sheet (emails masked in the file), chat file; where each lives and what it holds"
metadata:
  node_type: memory
  type: reference
  originSessionId: c5ea8f07-0504-46e0-bffc-9c4847d39d34
  modified: 2026-10-07T07:52:49.974Z
---

A recorded Google Meet webinar (organiser Brad, bradclark@installrhub.com) leaves three files in the organiser's Drive "Meet Recordings" folder. Only the ones he shares reach Charlotte's Drive (Drive MCP search finds them by title).
- "<title> - <date> BST – Recording" (mp4). It starts when recording starts (6 Oct: 14 min of pre-show) and runs until the last participant leaves; a notetaker bot (Fathom) kept it going 6 silent hours. It has a subtitle track of the spoken transcript (`ffmpeg -map 0:s:0 out.srt`), and the times are recording-relative. Meet chat is NOT in the video.
- "– Attendance" (Sheet): name, duration, joined/exited. External emails are masked IN THE FILE (`abcd****@***.com`), so the organiser's copy is masked too. Full emails: Google Admin > Reporting > Meet log events (unverified).
- "– Chat" (text): every chat line with recording-relative time. This is the source for "who typed 1" style follow-ups. Charlotte pastes it or Brad shares it.

Match chat names to `mailing_contacts` (first+last name, then company_name, then the masked email prefix and ending). People who join under a company or Google nickname need the company match. 6 Oct: 24 of 35 matched.

To grab a frame from an Unlisted YouTube upload when the local file is gone: the pip yt-dlp on the Mac's python 3.9 fails ("page needs to be reloaded"). Use the standalone `yt-dlp_macos` from GitHub releases (scratchpad), `-g` for the stream URL, then `ffmpeg -ss <sec> -i URL -frames:v 1`. Related: [[project_webinar_page_automation]]

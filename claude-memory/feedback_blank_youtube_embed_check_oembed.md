---
name: blank-youtube-embed-check-oembed
description: An empty video box on a site usually means the YouTube video was removed; find which one via oEmbed status codes
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1bad034e-3f2d-4382-8913-4771117451c3
  modified: 2026-09-23T12:28:44.029Z
---

When Charlotte says a video box is "empty" or has "no video", the embed ID usually points at a YouTube video that was deleted. The page code looks fine. Find the dead one with `curl -s -o /dev/null -w "%{http_code}" "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=<ID>&format=json"`: 404 means it's gone, 200 returns the title. On 2026-09-23 the InstallrHub thank-you "FAQ: What is the price?" video (DuoDnMdqzlM) was gone and got replaced by W-i4Qm1ZeJM (PR #70).

**Why:** It took a clarifying round-trip to find which video she meant; the oEmbed check pinpointed it instantly.
**How to apply:** Before asking which video, run oEmbed checks on every embed on the named pages. Also, installrhub.com git-main builds take ~1-2 min after merge, so recheck before assuming a deploy gap ([[feedback_prebuilt_deploy_overrides_main]]).

---
name: reference-meta-access-repo
description: "meta-access is now a private repo blc-charlieharris-gh/meta-access (2026-09-23); scripts + SOP tracked, .env and 400MB generated media are not"
metadata:
  node_type: reference
  type: reference
---

`meta-access` is a git repo as of 2026-09-23: **`blc-charlieharris-gh/meta-access`, private**,
local clone at `~/code/BLC/meta-access`. Before this it existed on one Mac and nowhere else.

**Tracked (26 files):** the 10 Meta Marketing API scripts (`meta_api.py`,
`build_mof_video_adset.py`, `duplicate_tof_video_adset.py`, `publish_page_reel.py`,
`upload_video_to_meta.py`, `ad_library_search.py`, `fix_tof_creative_bug.py`,
`replace_mof_dto_copy.py`, `drive_download.py`, `fetch_pitch_thumbs.py`), `CLAUDE.md`,
`docs/` (including `meta-ops-sop.md`), `debugging/`, plus a new `README.md` and `.env.example`.

**Deliberately NOT tracked, and must stay that way:** `.env` (holds `META_ACCESS_TOKEN`,
`PAGE_ACCESS_TOKEN`, and the per-client `ACCOUNT_*` ids), and ~400 MB of generated media in
`outputs/`, `ugc-solar-male/`, `ugc-solar-reword/`. All covered by `.gitignore`.

Scripts load credentials via `load_dotenv()` then `os.environ[...]`. No token has ever been
hardcoded, verified by scan before the first push.

**Why:** this toolkit is the only way BLC builds and edits Meta ad sets, and it had no backup.
**How to apply:** work in it like any repo now, commit and push. Never commit `.env`. If the
repo ever looks enormous, something generated has slipped past `.gitignore`.
Related: [[project_higgsfield]], [[feedback_ads_location]], [[project_blc_moved_out_of_icloud]]

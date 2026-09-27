---
name: reference-installrhub-git
description: "site-installrhub git repo lives in installrhub-static/ subdir, not the project root"
metadata: 
  node_type: memory
  type: reference
  originSessionId: b5d41994-7f08-4e0e-84a4-2e5e9586a10d
---

For the [[project_installrhub]] site, the git repo is NOT at the project root (`site-installrhub/`). It lives one level down in `site-installrhub/installrhub-static/`.

- Repo root: `/Users/charlotteharris/Documents/BLC/site-installrhub/installrhub-static/`
- Remote: `origin` -> `https://github.com/blc-charlieharris-gh/site-installrhub.git`, branch `main`
- This static-site repo is how the live site is updated. Run all `git` commands from inside `installrhub-static/`.
- The WordPress theme at the project root (`installrhub-theme/`) is a separate, non-git-tracked artifact.

Running `git log` from the project root reports "no git" and is misleading. Documented in the project CLAUDE.md too.

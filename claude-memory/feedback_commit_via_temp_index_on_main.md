---
name: git-commit-via-temp-index-on-main
description: "In marketing-agent, git status/fetch/push hang; commit via temp-index on fresh origin/main, re-applying edits onto main's file versions"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 75010aad-ea0f-47a4-8a00-0469f11322f5
  modified: 2026-08-27T14:59:17.886Z
---

In the marketing-agent working copy, `git status` / `git fetch` / `git push` intermittently hang (huge untracked dirs like node_modules/client-sites + a large loose-object db). `git log` and `git ls-remote` stay fast. A hung `git push` sometimes just needs `run_in_background: true` to finish past the 2-minute tool cap. See [[blc-workdir-corruption]].

**UPDATE 2026-07-31: the hanging did NOT reproduce.** Two separate sessions ran `git status`, `git fetch`, `git diff` and `git push` repeatedly, all fast. Treat the hang as intermittent or fixed, not as a given. The temp-index recipe below is still the right approach regardless, but for the OTHER reason: the tree is shared between concurrent sessions, so a normal `git add` sweeps someone else's uncommitted work.

**CHECK WHETHER A FILE IS TRACKED BEFORE YOU `rm` IT (2026-09-18, near miss).** The advice
below says to delete your untracked copies after a merge. But in a shared tree another session can
pull or switch branches between your checks, and then those same files become TRACKED. Deleting a
tracked file leaves a pending deletion (` D` in `git status`) sitting in the other session's working
tree, and a `git commit -a` or `git add -A` from them would commit the deletion and remove the
feature from main on merge. It happened: the Sales Model board files flipped from untracked to
tracked when the other session checked out `fix/picker-deliverables-gate-v2`, and the cleanup `rm`
turned them into deletions. Fixed with `git checkout HEAD -- <paths>`, which restores exactly what
THEIR branch expects (an older version is correct there: their branch never touched those files, so
main's newer copy wins on merge). **Before any `rm`, run `git ls-files <path>`: empty means untracked
and safe to delete, non-empty means leave it alone.** Re-check immediately before deleting, not at
the start of the cleanup, because the tree can change underneath you.

**AFTER a temp-index commit is merged, clean up your own untracked files.** They stay on disk untracked while also existing in `origin/main`, so the next `git pull` dies with "untracked working tree files would be overwritten". Verify identical (`git hash-object <f>` vs `git rev-parse origin/main:<f>`) then `rm` them. Tracked files you edited will still show as modified against a stale local HEAD; that resolves itself on pull, but the pull needs those paths reverted first (`git checkout HEAD -- <paths>`) since the index still holds the old versions.

To land work without touching the (WIP-contaminated) working tree, build the commit with a temp index:
```
export GIT_INDEX_FILE=$(mktemp)
git read-tree "$(git rev-parse origin/main)^{tree}"
blob=$(git hash-object -w path/to/edited/file); git update-index --add --cacheinfo 100644,"$blob",repo/rel/path
TREE=$(git write-tree); C=$(git commit-tree "$TREE" -p origin/main -F - <<'MSG'
...message...
MSG
); git update-ref refs/heads/<branch> "$C"; git push origin <branch>
```

**Real near-miss, 2026-07-31:** the shared tree sat 9 commits behind (`5b65cdd` vs `c282245`, spanning #463 to #472) while two sessions worked in it. #466 had edited `ClientTesting.jsx`; a second session was about to commit its own edit to that same file built from local HEAD, which would have silently reverted #466's `is_tracked` filter. Caught only by the "base on origin/main" rule. **Always count the gap first (`git rev-list --count HEAD..origin/main`) and check whether any commit in it touched YOUR file (`git log HEAD..origin/main -- <path>`).**

**Two things that will bite you:**
1. **Base on FRESH `origin/main`, not the local feat tip.** Squash-merge means the local branch's tree diverges from main on files you never touched, so a PR conflicts (e.g. `CreativeTesting.jsx` conflicting when you only edited `actions.js`). Fetch main first, `-p origin/main`.
2. **Re-apply your edits onto MAIN's version of each file, not the working-tree copy.** The working tree carries prior uncommitted WIP (e.g. a reconcile-display Status rework, a PagesTab picker change) that gets silently bundled if you hash the working-tree file. Dump `git show origin/main:path` to scratch, re-apply just your edits there, then hash that.

Gotchas: zsh does not word-split `for f in $VAR` (use an array). Never use an unquoted heredoc (`<<PY`) when the body has backticks/`~*` (shell mangles it); use `<<'PY'` or a Write'd script file.

**A narrow `git add <specific files>` still doesn't protect you (2026-08-21).** Ran `git add` on
exactly 3 intended files, but the shared index already had ~170 unrelated files staged from another
session's in-progress work (website-factory blog content). `git commit -m "..."` with no pathspec
commits the WHOLE index regardless of what you just added, so the resulting commit carried all ~170
extra files. Caught by `git show --stat HEAD` right after committing, before pushing. Fix:
`git reset --soft HEAD~1` (restores the index to exactly its pre-commit state, staged files and all,
nothing lost), then recommit with the SAME pathspec repeated on the `git commit` command itself:
`git commit -m "..." -- file1 file2 file3`. Only `git commit -- <paths>` actually limits what lands
in the commit; `git add <paths>` alone does not, if the index wasn't clean beforehand. Always run
`git status --short` before ANY commit in this repo, not just before the add, and always pass the
same explicit pathspec to `git commit` too.

**`git checkout <target-branch>` refuses even when the "conflicting" files are byte-identical to the
target (2026-08-23).** Working tree had 5 docs files + 2 supabase function files showing as
modified/untracked against the currently checked-out (stale, already-merged) branch. Checking out a
fresh branch off `origin/main` was blocked by git listing those exact 7 files as "would be
overwritten" — even though `git hash-object <f>` matched `git rev-parse origin/main:<f>` exactly for
every one (confirmed with a loop before touching anything). Git's checkout safety check compares
working tree against the CURRENT INDEX, not against the target commit, so it errors even when the
target and working tree already agree. Fix: `git checkout origin/main -- <the 7 paths>` first (a
genuine no-op on disk since content is identical, but it updates the index), then the branch
checkout succeeds cleanly. Never skip the hash comparison and just force through — this only applies
when content is PROVEN identical; if it differs, that's real uncommitted work someone else has in
flight in this shared tree and must not be discarded.

**A broad `git add` after `checkout -b` can still sweep in someone else's ALREADY-STAGED work
(2026-08-18).** `git checkout -b <new-branch>` inherits whatever is currently staged in the shared
index, not a clean slate. Ran `git add <3 doc files>` intending a docs-only commit; the resulting commit
carried 135 files, a full `templates/016-arktek` → `clients/arktek` rename another session had already
staged before this one started. Caught by checking `git diff --stat origin/main HEAD` before pushing
(always do this, not just `git status` before the add). Fixed via the usual temp-index rebuild + a
`git push --force-with-lease` on the branch just created (safe: it was pushed seconds earlier by this
session alone) — critically, moving the local branch ref forward via `git symbolic-ref HEAD` does NOT
touch the working tree/index, so the other session's staged rename was left exactly as found, still
staged, nothing lost. Separately and later the same session: another session checked out a different
branch on this same shared disk, which silently reverted local uncommitted edits to two docs files back
to an older version (normal `checkout` behaviour, but easy to mistake for data loss). Nothing was
actually lost since the temp-index commit had already been pushed to its own branch by then — but the
lesson is to push doc/handoff edits via temp-index promptly rather than leaving them sitting
uncommitted on the shared working tree for the rest of a long session.

**zsh does not word-split `for f in $FILES` — this can push an EMPTY/no-op commit straight to
`main` before you notice (2026-08-27).** Built a temp-index commit intending to stage ~13 changed
files via `for f in $FILES; do ...; done` where `$FILES` was a space-separated string. In zsh (this
machine's default shell, confirmed via `ps -p $$ -o comm=`), an unquoted `$FILES` in a `for` loop is
NOT word-split the way bash does it — the whole string became a single non-existent "filename",
every `update-index --cacheinfo` call failed, and `write-tree`/`commit-tree` still succeeded,
producing a commit with the OLD tree unchanged (a silent no-op). This got pushed straight to `main`
(`git push origin $SHA:main`) before the mistake was caught — caught immediately after by the
now-standard `git diff <old> <new> --stat` check, which showed zero differences. Fix used: rebuild
the commit with a `while IFS= read -r f; do ...; done <<'EOF' ... EOF` here-doc loop instead, which
word-splits correctly in both bash and zsh regardless of `$IFS` settings. The empty commit was left
in place (harmless, no reason to rewrite pushed `main` history) and the real commit was pushed as
its child. **Always use the here-doc `while read` pattern for multi-file lists in this repo, never
`for f in $VAR`, and always run the `git diff <parent> <new-commit> --stat` sanity check immediately
after building ANY temp-index commit, not just before pushing — it would have caught this before the
push, not after.**

**`git update-index --cacheinfo` needs `--add` for a path not already in the base tree, or it errors
outright — but a `write-tree`/`commit-tree` run in the SAME shell block as an earlier failed call can
still "succeed" with a corrupted entry (2026-08-27).** Staging a brand-new file (not present in
`origin/main`'s tree) with `git update-index --cacheinfo 100644,$BLOB,$PATH` (missing `--add`) fails
with `cannot add to the index - missing --add option?`. That failure alone is recoverable, but in the
same command block a SECOND bug compounded it: a `blob=$(git rev-parse "$FEATURE:$PATH")` computed
inside a block that had ALSO just done `export GIT_INDEX_FILE=$(mktemp)` somehow resolved to the
FEATURE branch's commit SHA itself, not the file's blob SHA (exact cause not fully isolated — possibly
shell state bleeding between commands in the same invocation). The resulting `write-tree` proceeded
without error, but `commit-tree`'s push then failed with `object <sha> is a commit, not a blob` /
`entry has blob mode, but is not a blob`. Fix: never compute blob hashes for a temp-index commit in
the same breath as manipulating `GIT_INDEX_FILE` — resolve and VERIFY every blob hash first as a
separate step (`git cat-file -t "$BLOB"` must print `blob`), store them in plain shell variables, THEN
open a fresh `GIT_INDEX_FILE` and only do mechanical `update-index --add --cacheinfo` calls with the
pre-verified hashes. Always pass `--add`, even for paths you believe already exist in the base tree —
it's a no-op if they do, and saves exactly this class of failure if they don't.

**HEAD can silently sit on `main` while a whole client folder is untracked WIP (2026-08-14).** A long Gas Worx build (`website-factory/clients/gasworx/`) ran for many hours of edits with the repo's checked-out branch actually on `main` the entire time — `git status` showed `?? website-factory/clients/gasworx/` (fully untracked), even though the folder had real committed history on `feat/gasworx-site`. `git diff origin/feat/gasworx-site -- <path>` looked like a full-file deletion for every file until the mismatch was spotted (`git ls-files <path>` returned nothing under `main`). Fix was the same temp-index recipe but based on `feat/gasworx-site`'s tree (not `origin/main`), diffing `git ls-tree -r --name-only <branch> -- <dir>` against `find <dir> -type f` to get adds/deletes, then hashing every on-disk file. **Before trusting that disk content = committed content in this repo, always run `git branch --show-current` and `git ls-files <path> | head -1` first** — a non-empty untracked folder full of real work is not itself a red flag here, but assuming it's tracked-and-safe without checking is.

**Never point a build/generator script at the shared tree (2026-09-18).** A scratchpad script that regenerated `board.js` wrote straight into `src/lib/pipelineBoard/`, where the file was tracked on ANOTHER session's checked-out branch, an hour after the ls-files rule above was written. Remembering to clean up afterwards is not a control. Generators write to the scratchpad; the result goes into the commit via `git hash-object -w` + the temp index, never via the working tree.

**Sales Model session handoff (2026-09-18): specific files + a data-ownership fact.** Leave
`src/lib/pipelineBoard/` and `src/pages/SalesModel.jsx` alone unless asked — `main` has the
current versions. Some older branches (e.g. `fix/picker-deliverables-gate-v2`) still carry
older copies of `board.js`/`board.css` in their history; harmless as long as those never get
committed back over `main`. Also: `public.pipeline_board` (the board's data table) is hub-only —
Charlotte runs its SQL herself, it does NOT go to Serafim for review (unlike the Tier-2 rule for
most other migrations).

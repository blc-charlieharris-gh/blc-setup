---
name: feedback_website_factory_breaks_build
description: "website-factory files can fail marketing-agent's npm run build via eslint even though the folder never ships; fixed 2026-07-20 by adding it to globalIgnores"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: aa2b40e6-5935-4d29-9645-f66f9d2bc770
---

`npm run build` in marketing-agent is **`eslint . && vite build`**. `website-factory/` was fenced out of the *Vite build and Vercel deploy* (`.vercelignore`) but NOT out of eslint, so any file dropped into a template could fail the build of an app that does not even ship that file.

Hit for real 2026-07-20: last session's Arktek work added vendored minified GSAP bundles (`templates/016-arktek/assets/vendor/{gsap,ScrollTrigger,SplitText}.min.js`) plus an empty `catch {}` in `consent.js`. That was **25 eslint errors and a red build**, entirely from files that never reach production. It would have broken the Vercel deploy on commit.

**Fix applied:** `eslint.config.js` globalIgnores is now `['dist', 'client-sites', 'website-factory']`.

**Why ignore the whole folder rather than fix the files:** `website-factory/CLAUDE.md` says the kit is deliberately the opposite of the app's conventions (standalone HTML, big inline `<style>`, whatever JS the design needs, vendored libraries). Linting it with the React app's config is wrong on the merits. Do not "fix" template source to satisfy an app lint rule that should not apply to it.

**Generalise:** when a build breaks right after static-site/template work, check whether the failing files are ones that even ship. See [[project_website_delivery_workflow]].

**Happened AGAIN 2026-09-23, same class, new folder.** `client-landers/` (the tokenised client
landing-page engine) was merged into marketing-agent from the BLC root. `client-landers/template/main.js`
has three empty `catch {}` blocks, so the Vercel preview deploy failed immediately on merge.
Fixed the same way: globalIgnores is now
`['dist', 'client-sites', 'client-landers', 'website-factory', 'design-handoff']`.

**The diagnostic trap that wasted time both times:** running `eslint .` locally reports ~322 errors
even on a healthy main. Every one of them is in `.vercel/output/` build artifacts left behind by
local `vercel` CLI runs, which are gitignored and do not exist in CI. Reading that raw total led to
the wrong conclusion that "the build is already broken, pre-existing". It is not.
**Count errors in TRACKED files only** to see what Vercel will see:

```
npx eslint . -f json | python3 -c "import json,sys,subprocess,os; d=json.load(sys.stdin); \
t=set(subprocess.run(['git','ls-files'],capture_output=True,text=True).stdout.split()); r=os.getcwd(); \
print(sum(c for f,c in [(x['filePath'],x['errorCount']) for x in d if x['errorCount']>0] if os.path.relpath(f,r) in t))"
```

Zero means the deploy will build. **Rule: before merging any standalone folder into marketing-agent
(its own package.json, not imported by the app), add it to globalIgnores in the SAME commit.**

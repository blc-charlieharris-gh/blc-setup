---
name: feedback_lucide_map_icon_shadows_js_map
description: "lucide-react exports a `Map` icon that shadows the built-in JS Map constructor — crashes any component using both"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 133aee38-d26f-41b1-bb4d-e755eef68c17
  modified: 2026-08-25T15:18:05.666Z
---

`import { Map } from "lucide-react"` shadows the global `Map` class. Any component in the same file that does `new Map()` (common in this repo's coverage/bases components for per-base state like `methodById`/`districtOverrides`) will crash at runtime with `TypeError: Map is not a constructor`, only visible in the browser console / Vite HMR log, not caught by eslint or `npm run build` type-checking (no TS here).

**Why it's easy to miss:** the crash only shows up when the component actually mounts and the `useState(() => new Map())` initializer runs, so it survives lint + a quick dev-server-boots check. Caught it by tailing the Vite dev server's terminal output after the page loaded, not by any static check.

**How to apply:** when adding a `Map` (or `Set`, though lucide doesn't export that name) icon to any file that also uses the JS built-in of the same name, alias the import: `import { Map as MapIcon } from "lucide-react"`. Worth a quick grep (`new Map(`) before importing a same-named lucide icon into an existing file, this repo's `BasesCoverage.jsx` and similar coverage components lean on `Map`/`Set` state heavily.

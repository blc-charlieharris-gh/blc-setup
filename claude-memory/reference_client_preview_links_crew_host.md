---
name: reference-client-preview-links-crew-host
description: client website preview links are crew.installrhub.com/preview/:token; website.installrhub.com comments are stale and that host redirects to the homepage
metadata: 
  node_type: memory
  type: reference
  originSessionId: d3093207-ac63-477f-a42a-2d70b1efb989
  modified: 2026-09-18T18:25:40.603Z
---

Client website preview links are `https://crew.installrhub.com/preview/<signoff_token>` (previewUrl() in src/lib/clientIntake.js defaults to crew; Charlotte confirmed 09-18 this is correct and in use). Code comments in WebsitePreview.jsx, PreviewLinkPanel.jsx, clientCrudSlice.js and App.jsx still say website.installrhub.com; that host 307s every /preview/ path to installrhub.com via vercel.json. Not a bug, don't raise it as one. When verifying a preview-page deploy, check crew.installrhub.com (the page is a lazy chunk, load it in puppeteer, curl of index.html won't show it).

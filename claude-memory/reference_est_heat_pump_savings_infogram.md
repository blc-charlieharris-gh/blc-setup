---
name: reference-est-heat-pump-savings-infogram
description: "Energy Saving Trust heat pump savings figures sit in an Infogram embed; curl/WebFetch get 403, read window.infographicData in the browser pane"
metadata:
  node_type: memory
  type: reference
  originSessionId: b7a0f8c1-b66c-42dc-b0a5-383c54f0abc1
  modified: 2026-11-07T21:06:51.817Z
---

The Energy Saving Trust's air source heat pump savings table (energysavingtrust.org.uk/advice/air-source-heat-pumps) is not
in the page text: it is an Infogram iframe (e.infogram.com/_/ms7EQI1Ndbf7zAnrlxbY for GB). curl and the web-fetch agent
both get 403 from EST. Open the Infogram URL in the browser pane and read `window.infographicData` (sheets Gas, LPG, Oil,
Electric; rows by tariff; least/most efficient old system).

Read 2026-11-07 (fuel prices July 2026, 3-bed semi), heat pump tariff, least to most efficient: oil £460/£110, LPG
£1,050/£560, gas £530/£204 (no gas standing charge), electric £1,400/£1,000. Used in Elect's home savings finder
(FUELS in its build-pages.mjs). Recheck before reusing on another site.

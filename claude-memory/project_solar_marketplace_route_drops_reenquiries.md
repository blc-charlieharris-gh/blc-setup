---
name: project-solar-marketplace-route-drops-reenquiries
description: GT Solar Marketplace n8n/GHL route only passes NEW contacts to the app; repeat enquirers (phone match) never reach lead_intake_events. Fix when leaving n8n.
metadata:
  node_type: memory
  type: project
  originSessionId: 78f12882-f951-47f4-a554-dc741d6b81fc
  modified: 2026-10-14T14:52:43.158Z
---

Found 2026-10-14 testing Southern Solar (AS03). Form 2610071116079622 (GT Solar Marketplace V2.1-copy) forwards to n8n webhook `b54c6caf...GTSolarMarketplace`. GHL matches contacts by phone; an existing contact is a re-enquiry, and this route doesn't pass re-enquiries on to the app (the heat pump route, form 999842225762406, does: isReenquiry true still lands in lead_intake_events). 26/26 real leads so far were new contacts, so nothing lost yet, but a real repeat enquirer through AS01/AS03 would never reach the call centre.

Charlotte 10-14: "we'll be leaving n8n soon, we can do it then": no n8n change now. Test leads were fixed instead (meta-lead-webhook v47: option KEYS like real leads, unique +447700900xxx phone per test).

**Why:** a lost re-enquiry is a lost survey for a paying marketplace client.
**How to apply:** when replacing n8n for the solar marketplace route, make re-enquiries flow to intake like the HP route. Related: [[feedback_mirror_to_ingest_hides_leads]], [[reference_greentide_lead_to_installer_chain]].

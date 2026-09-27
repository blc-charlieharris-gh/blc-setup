---
name: feedback_gmail_mcp_wrong_account_and_thread_break
description: "The connected Gmail MCP account can be a different mailbox than the one used for real client correspondence, and update_draft silently detaches a draft from its original thread"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 00e6c831-6b75-429d-9f72-ead139248104
  modified: 2026-09-03T14:41:16.175Z
---

Discovered 2026-09-03 while drafting a client delivery email to Cammi (Retrofit Group, see [[project_retrofit_seo_audit_pending]]). `create_draft` with `replyToMessageId` correctly created a draft inside the real "Website Design" thread. Calling `update_draft` afterward (to swap an attachment note for a WeTransfer link) returned a **different `threadId`** than the original, silently detaching the draft into a new standalone thread — `update_draft`'s schema has no threading parameter at all, so there's no way to keep it anchored once you touch it a second time.

Separately, `get_draft` on that same draft showed `"sender":"charlieharris@installrhub.com"`, not `charlieharris@blc-promotions.com`, the address every prior email in that Cammi thread was sent from. Charlotte confirmed installrhub.com is in fact the correct/current sending domain, so that half was a false alarm this time, but the underlying check (don't assume the connected mailbox matches the thread's history without looking) is still the right instinct since it won't always be a false alarm.

**Why:** neither of these is visible from the tool call result alone (`create_draft` and `update_draft` both return success with an `id`/`threadId`, nothing flags "this isn't the thread/account you think it is"). Only calling `get_draft` afterward to inspect `sender` and `threadId` surfaced them. Sending on the "it returned 200 OK" assumption would have put a real client-facing email out from the wrong address, disconnected from the conversation history the client can see.

**How to apply:** before telling the user a Gmail draft is ready to send (especially to an external/client recipient), call `get_draft` and check `sender` matches the address that mailbox's real correspondence has been coming from, and `threadId` still matches the original conversation if threading matters. If either is off, say so explicitly rather than presenting the draft as ready, this is a "surface the anomaly, don't just proceed" situation, not something to silently fix or ignore. In this case the user ended up just sending it herself from her real account instead.

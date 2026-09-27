---
name: feedback-realtime-channel-name-collision
description: "A Supabase realtime channel name must be unique per hook instance, not a shared literal, when the hook mounts independently in multiple places at once"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 61afe38f-a213-4f49-98e7-f49da96d2c7e
  modified: 2026-08-27T10:58:47.741Z
---

Never give a `supabase.channel('literal-name')` postgres_changes subscription a hardcoded literal name inside a hook that can be mounted more than once concurrently (called directly from several components, not de-duplicated through a shared context). supabase-js reuses a channel by its name: the second mount's effect calls `.on('postgres_changes', ...)` on the SAME already-subscribed channel object the first mount created, and adding a listener after `.subscribe()` throws synchronously during the effect commit. With no error boundary, this takes the whole render tree down.

**Why:** discovered 2026-08-27 in marketing-agent (`useClientOnboarding.js`). `useAgentActions`'s identical-looking pattern is safe only because it's de-duplicated through a single `AgentActionsContext` (one instance app-wide, documented explicitly as the reason the context exists). `useClientOnboarding` has no such de-dup, it's called directly from 3+ places (ClientsManage, an Emails tab, `useActions`'s global aggregation, later a fourth page). Copying the agent_actions channel pattern without checking whether the target hook is single-instance white-screened `/clients` in production within the hour of shipping.

**How to apply:** before adding a realtime subscription to any hook, check every call site (`grep -rn "useTheHookName"`). If it's called from more than one place without a shared context wrapping it, give the channel a per-instance unique name (`useRef(\`topic:${Math.random().toString(36).slice(2)}\`)`), not a literal string. If the hook is genuinely single-instance today, note that risk in a comment, since a future caller adding a second mount reintroduces the same bug silently, it won't throw until someone renders it twice. See also [[feedback_never_starve_shared_prod_db]] for the general "shared-DB actions need extra care" instinct this belongs to.

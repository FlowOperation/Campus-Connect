# Routing and Navigation

## Objectives
- Typed, testable navigation contracts.
- Support deep links and role-based access guards.
- Keep route definitions centralized and feature-owned.

## Route Topology
- Public routes: login, signup, policy pages
- Authenticated student routes: feed, post detail, profile, messaging
- Moderator routes: report queue, case details, enforcement tools
- Admin routes: role management, policy configuration

## Navigation Strategy
- Use a dedicated router module with named, typed routes.
- Route guards check auth state, campus verification, and roles.
- Preserve tab state across feed/profile/messaging transitions.

## Deep Linking
- Link formats:
  - `/posts/{postId}`
  - `/messages/{conversationId}`
  - `/moderation/reports/{reportId}`
- Invalid targets route to structured error screens.

## Transition and UX Rules
- Use consistent transition animations per route class.
- Avoid nested navigators unless feature shell demands it.
- Keep back stack deterministic for moderation and messaging flows.

## Key Design Decision
Context: Navigation complexity grows with messaging and moderation.
Problem: Unstructured push/pop logic breaks deep linking and guards.
Decision: Central typed routing with role-aware route guards.
Alternatives considered: continue with local `MaterialPageRoute` usage.
Tradeoffs: initial router setup and migration effort.
Long-term implications: robust navigation and feature isolation.

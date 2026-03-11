# Product Requirements

## Product Vision
Campus Connect is a FAST-NUCES-only Reddit-style platform where students discover posts through feeds, go deep through comments, organize around communities, and return through notifications, reputation, and trusted campus identity.

## Product Experience Principles
- Feed-first browsing must feel fast and intuitive.
- Comment threads must become the deepest engagement surface.
- Communities are the primary organizational model, not flat categories alone.
- Voting, saving, and joining should remain lightweight.
- Moderation and policy visibility must be built into the product.
- FAST-only access is a product trust feature, not just a login constraint.

## Core User Journeys
- Browse Home, Popular, and joined community feeds.
- Search posts, communities, comments, and people.
- Open a post and dive into a ranked comment thread.
- Create text, image, link, video, and poll posts in the correct community.
- Save, share, hide, report, and follow content.
- Return through inbox activity, reply notifications, and profile history.

## Functional Requirements
- FAST-scoped authentication and identity verification.
- Home feed, discovery feed, and community feed experiences.
- Community model with join/leave, rules, moderators, and pinned posts.
- Post detail and comment thread with voting, replies, and sorting.
- Post composer supporting phased expansion from text/image to richer post types.
- User profile with posts, comments, saved items, and reputation signals.
- Notifications/inbox for replies, mentions, moderation, and activity.
- Direct messaging with safety controls.
- Reporting, moderation queueing, enforcement, and auditability.
- FAST-specific workflows for notes, jobs, events, and lost & found.

## Non-Functional Requirements
- Security: deny-by-default access, ownership enforcement, and trusted privileged actions.
- Reliability: safe retries, idempotent writes for high-value flows, and failure recovery.
- Performance: low-latency feed loading, fast thread opening, and predictable scroll behavior.
- Maintainability: feature-module architecture with documented contracts and ADRs.
- Accessibility: WCAG-aligned controls, semantics, and reduced-friction interaction patterns.

## Platform Constraints
- Firebase/Firestore query and indexing constraints shape ranking and thread modeling.
- Mobile-first UX is required; web/desktop support follows once core loops stabilize.
- Moderator bandwidth is limited, so tooling and automation are mandatory.
- Public content must still respect university safety and governance constraints.

## Success Metrics
- Daily and weekly active FAST students.
- Feed-to-thread conversion rate.
- Comment depth per active post.
- Community join and revisit rate.
- Notification-driven return sessions.
- Moderation SLA compliance and appeal reversal rate.
- Feature lead time and regression escape rate.

# Software System Design

## Design Goals
- Keep feature implementation independent across teams.
- Make security and moderation enforceable in backend policy layers.
- Ensure new domain objects can be introduced without rewriting existing modules.

## C4-Level View
### Context
Actors:
- Student
- Moderator
- Platform Admin
External Systems:
- Firebase Auth
- Firestore
- Cloudinary
- Notification providers

### Containers
- Flutter App Container
- Firebase Services Container
- Moderation Automation Container
- Media Processing Container

### Components (Client)
- Feature modules (`auth`, `posts`, `comments`, `messaging`, `moderation`, `profiles`)
- Shared platform services (logging, telemetry, failure mapping)
- Design system package (tokens, components, accessibility contracts)

## Sequence Design: Create Post
1. UI submits `CreatePostCommand`.
2. Application service validates command invariants.
3. Repository writes post in pending moderation state if risk score high, otherwise published.
4. Trigger updates search fields and derived ranking attributes.
5. Feed provider invalidates and refreshes affected query scopes.

## Sequence Design: Send Message
1. User enters conversation and sends text/media.
2. Safety pre-check validates mute/suspension and content constraints.
3. Message persisted in `conversations/{id}/messages/{id}`.
4. Conversation summary updated atomically (`lastMessageAt`, `lastMessagePreview`).
5. Report hooks and abuse scoring evaluate message asynchronously.

## Sequence Design: Moderator Action
1. Moderator opens report from queue.
2. System displays evidence snapshot and user history.
3. Moderator selects action + policy code.
4. Action writes immutable `moderation_actions` and updates target content/user state.
5. Notification dispatch and appeal timer scheduled.

## Reliability and Consistency Model
- Strong consistency for single-document reads/writes.
- Eventual consistency for counters, rankings, and moderation analytics.
- Compensating jobs for counter drift and stale denormalized fields.

## Security Controls
- Firestore rules enforce resource ownership, campus scope, and role checks.
- Sensitive moderation writes restricted to moderator/admin claims.
- All high-risk actions logged with actor metadata and correlation id.

## Decision Record References
- `engineering-foundation/decision-records/major-architecture-decisions.md`
- `engineering-foundation/architecture/moderation-system-design.md`
- `engineering-foundation/architecture/messaging-system-design.md`

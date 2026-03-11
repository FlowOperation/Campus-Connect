# Firestore Data Model

## Modeling Principles
- Prefer immutable event logs for enforcement history.
- Use denormalized summaries for read-heavy screens.
- Include `schemaVersion` for all mutable entities.
- Store `campusId` on all campus-bound entities.

## Core Collections
### users
Fields:
- `displayName`, `email`, `campusId`, `roles`, `status`, `createdAt`, `lastSeenAt`

### posts
Fields:
- `authorId`, `campusId`, `category`, `title`, `body`, `media`, `status`, `score`, `commentCount`, `createdAt`, `updatedAt`, `schemaVersion`

### comments
Fields:
- `postId`, `authorId`, `campusId`, `parentCommentId`, `body`, `status`, `score`, `createdAt`

### votes
Fields:
- `targetType`, `targetId`, `userId`, `value`, `createdAt`

### bookmarks
Fields:
- `userId`, `postId`, `createdAt`

### conversations
Fields:
- `participantIds`, `campusIds`, `lastMessageAt`, `lastMessagePreview`, `status`

### conversations/{id}/messages
Fields:
- `senderId`, `content`, `contentType`, `moderationState`, `createdAt`, `isDeleted`

### reports
Fields:
- `sourceType`, `sourceId`, `reporterId`, `reasonCode`, `details`, `status`, `priority`, `createdAt`

### moderation_actions
Fields:
- `reportId`, `targetType`, `targetId`, `actionType`, `policyCode`, `actorId`, `expiresAt`, `createdAt`

### audit_logs
Fields:
- `entityType`, `entityId`, `action`, `actorId`, `correlationId`, `metadata`, `createdAt`

## Index Strategy
Required composite indexes:
- `posts`: (`campusId`, `status`, `hotScore desc`, `createdAt desc`)
- `comments`: (`postId`, `status`, `createdAt asc`)
- `reports`: (`status`, `priority desc`, `createdAt asc`)
- `conversations`: (`participantIds array-contains`, `lastMessageAt desc`)

## Retention and Archival
- Keep active content indefinitely unless removed by policy.
- Archive closed reports older than 365 days.
- Archive audit entries to cold store after 18 months.

## Key Design Decision
Context: Firestore query model requires index-first schema planning.
Problem: Ad hoc fields cause query and migration churn.
Decision: Define canonical collections and explicit indexes up front.
Alternatives considered: evolve schema only when queries fail.
Tradeoffs: upfront design effort and index management.
Long-term implications: stable query performance and easier governance.

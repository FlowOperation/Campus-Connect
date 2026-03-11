# Firestore Data Model

## Modeling Principles
- Prefer immutable event logs for enforcement history.
- Use denormalized summaries for read-heavy screens.
- Include `schemaVersion` for all mutable entities.
- Store `campusId` on all campus-bound entities.
- Model communities explicitly rather than relying only on post categories.
- Preserve enough metadata for feed cards, threads, and inbox projections.

## Core Collections
### users
Fields:
- `displayName`, `email`, `campusId`, `department`, `batchYear`, `roles`, `status`, `karma`, `createdAt`, `lastSeenAt`

### communities
Fields:
- `name`, `slug`, `displayName`, `description`, `campusId`, `communityType`, `rules`, `moderatorIds`, `memberCount`, `createdAt`, `status`

### community_memberships
Fields:
- `communityId`, `userId`, `role`, `joinedAt`, `notificationLevel`

### posts
Fields:
- `authorId`, `communityId`, `campusId`, `category`, `postType`, `title`, `body`, `linkUrl`, `media`, `flairId`, `status`, `score`, `commentCount`, `createdAt`, `updatedAt`, `isPinned`, `isSpoiler`, `schemaVersion`

### comments
Fields:
- `postId`, `authorId`, `campusId`, `parentCommentId`, `depth`, `body`, `status`, `score`, `replyCount`, `createdAt`

### votes
Fields:
- `targetType`, `targetId`, `userId`, `value`, `createdAt`

### saves
Fields:
- `userId`, `targetType`, `targetId`, `createdAt`

### hidden_items
Fields:
- `userId`, `targetType`, `targetId`, `createdAt`

### notifications
Fields:
- `userId`, `type`, `sourceType`, `sourceId`, `actorId`, `readAt`, `createdAt`, `metadata`

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
- `posts`: (`communityId`, `status`, `hotScore desc`, `createdAt desc`)
- `posts`: (`campusId`, `status`, `createdAt desc`)
- `comments`: (`postId`, `status`, `score desc`, `createdAt asc`)
- `notifications`: (`userId`, `createdAt desc`)
- `community_memberships`: (`userId`, `joinedAt desc`)
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

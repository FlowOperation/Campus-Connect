# Messaging System Design

## Goals
- Provide safe, private student messaging.
- Preserve low-latency real-time UX.
- Embed moderation and abuse prevention from day one.

## Messaging Capabilities
- 1:1 conversations
- Future-ready path for small group threads
- Real-time updates and read states
- Message reporting and evidence capture

## Data Model
- `conversations/{conversationId}`
  - `participantIds`
  - `campusIds`
  - `lastMessageAt`
  - `lastMessagePreview`
  - `status` (`active`, `restricted`, `archived`)
- `conversations/{conversationId}/messages/{messageId}`
  - `senderId`
  - `content`
  - `contentType`
  - `createdAt`
  - `moderationState`
  - `isDeleted`

## Delivery Flow
1. Client validates local draft constraints.
2. Backend rules ensure sender is participant and not suspended.
3. Message write succeeds and stream updates subscribers.
4. Async moderation hook computes risk and updates state if needed.

## Real-Time Strategy
- Stream only active conversation window.
- Paginate older messages with cursor-based fetch.
- Keep lightweight conversation summary in parent document.

## Safety and Moderation Hooks
- User-level mute/block list checked before send.
- Message reporting creates `reports` with source type `message`.
- High-risk messages can be hidden pending review.
- Repeat abuse triggers progressive send cooldown.

## Privacy and Data Handling
- Strict participant-only read rules.
- Soft delete for user view, hard delete for policy/legal workflows.
- Retention policy configurable by jurisdiction and institutional policy.

## Failure Handling
- Idempotent send keys prevent duplicate messages on retries.
- Offline queue with explicit send states (`queued`, `sent`, `failed`).
- Delivery reconciliation job for stuck pending statuses.

## Key Design Decision
Context: Messaging can quickly become abuse-prone without safety controls.
Problem: Introducing moderation later creates migration and trust issues.
Decision: Ship messaging with built-in reporting, risk scoring, and enforcement hooks.
Alternatives considered: launch plain chat first; rely only on manual reports.
Tradeoffs: slower initial feature delivery.
Long-term implications: safer messaging growth and reduced incident response cost.

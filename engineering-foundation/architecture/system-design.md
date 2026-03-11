# System Design

## Architecture Overview
Campus Connect uses a client-heavy architecture with backend-enforced security and moderation controls.

## System Components
- Mobile/Web Client (Flutter)
- Auth Service (Firebase Auth)
- Data Store (Cloud Firestore)
- Automation Layer (Cloud Functions)
- Media Service (Cloudinary)
- Observability Layer (Crashlytics, Analytics, moderation metrics)

## Component Responsibilities
- Client
  - Render UI and perform optimistic interaction updates.
  - Execute use cases via repositories and providers.
- Auth
  - Identity verification and token claims (`role`, `campus`, `isStudentVerified`).
- Firestore
  - Source of truth for content, moderation, and messaging state.
- Cloud Functions
  - Enforce server-side invariants, anti-spam checks, denormalization, and notifications.
- Cloudinary
  - Upload, validate, and transform media assets.

## Data Flow (Core Discussion)
1. User submits post draft.
2. Client validates locally and writes `posts/{postId}` through repository.
3. Firestore rules verify auth, campus match, and allowed fields.
4. Trigger function enriches document (derived counters, moderation score, searchable terms).
5. Feed queries read campus-scoped, status-filtered posts.

## Data Flow (Moderation)
1. User reports post/comment/message.
2. `reports` document created with immutable evidence snapshot.
3. Automation assigns queue priority using rule scores.
4. Moderator action writes `moderation_actions` and target status update.
5. Audit pipeline records actor, reason, timestamp, and reversibility metadata.

## Firestore Collections (Top-Level)
- `users`
- `campuses`
- `posts`
- `comments`
- `votes`
- `bookmarks`
- `conversations`
- `messages`
- `reports`
- `moderation_actions`
- `audit_logs`
- `announcements`
- `feature_flags`

## Messaging Architecture Summary
- Conversation metadata and participant access control in `conversations`.
- Message stream in `messages` subcollections with pagination cursor on `createdAt`.
- Safety hooks for report, mute, and temporary send restrictions.

## Moderation Flow Summary
- Multi-stage queue: `new`, `triage`, `actioned`, `appealed`, `closed`.
- Actions: `dismiss`, `remove_content`, `warn_user`, `suspend_user`, `shadow_ban`.
- Every action must include policy reference and optional expiration.

## Scaling Strategy
- Campus-scoped partition keys to keep hot query ranges bounded.
- Precomputed feed score fields to avoid complex client sorting.
- Counter fan-out documents to avoid hot single-document updates.
- TTL/archival policies for low-value historical moderation artifacts.

## Failure Handling
- Client retry with idempotency keys for write operations.
- Circuit breakers for media upload failure fallback.
- Dead-letter collection for failed moderation automation.
- Reconciliation jobs for counters and orphaned references.

## Operational Readiness
- SLO dashboard for feed, message, and moderation latency.
- Weekly schema compatibility checks.
- Incident runbooks for abuse spikes and Firestore quota pressure.

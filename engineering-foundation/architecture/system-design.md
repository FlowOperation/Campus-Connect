# System Design

## Architecture Overview
Campus Connect uses a client-heavy architecture with backend-enforced security and moderation controls to deliver a FAST-only Reddit-style experience made of feeds, communities, threads, inbox, and moderation surfaces.

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

## Data Flow (Community Browsing)
1. User opens Home or a specific community page.
2. Client loads feed summaries filtered by joined communities, campus scope, and selected ranking mode.
3. Community metadata provides rules, pinned posts, moderator list, and flair options.
4. User joins/leaves community and the membership projection updates future feed relevance.

## Data Flow (Thread Engagement)
1. User opens a post from any feed.
2. Client loads full post content, media, score, save state, and thread metadata.
3. Comment read model loads top-level comments plus reply branches.
4. User votes, replies, saves, shares, or reports from the thread.
5. Thread activity updates counters, ranking signals, and inbox notifications.

## Data Flow (Moderation)
1. User reports post/comment/message.
2. `reports` document created with immutable evidence snapshot.
3. Automation assigns queue priority using rule scores.
4. Moderator action writes `moderation_actions` and target status update.
5. Audit pipeline records actor, reason, timestamp, and reversibility metadata.

## Firestore Collections (Top-Level)
- `users`
- `campuses`
- `communities`
- `community_memberships`
- `posts`
- `comments`
- `votes`
- `saves`
- `hidden_items`
- `notifications`
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

## UX-Critical Surfaces
- Home feed
- Popular/discovery feed
- Community page
- Post detail + comments thread
- Create post flow
- Inbox/notifications
- Profile
- Settings
- Moderator queue and action screens

## Failure Handling
- Client retry with idempotency keys for write operations.
- Circuit breakers for media upload failure fallback.
- Dead-letter collection for failed moderation automation.
- Reconciliation jobs for counters and orphaned references.

## Operational Readiness
- SLO dashboard for feed, message, and moderation latency.
- Weekly schema compatibility checks.
- Incident runbooks for abuse spikes and Firestore quota pressure.

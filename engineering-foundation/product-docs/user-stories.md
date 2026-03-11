# User Stories

## Story 1: Student Authentication
As a FAST student
I want to sign in using my institutional email
So that only verified students can access the platform

Acceptance criteria:
- Sign-in allows only approved FAST domains.
- Unverified or invalid domain users are denied with clear reason.
- Verified users are assigned campus and baseline role claims.

Edge cases:
- User has valid domain but missing campus mapping.
- User account exists but is suspended.

Technical notes:
- Enforce domain checks in auth onboarding service.
- Persist verification and campus in `users` document.

## Story 2: Create Campus-Scoped Post
As a student
I want to publish a categorized post
So that peers in my campus can discover relevant information

Acceptance criteria:
- Post requires title, body, and category.
- Post appears in campus feed after successful write.
- Invalid payloads are rejected with field-level feedback.

Edge cases:
- Duplicate rapid submissions.
- Post flagged as high-risk by moderation automation.

Technical notes:
- Use idempotency token for submission retries.
- Write includes `campusId` and `schemaVersion`.

## Story 3: Vote and Bookmark
As a student
I want to vote and bookmark content
So that I can signal quality and save useful posts

Acceptance criteria:
- Vote state toggles correctly and updates score.
- Bookmark state persists per user.
- Unauthorized users cannot modify vote/bookmark state.

Edge cases:
- Offline interactions replay after reconnect.
- Simultaneous vote changes from multiple clients.

Technical notes:
- Use sharded counters and conflict-safe updates.

## Story 4: Report Harmful Content
As a student
I want to report abusive or unsafe content
So that moderators can take action quickly

Acceptance criteria:
- Report form requires reason code.
- Report enters moderation queue with priority metadata.
- Reporter receives confirmation without exposing moderator internals.

Edge cases:
- Reported content deleted before review.
- Malicious repetitive reporting by one user.

Technical notes:
- Persist evidence snapshot and reporter trust factors.

## Story 5: Moderator Enforcement
As a moderator
I want to review reports and enforce policies
So that community rules are applied consistently

Acceptance criteria:
- Moderator can dismiss, remove content, warn, or suspend.
- Every action requires policy code and rationale.
- Actions are fully logged for audits and appeals.

Edge cases:
- Conflicting actions by two moderators.
- Appeal submitted after enforcement expiration.

Technical notes:
- Use optimistic lock/version checks on report state.

## Story 6: Direct Messaging Safety
As a student
I want private messaging with safety controls
So that I can collaborate without harassment risks

Acceptance criteria:
- Only conversation participants can read/send messages.
- Users can report and block abusive senders.
- Suspended users cannot send messages.

Edge cases:
- Message delivery retries create duplicates.
- One participant blocks the other mid-conversation.

Technical notes:
- Require idempotency key for sends and participant rule checks.

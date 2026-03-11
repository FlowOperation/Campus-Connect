# Security Rules Design

## Principles
- Deny by default.
- Validate shape, ownership, and role in every write rule.
- Restrict cross-campus data access.
- Keep moderator/admin operations server-mediated where possible.

## Identity Preconditions
Rules rely on token claims:
- `request.auth != null`
- `request.auth.token.campus`
- `request.auth.token.role`
- `request.auth.token.isStudentVerified`

## Collection Rule Matrix
- `posts`: students can create within own campus, update/delete own active content.
- `comments`: students can create in visible posts and own campus.
- `votes` and `bookmarks`: owner-only write and delete.
- `conversations`: participant-only read; creation requires own identity in participants.
- `messages`: participant-only read/write, send blocked for suspended users.
- `reports`: authenticated create; only moderators/admin read all.
- `moderation_actions` and `audit_logs`: write via trusted backend only.

## Validation Rules
- Max length checks for titles, comments, and messages.
- Allowed enum values for category/status/action fields.
- Immutable fields after creation (`authorId`, `campusId`, `createdAt`).

## Rate Limiting Strategy
Rules cannot provide robust global rate limiting alone.
Use layered control:
- Cloud Functions write gate with per-user quota docs
- App Check signals
- Spam score thresholds triggering temporary cooldown

## Abuse Prevention
- Block prohibited links or patterns through server-side validation.
- Restrict bulk operations to moderator/admin claims.
- Enforce suspension and shadow-ban state checks in send/post endpoints.

## Key Design Decision
Context: Client app is trusted UX but untrusted execution environment.
Problem: Weak rules can expose all content and admin actions.
Decision: strict rule matrix plus server-only privileged writes.
Alternatives considered: minimal ownership checks only.
Tradeoffs: more rules maintenance and test complexity.
Long-term implications: reduced abuse blast radius and better compliance posture.

# Firebase Architecture

## Service Map
- Firebase Auth: identity and custom claims
- Firestore: primary data store
- Cloud Functions: workflows, moderation automation, counters, notifications
- Firebase Storage: optional fallback for media metadata
- App Check: anti-abuse signal for client requests

## Auth Strategy
- Restrict sign-in to approved FAST-NUCES domains.
- Assign custom claims:
  - `role`: `student`, `moderator`, `admin`
  - `campus`: campus code
  - `isStudentVerified`: boolean
- Claims refreshed on role changes and disciplinary actions.

## Firestore Strategy
- Campus-scoped reads by default.
- Denormalized read models for feed and messaging summaries.
- Append-only logs for moderation and security events.

## Functions Strategy
- Firestore triggers:
  - post/comment creation enrichment
  - report triage scoring
  - message safety checks
- Scheduled jobs:
  - counter reconciliation
  - stale report cleanup
  - suspension expiration handlers

## Security Posture
- Deny by default in rules.
- Server-side privileged actions via Cloud Functions only.
- App Check enforcement for production clients.

## Key Design Decision
Context: Firebase supports rapid delivery but needs explicit boundaries at scale.
Problem: Unbounded client-side logic weakens security and consistency.
Decision: Use Firestore rules plus Cloud Functions for privileged workflows.
Alternatives considered: full custom backend now; client-only Firebase interactions.
Tradeoffs: added operational complexity.
Long-term implications: stronger security and predictable platform behavior.

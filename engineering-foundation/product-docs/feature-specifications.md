# Feature Specifications

## Core Discussion
### Includes
- Post creation/edit lifecycle
- Threaded comments
- Vote and bookmark interactions
- Category and search filtering

### Technical requirements
- Campus-aware query filtering
- Pagination and denormalized feed summary
- Moderation status states (`visible`, `hidden`, `removed`)

## Messaging
### Includes
- 1:1 conversation creation
- Real-time message stream
- Read receipts (phase-ready)
- Report, block, and mute controls

### Technical requirements
- Participant-only access rules
- Message idempotency and retry-safe delivery
- Moderation risk hooks

## Moderation
### Includes
- Reporting intake
- Queue triage and case handling
- Enforcement action tracking
- Appeals and audit logs

### Technical requirements
- Policy code taxonomy
- Immutable evidence snapshots
- SLA tracking and dashboard metrics

## Community Infrastructure
### Includes
- Announcement posts
- Pinned posts per campus
- Verified moderator badges
- Community guideline surfacing

### Technical requirements
- Role-based publishing rights
- Priority placement in feed ranking

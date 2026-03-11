# Scalability Strategy

## Capacity Assumptions
Initial target:
- 20k monthly active students
- 3k daily active users
- Peak concurrent users: 600
- Peak write throughput during events/exams

## Scaling Axes
- Campus partitioning
- Feature partitioning (discussion vs messaging vs moderation)
- Time partitioning (hot recent data vs cold archive)

## Read Scalability
- Composite indexes for primary feed and moderation queue queries.
- Cursor-based pagination only, no offset pagination.
- Precomputed sorting fields: `hotScore`, `engagementScore`, `lastActivityAt`.
- Cache frequent profile lookups in lightweight denormalized snapshots.

## Write Scalability
- Avoid hot documents for counters by sharded counter pattern.
- Use append-only audit logs rather than in-place mutation history.
- Move expensive fan-out tasks to Cloud Functions.

## Messaging Scale Plan
- Conversation-level partitioning with bounded participants.
- `messages` subcollection pagination with reverse chrono cursors.
- Retention strategy for old message attachments and deleted artifacts.

## Moderation Scale Plan
- Priority report queues (`severity`, `reportCount`, `policyRisk`).
- Automation for duplicate report collapse.
- Batch workflows for mass spam waves.

## Failure and Backpressure Strategy
- Temporary feature degradation under quota pressure:
  - Disable rich media upload
  - Delay ranking refresh jobs
  - Keep posting and moderation functional
- Queue overflow handling with deferred processing and SLA tags.

## Migration and Evolution
- Versioned document schemas (`schemaVersion`).
- Rolling migration jobs with progress checkpoints.
- Compatibility adapters in repositories for mixed-version documents.

## Key Design Decision
Context: Firestore scales well but hot paths can degrade with unbounded writes.
Problem: Feed counters and messaging updates can create hotspots.
Decision: Use sharded counters, denormalized summaries, and asynchronous enrichment.
Alternatives considered: migrate early to custom backend; use only real-time fan-out writes.
Tradeoffs: more moving parts and reconciliation jobs.
Long-term implications: sustained performance growth without early replatforming.

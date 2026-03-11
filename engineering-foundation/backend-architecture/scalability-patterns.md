# Backend Scalability Patterns

## Pattern 1: Denormalized Read Models
Use summary documents for feed cards, conversation lists, and moderation dashboards.

## Pattern 2: Sharded Counters
Apply for hot metrics:
- post score
- comment count
- report count

## Pattern 3: Event-Driven Enrichment
Firestore writes trigger asynchronous updates for:
- ranking scores
- moderation risk tags
- notification fan-out

## Pattern 4: Campus Segmentation
Always include `campusId` in indexed queries to prevent global hot partitions.

## Pattern 5: Queue-Based Moderation
Separate report intake from action processing to absorb traffic spikes.

## Pattern 6: Progressive Degradation
Under load:
- preserve auth and posting
- defer expensive ranking recomputation
- limit non-critical media transforms

## Pattern 7: Schema Versioning
Introduce compatibility adapters for rolling upgrades and mixed-version docs.

## Key Design Decision
Context: MVP traffic assumptions do not hold during campus events.
Problem: Synchronous all-in-one workflows risk latency spikes and quota strain.
Decision: asynchronous enrichment and queue-backed operations.
Alternatives considered: immediate consistency for all derived state.
Tradeoffs: eventual consistency and reconciliation complexity.
Long-term implications: resilient performance under growth.

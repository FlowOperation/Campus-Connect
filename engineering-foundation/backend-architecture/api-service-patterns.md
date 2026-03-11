# API and Service Patterns

## Boundary Strategy
Although Firebase is backend-as-a-service, treat Cloud Functions as platform APIs for privileged and cross-aggregate workflows.

## API Types
- Callable functions for authenticated client operations requiring server trust.
- HTTP functions for admin tooling and integrations.
- Firestore-trigger functions for asynchronous enrichment.

## Service Contracts
Every service operation defines:
- Input command schema
- Validation rules
- Authorization requirement
- Idempotency behavior
- Response schema with error categories

## Recommended Operations
- `createPost`, `deletePost`, `toggleVote`, `toggleBookmark`
- `reportContent`, `moderateReport`, `applyUserSanction`
- `createConversation`, `sendMessage`, `reportMessage`

## Error Taxonomy
- `validation_error`
- `permission_denied`
- `policy_violation`
- `rate_limited`
- `transient_failure`

## Idempotency
- Message send and moderation action endpoints require client-generated idempotency keys.
- Duplicate keys return previous success payload.

## Observability Requirements
- Log structured fields: `operation`, `actorId`, `targetId`, `correlationId`, `status`.
- Emit metrics for latency, error rate, and policy rejections.

## Key Design Decision
Context: Client-only writes are fast but insufficient for privileged workflows.
Problem: Moderation and sanctions need auditable trusted execution.
Decision: Route privileged operations through Cloud Function APIs.
Alternatives considered: direct Firestore writes for all operations.
Tradeoffs: extra backend logic and deployment process.
Long-term implications: enforceable policy and safer operations.

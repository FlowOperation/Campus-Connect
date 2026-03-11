# State Management Strategy

## Riverpod Strategy
- Use `Notifier`/`AsyncNotifier` for application state.
- Keep ephemeral UI-only state local to widgets when possible.
- Repositories injected through providers with interface abstractions.

## State Categories
- Session state: authenticated user, campus, role claims.
- Feature state: feed filters, post draft, messaging thread view.
- Derived state: computed rankings, display flags, permission gates.

## Patterns
- Command provider for write operations with explicit result types.
- Query provider for read models and paginated streams.
- Side effects isolated in application layer services.

## Anti-Patterns to Avoid
- Direct Firestore writes from widgets.
- Providers that mix unrelated concerns.
- Global mutable singletons bypassing Riverpod.

## Error and Retry Model
- Return typed failures (`ValidationFailure`, `PermissionFailure`, `NetworkFailure`).
- Retry only idempotent writes with bounded attempts.
- Surface moderation or policy failures explicitly to users.

## Observability
- Track provider state transitions for high-value flows.
- Capture failure metrics by feature and operation.

## Key Design Decision
Context: MVP uses Riverpod but with variable granularity.
Problem: Mixed responsibilities can create fragile dependency chains.
Decision: Separate command/query providers and isolate side effects.
Alternatives considered: switch to BLoC; keep ad hoc provider style.
Tradeoffs: additional provider definitions.
Long-term implications: predictable state flows and easier testing.

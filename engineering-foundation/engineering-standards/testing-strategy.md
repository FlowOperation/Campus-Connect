# Testing Strategy

## Test Pyramid
- Unit tests: domain entities, policies, use cases
- Integration tests: repository and Firestore serialization paths
- Widget tests: key interactive flows
- End-to-end smoke tests: auth, post, messaging, moderation report

## Required Coverage Areas
- Authentication and role/campus assignment
- Post/comment creation and moderation visibility states
- Vote/bookmark consistency under concurrent updates
- Messaging send/report/block flows
- Moderator actions and audit log creation

## Quality Gates
- `dart format --set-exit-if-changed .`
- `flutter analyze --no-fatal-infos`
- `flutter test`

## Reliability Testing
- Retry/idempotency behavior under flaky network simulation
- Counter reconciliation correctness tests
- Security rule tests for role and ownership boundaries

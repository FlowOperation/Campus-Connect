# Feature Module Pattern

## Module Contract
Each feature contains:
- `presentation/`: screens, view models, components
- `application/`: use cases and command/query handlers
- `domain/`: entities, policies, interfaces
- `infrastructure/`: repository implementations, mappers, gateways

## Example: Posts Feature
```text
features/posts/
  presentation/
    screens/
    components/
    providers/
  application/
    create_post_use_case.dart
    vote_post_use_case.dart
  domain/
    post.dart
    post_repository.dart
  infrastructure/
    firestore_post_repository.dart
    post_dto.dart
```

## Dependency Rules
- Presentation depends on application abstractions only.
- Application depends on domain interfaces.
- Infrastructure implements domain interfaces.
- Cross-feature access goes through application contracts, never direct infra imports.

## Testing Requirements per Module
- Domain unit tests for invariants.
- Application tests for use case orchestration.
- Infrastructure tests for serialization and rule-compliant writes.
- Golden/widget tests for high-value UI states.

## Key Design Decision
Context: Feature growth includes messaging, moderation, and new content types.
Problem: Flat organization increases coupling and slows changes.
Decision: Enforce per-feature layered modules with clear boundaries.
Alternatives considered: global layer folders only; plugin-based micro-apps.
Tradeoffs: more folders and explicit interfaces.
Long-term implications: independent feature velocity and easier refactors.

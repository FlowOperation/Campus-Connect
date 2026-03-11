# Flutter Architecture

## Target Module Structure
```text
lib/
  app/
    app.dart
    router/
    theme/
  core/
    errors/
    logging/
    networking/
    utils/
  shared/
    components/
    tokens/
    services/
  features/
    auth/
      presentation/
      application/
      domain/
      infrastructure/
    posts/
    comments/
    messaging/
    moderation/
    profiles/
```

## Layer Responsibilities
- Presentation
  - Widgets, screen composition, input handling, UI state projection.
- Application
  - Use cases, command handlers, and orchestration.
- Domain
  - Entities, rules, and policy abstractions.
- Infrastructure
  - Firebase adapters, DTO mappers, and persistence implementations.

## Conventions
- One feature must not import another feature's infrastructure layer.
- Shared code only in `core` or `shared` after explicit reuse validation.
- Navigation targets expose typed route arguments.
- Feature APIs are exposed through barrel files.

## Error Handling
- Convert platform exceptions into typed failures.
- Show user-safe messages; log detailed diagnostics separately.
- Use retry strategies only for idempotent operations.

## Performance Guidelines
- Keep rebuild surfaces narrow with provider selection.
- Use paginated list controllers for feed and messaging.
- Avoid large synchronous transformations in widget tree.

## Migration Strategy from Current MVP
1. Create `features` skeleton without changing behavior.
2. Move services/repositories behind interfaces.
3. Incrementally migrate screens and providers by feature.
4. Remove legacy global dependencies after parity tests pass.

## Key Design Decision
Context: Existing structure is layer-aware but screen-centric.
Problem: Feature expansion causes ownership ambiguity.
Decision: Adopt feature modules with internal layered boundaries.
Alternatives considered: package-per-layer; retain current global folders.
Tradeoffs: migration overhead and temporary duplication.
Long-term implications: better team parallelization and simpler onboarding.

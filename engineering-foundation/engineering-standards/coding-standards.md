# Coding Standards

## General Standards
- Follow Dart style guide and strict linting.
- Prefer composition over inheritance in feature code.
- Keep functions small and side-effect boundaries explicit.

## Naming and Structure
- Use feature-centric paths and clear suffixes (`Repository`, `UseCase`, `Dto`).
- Avoid generic names like `Helper` or `Manager`.
- One responsibility per class.

## Error Handling
- Use typed failures, never raw exception strings in domain/application layers.
- Map infrastructure exceptions at boundary adapters.

## Security Standards
- Never trust client-provided role or campus fields.
- Validate all write payloads in rules and/or trusted backend.

## Review Standards
- PRs must include tests for new behavior.
- Architecture-affecting changes require ADR entry.

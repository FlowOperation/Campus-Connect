# Feature Modules

This folder follows the phase-1 modular structure from `engineering-foundation/frontend-architecture/flutter-architecture.md`.

Each feature uses four layers:
- `presentation`: UI screens/widgets and view wiring
- `application`: use cases and orchestration
- `domain`: entities and contracts
- `infrastructure`: data access and adapters

Current migration status:
- `auth`, `posts`, and `profiles` presentation layers are migrated.
- Additional layers are scaffolded for incremental migration.

# Versioning Strategy

## Semantic Versioning
- MAJOR: incompatible API/behavior changes
- MINOR: backward-compatible features
- PATCH: backward-compatible fixes

## Release Channels
- `alpha`: active development and validation
- `beta`: feature complete with stabilization focus
- `stable`: production-ready

## Change Management
- Every release includes migration notes for schema and rules changes.
- Firestore schema versions tracked in docs and code.
- Security rule changes tagged as high-risk and require extra review.

## Rollback Strategy
- Keep reversible migrations where possible.
- Use feature flags for risky launches.
- Maintain last-known-good release artifacts.

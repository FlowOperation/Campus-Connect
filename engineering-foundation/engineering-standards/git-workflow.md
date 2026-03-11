# Git Workflow

## Branch Strategy
- `main`: protected, release-ready
- `develop` (optional): integration branch for coordinated work
- Feature branches: `feature/<scope>-<short-name>`
- Hotfix branches: `hotfix/<issue>`

## Commit Standards
- Conventional commits (`feat`, `fix`, `refactor`, `docs`, `test`, `chore`).
- Keep commits atomic and reviewable.

## Pull Request Requirements
- Clear problem statement and scope.
- Linked issue or roadmap item.
- Test evidence and screenshots for UI changes.
- Mention ADR updates when architecture changes.

## Merge Policy
- No direct commits to protected branches.
- Require successful CI and at least one reviewer approval.

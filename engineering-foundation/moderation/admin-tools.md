# Admin Tools

## Required Interfaces
- Moderator role assignment and revocation.
- Policy code management.
- Queue SLA monitoring dashboard.
- Sanction lifecycle management.

## Operational Controls
- Bulk content takedown for coordinated abuse.
- Temporary feature toggles during incidents.
- Campus-level enforcement controls.

## Auditability
- Every admin action writes immutable `audit_logs` entry.
- Include before/after payload hash for policy and role changes.
- Export path for governance and compliance review.

## Safety Controls
- Two-step confirmation for irreversible actions.
- Optional dual-approval for permanent bans and policy edits.
- Least-privilege defaults for admin console accounts.

# Moderation System Design

## Objectives
- Protect student safety and platform trust.
- Provide transparent and reversible moderation actions.
- Minimize moderator toil with automation and prioritization.

## Moderation Roles
- Student: can report and appeal.
- Moderator: can triage reports and execute content/user actions.
- Senior Moderator: can review appeals and override decisions.
- Admin: can manage roles, global policies, and sanctions.

## Report Queue Architecture
Collections:
- `reports` for incoming reports
- `moderation_queues` for priority state
- `moderation_actions` for final decisions

Queue states:
- `new`
- `triage`
- `waiting_evidence`
- `actioned`
- `appealed`
- `closed`

Priority factors:
- Category severity
- Duplicate report count
- Reporter trust score
- Content risk score from automation

## Automated Spam Detection
Signals:
- Rapid repeated posting
- Link-only or suspicious URL patterns
- Similarity hash collisions
- Excessive mentions or repeated invites

Actions:
- Auto-hide high-risk content pending moderator review
- Rate-limit posting/messaging for risk window
- Escalate repeated offenders

## Enforcement Actions
- `dismiss_report`
- `remove_content`
- `warn_user`
- `temporary_suspension`
- `shadow_ban`
- `permanent_ban`

Every action must capture:
- policy reference code
- actor id and role
- evidence pointers
- expiration and appeal eligibility

## Shadow Ban Design
- Content remains visible to actor but hidden for others.
- Actor receives no immediate ban notification.
- Used for persistent low-quality spam patterns.
- Requires senior moderator review if > 7 days.

## Audit Log Requirements
- Immutable append-only logs in `audit_logs`.
- Correlation id linking report, action, and notifications.
- Export pipeline for governance reviews.

## Moderator Dashboard Requirements
- SLA timers by queue severity.
- Case timeline and prior offense history.
- One-click policy snippets and action templates.
- Bulk actions for coordinated spam events.

## Key Design Decision
Context: Manual moderation does not scale during event spikes.
Problem: Report volume can exceed moderator throughput and increase unsafe exposure windows.
Decision: Hybrid moderation with automated triage plus human final actions.
Alternatives considered: fully manual moderation; fully automated moderation.
Tradeoffs: operational complexity and model false positives.
Long-term implications: scalable safety posture with human accountability.

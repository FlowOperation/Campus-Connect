# Reporting System

## Report Intake
Supported sources:
- post
- comment
- message
- user profile

Mandatory fields:
- source id
- reason code
- optional details
- reporter id
- created timestamp

## Queueing Model
- Report is normalized and assigned priority.
- Duplicate reports on same source are grouped.
- Severity boosts for safety-related categories.

## Reason Codes
- harassment
- hate_speech
- spam
- misinformation
- impersonation
- explicit_content
- self_harm_risk

## Evidence Handling
- Capture immutable snapshot of reported content.
- Track edits/deletions after report creation.
- Preserve pointer integrity for audits.

## Anti-Abuse Controls
- Rate limit report spam.
- Penalize malicious reporting patterns.
- Trust-weight reporting influence using reporter history.

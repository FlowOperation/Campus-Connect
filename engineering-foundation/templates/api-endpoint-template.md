# API Endpoint Template

## Endpoint
`<method> <path or callable-name>`

## Purpose
Describe operation goal.

## AuthN/AuthZ
- Authentication required: yes/no
- Required roles/claims:

## Request Schema
```json
{
  "field": "type"
}
```

## Response Schema
```json
{
  "status": "ok",
  "data": {}
}
```

## Validation and Business Rules
- Rule 1
- Rule 2

## Idempotency
Specify idempotency behavior and keys.

## Error Contract
- validation_error
- permission_denied
- policy_violation
- rate_limited
- transient_failure

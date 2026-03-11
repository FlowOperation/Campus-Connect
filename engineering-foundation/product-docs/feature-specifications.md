# Feature Specifications

## Discovery and Feed Layer
### Includes
- Home feed
- Popular/discovery feed
- Community feed
- Search-result feed
- Feed ranking and sorting (`Hot`, `New`, `Top`, `Rising`, campus-specific variants)
- Save, hide, share, and report actions

### Technical requirements
- Campus-aware feed filtering
- Cursor-based pagination
- Denormalized feed summary model
- Derived ranking fields (`score`, `hotScore`, `engagementScore`, `lastActivityAt`)

## Community Layer
### Includes
- Community pages
- Join/leave community
- Community rules/about/moderators
- Community pinned posts and official notices
- Community search and flair filtering

### Technical requirements
- `communities` and `community_memberships` data model
- Role-aware moderator/admin controls
- Community-scoped feed and post creation permissions

## Thread and Comment Layer
### Includes
- Post detail thread
- Comment composer
- Comment voting
- Nested replies
- Comment sorting and collapse/expand behavior
- Save/share/report comment actions

### Technical requirements
- Parent-child comment relationships
- Scored and sorted comment read models
- Efficient incremental loading for deep threads

## Composer and Post Types
### Includes
- Text post
- Image post
- Video post
- Link post
- Poll post
- Crosspost
- Post editing, drafts, and flair selection

### Technical requirements
- Post-type-specific validation
- Media upload and preview pipeline
- Draft persistence and recovery
- Community rules surfaced during composition

## Identity and Reputation
### Includes
- Profile overview, posts, comments, saved, hidden
- Karma/reputation indicators
- Profile editing and custom avatar
- FAST-specific metadata (campus, department, batch)

### Technical requirements
- User profile projections and stats aggregation
- Privacy-aware private tabs for saved/hidden/upvoted items
- Reputation counters and abuse-resistant rules

## Notifications and Inbox
### Includes
- Reply notifications
- Mentions
- Vote/activity alerts
- Moderation notices
- Notification settings and read states

### Technical requirements
- `notifications` collection/read model
- Delivery fan-out strategy
- Push + in-app delivery compatibility

## Messaging
### Includes
- 1:1 conversations
- Real-time message stream
- Report, block, and mute controls
- Conversation list and chat history

### Technical requirements
- Participant-only access rules
- Message idempotency and retry-safe delivery
- Safety hooks and moderation escalation

## Moderation and Governance
### Includes
- Reporting intake
- Queue triage and case handling
- Community moderator actions
- Admin actions and audit logs
- Appeals and enforcement history

### Technical requirements
- Policy code taxonomy
- Immutable evidence snapshots
- SLA tracking and dashboard metrics
- Server-mediated privileged writes

## FAST-Specific Utility Layer
### Includes
- Notes attachments and previews
- Job links and deadline reminders
- Event RSVP and calendar integration
- Lost & found resolution workflows
- Study groups and course communities

### Technical requirements
- Category-aware content extensions
- Attachment validation and preview support
- Event metadata and reminder jobs

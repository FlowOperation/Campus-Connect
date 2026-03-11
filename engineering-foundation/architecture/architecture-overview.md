# Campus Connect Architecture Overview

## Purpose
This document defines the target architecture for evolving Campus Connect from a posting MVP into a production-grade FAST-only Reddit-style platform. The design optimizes for feed-first discovery, comment-centric depth, community membership, moderation safety, and long-term product velocity.

## System Scope
Campus Connect is a private FAST-NUCES discussion network supporting:
- Authenticated campus identity and profile verification
- Home, Popular, and community-specific feed browsing
- Comment-centric post threads with lightweight voting and saving
- Community membership, rules, pinned posts, and moderator governance
- Search across posts, communities, comments, and people
- Direct messaging with safety controls
- Moderation workflows, reporting, and auditability
- Multi-campus segmentation and FAST-specific utility content (notes, jobs, events, lost & found)

## Architectural Style
- Client: Flutter app using feature-based modular monolith architecture
- Backend: Firebase-managed services with explicit domain boundaries
- Data: Firestore as primary operational store
- Event/Automation: Cloud Functions for triggers, moderation enrichment, and scheduled jobs
- Media: Cloudinary for image upload and transformation

## Layered Architecture
1. UI Layer
- Screens, reusable components, route shells, and user interaction handling.

2. Application Layer
- Riverpod controllers/notifiers, use-case orchestration, and transactional workflows.

3. Domain Layer
- Entities, value objects, domain rules, and policy abstractions.

4. Infrastructure Layer
- Firestore repositories, Auth gateways, Cloudinary adapter, messaging transport, and analytics.

## Bounded Contexts
- Identity: account lifecycle, role claims, campus assignment, verification status
- Discovery: home/popular/community feeds, ranking, search metadata, recommendations
- Communities: community definitions, memberships, rules, flairs, moderators, pinned content
- Threads: posts, comments, replies, votes, saves, hidden items, thread sorting
- Moderation: reports, enforcement actions, queues, policy rules, audit logs
- Messaging: conversations, message delivery, safety checks, reporting hooks
- FAST Utilities: notes, jobs, events, lost & found extensions built on top of post/community primitives

## Deployment Topology
- Flutter clients for Android/iOS/web
- Firebase Auth for identity and token issuance
- Firestore with campus-aware and time-aware indexes
- Cloud Functions (HTTP + Firestore triggers + scheduled tasks)
- Cloudinary for media storage and transform pipeline

## Non-Functional Targets
- P95 feed query latency < 350 ms for warm cache
- P95 message send acknowledgement < 500 ms
- Moderation action propagation < 30 seconds
- Firestore rules deny-by-default posture
- End-to-end auditable moderation decisions

## Key Design Decisions
### Decision: Feature-based modular monolith in client
Context: MVP has screen-centric code with growing cross-feature coupling.
Problem: New features can create style and state management drift.
Decision: Move to `lib/features/<feature>/` modules with explicit contracts between layers.
Alternatives considered: keep flat screen/widget folders; split into multiple Flutter packages immediately.
Tradeoffs: refactor overhead now; slight indirection for small features.
Long-term implications: predictable scaling path and lower regression risk.

### Decision: Domain-first data contracts over ad hoc document maps
Context: Firestore writes are currently close to UI workflows.
Problem: Schema drift and weak invariants break analytics, moderation, and migration.
Decision: Centralize DTO mappers and validation in domain/infrastructure boundaries.
Alternatives considered: rely on Firestore dynamic schema; write-only service wrappers.
Tradeoffs: more upfront boilerplate.
Long-term implications: safer migrations and easier extension to new content types.

### Decision: Moderation as first-class platform subsystem
Context: Campus discussions require trust and accountability.
Problem: Reactive moderation added late leads to abuse and operational debt.
Decision: Build reports, queues, policy engine hooks, and audit logs as core components.
Alternatives considered: manual moderation through direct document edits.
Tradeoffs: additional data model and operations complexity.
Long-term implications: safer community growth and governance readiness.

### Decision: Communities as product backbone
Context: Reddit-like retention depends on belonging to repeat-visit topic spaces.
Problem: Flat category chips are not enough to support identity, rules, or moderator ownership.
Decision: Introduce explicit community entities for campuses, departments, clubs, courses, and official spaces.
Alternatives considered: keep categories only; rely on search and tags alone.
Tradeoffs: more routing, moderation, and data model complexity.
Long-term implications: stronger retention, clearer governance, and higher-quality discovery.

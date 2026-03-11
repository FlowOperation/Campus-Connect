# Campus Connect Architecture Overview

## Purpose
This document defines the target architecture for evolving Campus Connect from MVP into a production-grade, modular campus platform. The design optimizes for maintainability, feature velocity, moderation safety, and secure growth across campuses.

## System Scope
Campus Connect is a private discussion network for FAST-NUCES students supporting:
- Authenticated identity and profile verification
- Discussion posts, comments, voting, bookmarking, and search
- Direct messaging with safety controls
- Moderation workflows and auditability
- Multi-campus segmentation and policy enforcement

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
- Discussions: posts, comments, voting, bookmarks, tags, search metadata
- Moderation: reports, enforcement actions, queues, policy rules, audit logs
- Messaging: conversations, message delivery, safety checks, reporting hooks
- Community Ops: announcements, pinned content, moderator management

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

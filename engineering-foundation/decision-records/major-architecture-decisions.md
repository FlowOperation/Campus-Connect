# Major Architecture Decisions

## ADR-0001: Feature-Based Modular Client Architecture
Context: MVP structure is workable but not scalable for multi-team feature growth.
Problem: Screen-centric organization creates coupling and inconsistent patterns.
Decision: Adopt feature modules with internal UI/application/domain/infrastructure layers.
Alternatives considered: retain global layers; split into many packages early.
Tradeoffs: migration overhead and temporary duplication.
Long-term implications: improved modularity and safer large-scale refactors.

## ADR-0002: Hybrid Moderation (Automation + Human Review)
Context: Student communities can generate high report volumes during peak periods.
Problem: Manual-only moderation is too slow and inconsistent.
Decision: Automated triage and risk scoring with human final enforcement.
Alternatives considered: fully manual; fully automated enforcement.
Tradeoffs: system complexity and false positive management.
Long-term implications: scalable safety operations and auditable governance.

## ADR-0003: Cloud Functions for Privileged Operations
Context: Client writes are efficient but untrusted for sensitive workflows.
Problem: Enforcement, sanctions, and high-risk updates need trusted execution.
Decision: Route privileged operations through Cloud Functions APIs.
Alternatives considered: direct client writes for all operations.
Tradeoffs: additional backend code and deployment complexity.
Long-term implications: stronger policy enforcement and reduced abuse surface.

## ADR-0004: Campus-Scoped Data Partitioning
Context: Platform operates across multiple FAST campuses with local relevance.
Problem: Global query patterns increase data exposure and scaling pressure.
Decision: Include `campusId` in primary entities and query/index strategies.
Alternatives considered: global feed default with client-side filtering.
Tradeoffs: extra indexing and migration care.
Long-term implications: better performance, privacy boundaries, and moderation ownership.

## ADR-0005: Messaging with Built-In Safety Hooks
Context: Messaging is high-value but high-risk.
Problem: Shipping chat without reporting/blocking increases harm potential.
Decision: Require report/block/mute and moderation integration at launch.
Alternatives considered: release basic chat first.
Tradeoffs: slower initial release.
Long-term implications: trust-preserving messaging adoption.

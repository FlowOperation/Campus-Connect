# UI Component Architecture

## Goals
- Enforce visual and behavioral consistency.
- Reduce duplicated styling logic.
- Support accessibility and platform adaptation.

## Component Taxonomy
- Tokens
  - Color, typography, spacing, radius, elevation, motion durations.
- Primitives
  - `AppText`, `AppIcon`, `AppButton`, `AppInput`, `AppCard`.
- Composites
  - `PostListItem`, `PostActionBar`, `CommunityHeader`, `CommentComposer`, `CommentBranch`, `NotificationTile`, `ReportBottomSheet`, `ConversationTile`.
- Layouts
  - `AppScaffold`, `FeedShell`, `CommunityShell`, `ContentSection`, `EmptyState`, `ErrorState`.

## Ownership Model
- Shared primitives live in `lib/shared/components`.
- Feature composites live inside corresponding `features/*/presentation/components`.
- Breaking changes in primitives require migration notes.

## Design Contracts
- All colors from token system; no inline hex in screens.
- Typography through semantic roles (`titleLarge`, `bodyMedium`, etc.).
- Touch targets minimum 44x44.
- Disabled/loading/error states required for interactive components.
- Repeated Reddit-style actions (`vote`, `save`, `share`, `hide`, `reply`, `join`) should render through shared primitives, not bespoke per-screen code.

## Review Checklist
- Does the component expose only necessary inputs?
- Are accessibility labels and semantics included?
- Is theming and dark mode support complete?
- Are snapshot/golden tests available for visual regressions?

## Key Design Decision
Context: Current UI uses mixed inline styles and shared constants.
Problem: Inconsistent patterns increase UI debt.
Decision: Formalize component taxonomy and design contracts.
Alternatives considered: rely on Material defaults only; screen-level custom widgets.
Tradeoffs: initial library build effort.
Long-term implications: uniform UX and faster feature delivery.

# Component Library

## Primitives
- `AppButton`: primary, secondary, destructive, text
- `AppInput`: text, multiline, password, search
- `AppChip`: filter, status, category
- `AppCard`: standard content container
- `AppAvatar`: user and group variants

## Feedback Components
- `AppSnackbar`
- `InlineError`
- `AppLoadingIndicator`
- `EmptyState`
- `RetryPanel`

## Domain Components
- `PostCard`
- `CommentThreadItem`
- `VoteControl`
- `BookmarkControl`
- `ConversationTile`
- `ModerationActionSheet`
- `ReportReasonPicker`

## Layout Components
- `AppScaffold`
- `SectionHeader`
- `PagedListView`
- `StickyFilterBar`

## Component API Requirements
- Every component must define loading and disabled behavior.
- Expose semantic labels and focus order support.
- Prefer immutable props and stateless rendering.

## Testing Requirements
- Golden tests for visual stability.
- Interaction tests for critical controls.
- Accessibility checks for semantics and contrast.

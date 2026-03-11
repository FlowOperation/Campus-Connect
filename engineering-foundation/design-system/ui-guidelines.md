# UI Guidelines

## Design Principles
- Clarity over decoration.
- Consistency across all features.
- Accessibility by default.
- Fast comprehension in high-density information views.

## Visual Language
- Use semantic color roles, not feature-specific hardcoded colors.
- Maintain consistent spacing scale and typography rhythm.
- Keep interaction affordances explicit for voting, moderation, and messaging actions.

## Screen Composition
- Standard screen shell: app bar, content body, primary action area.
- Use canonical empty/loading/error patterns.
- Keep search/filter controls in predictable positions.

## Interaction Standards
- All destructive actions require confirmation.
- Policy-based restrictions show actionable error copy.
- Optimistic updates must include rollback behavior on failure.

## Content Standards
- Use concise labels and avoid ambiguous moderation wording.
- Student-facing policy errors must include next step guidance.

## Governance
- Any new component variant requires design review and token mapping.
- Screens failing contrast or semantic checks cannot pass PR quality gates.

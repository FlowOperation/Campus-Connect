# Accessibility Standards

## Baseline Requirements
- WCAG 2.1 AA color contrast.
- Minimum 44x44 touch targets.
- Dynamic text scaling support.
- Logical focus traversal for keyboard and assistive technologies.

## Semantic Requirements
- All interactive elements expose labels and roles.
- Form fields expose helper/error text semantics.
- Dynamic updates announce status changes for screen readers.

## Motion and Sensory Safety
- Respect reduced motion settings.
- Avoid flashing and rapid animated transitions.
- Ensure non-color cues for state changes.

## Accessibility Testing
- Automated lint checks for semantics.
- Manual screen reader walkthrough for critical journeys:
  - login
  - create post
  - report content
  - send message
  - moderate report

## Governance
Accessibility violations block release candidate merges for core user flows.

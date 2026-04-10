# Accessibility Verification Checklist

Use this checklist before merging UI changes that affect core user flows.

## Coverage

- Login and sign up
- Home feed search, sort, category filters, and profile access
- Create post flow
- Post detail actions and comment composer
- Profile tabs and sign out

## Manual Verification

- [ ] Verify the app at 100%, 150%, and 200% text scaling.
- [ ] Confirm there are no clipped labels, hidden controls, or overflow warnings on core screens.
- [ ] Confirm feed category filters wrap cleanly and remain tappable at larger text sizes.
- [ ] Confirm the comment composer remains usable when text scaling is increased.
- [ ] Confirm icon-only controls expose meaningful screen-reader labels.
- [ ] Confirm primary interactive controls meet the 48x48 logical pixel tap target guidance.
- [ ] Confirm selected chips and buttons keep readable foreground and background contrast.

## Core Controls To Check

- [ ] Open profile
- [ ] Clear search
- [ ] Show or hide password
- [ ] Select post category
- [ ] Upvote post
- [ ] Downvote post
- [ ] Bookmark post
- [ ] Open post options
- [ ] Delete comment
- [ ] Post comment

## Core User Flows

- [ ] Sign in or sign up
- [ ] Browse the feed and filter by category
- [ ] Create a post
- [ ] Open a post and add a comment
- [ ] Open profile and sign out

## Automated Coverage

Widget coverage for large-text rendering and key semantics labels lives in `test/accessibility_pass_test.dart`.

Run:

```bash
flutter analyze --no-fatal-infos
flutter test
```
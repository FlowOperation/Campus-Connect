# Campus Connect Product Roadmap

## Roadmap Intent

Campus Connect is being built as a FAST-NUCES adaptation of Reddit, not just a general posting app. That means the roadmap must eventually deliver the full product loop:

1. Feed-first discovery
2. Community-based segmentation
3. Comment-centric depth
4. Lightweight voting and saving
5. Strong identity and moderation
6. Return loops through inbox, profile, and notifications

Every major feature is intended to ship, but in phases.

---

## Phase 0: Current Shipped Foundation

### Auth and FAST identity
- [x] Email/password sign up and sign in
- [x] Google sign in
- [x] FAST-domain validation for Google sign in
- [x] Auth gate and session persistence
- [x] Sign out

### Core feed and post model
- [x] Home feed
- [x] Category segmentation (current lightweight substitute for communities)
- [x] Search by title/description
- [x] Sort by popular, recent, and oldest
- [x] Post cards with score and comment count
- [x] Create text post
- [x] Create single-image post (config dependent)
- [x] View post detail
- [x] Delete own post

### Engagement
- [x] Upvote post
- [x] Downvote post
- [x] Save/bookmark post

### Comments foundation
- [x] View comments
- [x] Add comment
- [x] Delete own comment

### Profile foundation
- [x] View profile
- [x] View authored posts
- [x] View saved posts

### UI foundation
- [x] Shared app shell and theme
- [x] Responsive layout base
- [x] Loading, error, and empty states

---

## Phase 1: Reddit Core UX Parity

Goal: upgrade the current MVP into a cleaner Reddit-like browse-and-engage experience.

### Feed actions and ranking
- [ ] Share post
- [ ] Hide post
- [ ] Report post
- [ ] Follow post / thread notifications
- [ ] Hot / rising / top ranking models
- [ ] Better score decay and trending heuristics
- [ ] Feed pagination and infinite scrolling

### Post enhancements
- [ ] Post editing
- [ ] Edited badge
- [ ] Post link sharing
- [ ] Copy post content/link
- [ ] Media viewer for images
- [ ] Better upload reliability and retry states

### Comment depth v1
- [ ] Comment sort (`Best`, `Top`, `New`)
- [ ] Comment upvote/downvote
- [ ] Comment share
- [ ] Comment report
- [ ] Inline reply composer
- [ ] Basic nested replies

### Search improvements
- [ ] Better search UX with recent queries
- [ ] Result highlighting
- [ ] Filter by author/date/sort

---

## Phase 2: Community Layer (FAST Subreddit Equivalent)

Goal: introduce true community pages so the app behaves like a university Reddit, not just a category feed.

### Community model
- [ ] Communities for campuses, departments, batches, clubs, courses, and official channels
- [ ] Community creation and moderation permissions
- [ ] Join / leave community
- [ ] Joined communities list
- [ ] Community recommendations

### Community surfaces
- [ ] Community page with header, description, member count, and about section
- [ ] Community rules screen
- [ ] Community moderators list
- [ ] Search within community
- [ ] Community feed sorting (`Hot`, `New`, `Top`, `Rising`)
- [ ] Community flair filtering

### Community publishing
- [ ] Choose community while posting
- [ ] Pinned posts
- [ ] Official announcement communities
- [ ] Moderator-distinguished posts

---

## Phase 3: Thread Depth and Composer Expansion

Goal: make the comments thread and posting workflow rich enough to support real community discussion.

### Thread depth
- [ ] Deep nested replies
- [ ] Collapse/expand comment trees
- [ ] View more replies
- [ ] Save comment
- [ ] Block user from thread
- [ ] Comment moderation states
- [ ] Thread follow/subscription

### Composer evolution
- [ ] Rich text editor
- [ ] Link posts
- [ ] Video posts
- [ ] Poll posts
- [ ] Crosspost flow
- [ ] Flair picker
- [ ] Spoiler / sensitive-content flags
- [ ] Draft saving
- [ ] Discard confirmation

### Media and previews
- [ ] Better image gallery behavior
- [ ] Fullscreen media viewer
- [ ] Video playback controls
- [ ] Link preview cards

---

## Phase 4: Identity, Profile, Inbox, and Settings

Goal: strengthen return loops and self-management.

### Profile evolution
- [ ] Overview tab
- [ ] Comments tab
- [ ] Hidden posts tab
- [ ] Upvoted/downvoted private history
- [ ] Profile editing
- [ ] Custom avatar upload and crop
- [ ] Bio, department, batch/year, interests
- [ ] Stats and karma-like reputation
- [ ] Achievements / campus badges

### Inbox and notifications
- [ ] Activity inbox
- [ ] Replies and mentions
- [ ] Vote and save activity notifications
- [ ] System and moderation notices
- [ ] Mark as read
- [ ] Notification filters
- [ ] Notification settings
- [ ] Push notifications (FCM)

### Settings
- [ ] Account settings
- [ ] Profile settings
- [ ] Privacy settings
- [ ] Notification settings
- [ ] Content preferences
- [ ] Dark mode
- [ ] Font size and accessibility settings
- [ ] Muted/blocked users and communities

---

## Phase 5: Messaging and Private Coordination

Goal: add private follow-up communication without displacing the public feed-and-thread model.

### Direct messaging
- [ ] One-to-one chat
- [ ] Conversation list
- [ ] Real-time delivery
- [ ] Message notifications
- [ ] Chat history
- [ ] Attachments/media where appropriate

### Safety controls
- [ ] Block user
- [ ] Mute conversation
- [ ] Report message
- [ ] Leave/hide chat

---

## Phase 6: Moderation, Governance, and Safety

Goal: deliver subreddit-style moderation adapted for FAST campus safety and governance.

### Student-facing reporting
- [ ] Report post
- [ ] Report comment
- [ ] Report message
- [ ] Report user/profile

### Moderator tools
- [ ] Mod queue
- [ ] Approve / remove content
- [ ] Mark as spam
- [ ] Lock comments
- [ ] Sticky / pin post
- [ ] Distinguish moderator posts/comments
- [ ] Message user / warning flows
- [ ] Ban / mute / suspend user
- [ ] Community rule management

### Admin tools
- [ ] Admin dashboard
- [ ] Role management
- [ ] Campus-wide announcements
- [ ] Audit logs and appeals
- [ ] Community governance tooling
- [ ] Moderation analytics and SLA tracking

---

## Phase 7: FAST-Specific Utility Experiences

Goal: make Campus Connect more useful than a generic Reddit clone by shipping category-specific university workflows.

### Notes and academics
- [ ] File attachments (PDF, DOCX, slides)
- [ ] In-app preview
- [ ] Download/share notes
- [ ] Study groups and course communities

### Jobs and internships
- [ ] External job links
- [ ] Deadline reminders
- [ ] Save job posts
- [ ] Application tracking notes

### Events
- [ ] Calendar view
- [ ] RSVP
- [ ] Reminder notifications
- [ ] Add to device calendar

### Lost and found
- [ ] Mark item as found
- [ ] Contact flow
- [ ] Location tagging
- [ ] Proof / image requirements

---

## Phase 8: Intelligence, Growth, and Platform Expansion

Goal: optimize discovery, retention, and reach once core behavior is stable.

### Discovery intelligence
- [ ] Recommendations
- [ ] Personalized community suggestions
- [ ] Trending topics
- [ ] Semantic search
- [ ] Search auto-complete

### Reputation and gamification
- [ ] Reputation tiers
- [ ] Helpful contributor indicators
- [ ] Milestone badges
- [ ] Leaderboards

### Analytics and operations
- [ ] Firebase Analytics
- [ ] Crashlytics
- [ ] Feature usage dashboards
- [ ] Moderator insights
- [ ] Personal analytics dashboard

### Platform expansion
- [ ] Responsive web app
- [ ] PWA support
- [ ] Desktop support (macOS, Windows, Linux)

### Security and performance hardening
- [ ] Email verification requirement
- [ ] Two-factor authentication
- [ ] Rate limiting and abuse throttling
- [ ] Better caching strategy
- [ ] Offline read/write queueing
- [ ] Performance monitoring

---

## Delivery Principles

- Ship Reddit-like core loops before peripheral features.
- Prioritize comments, communities, inbox, and moderation over novelty.
- FAST-specific utilities should build on top of the community and thread model, not bypass it.
- Every phase must leave the app usable, testable, and safer than before.

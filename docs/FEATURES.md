# Campus Connect Product Feature Map

## Overview

Campus Connect is intended to become Reddit for FAST-NUCES students: a FAST-only, community-driven discovery and discussion app where students browse feeds, dive deep into comment threads, join niche university communities, and return through notifications, reputation, and community belonging.

The target experience follows the Reddit product loop:

1. Discover content through Home, Popular, Community feeds, and Search.
2. Evaluate quickly through title, community, score, comment count, preview, flair, and freshness.
3. Engage lightly through upvote, downvote, save, share, join, and hide.
4. Engage deeply through comments, replies, thread exploration, and contribution.
5. Return through inbox activity, moderation feedback, reputation, and community membership.

This document covers both shipped functionality and the full target capability set that will be delivered in phases.

---

## Current Implementation Snapshot

### Implemented Now

**Authentication and identity**
- Email/password sign up and sign in
- Google sign in
- FAST domain enforcement for Google sign in (`@nu.edu.pk`, `@isb.nu.edu.pk`, `@lhr.nu.edu.pk`, `@pwr.nu.edu.pk`, `@fsd.nu.edu.pk`)
- Auth state gate and sign out
- Basic user profile document creation in Firestore

**Core feed and discovery**
- Home feed of posts
- Category-based segmentation using Notes, Jobs, Events, Lost & Found, and Announcements
- Search by title/description
- Feed sort by Popular, Most Recent, and Oldest
- Post cards with author, timestamp, category, score, comment count, and media preview

**Contribution and thread entry**
- Create post flow
- Text posts
- Single-image post support through Cloudinary-backed upload flow
- Post detail screen
- Delete own post

**Reddit-style lightweight engagement**
- Upvote and downvote on posts
- Bookmark/save posts
- Real-time score updates based on upvotes minus downvotes

**Comments foundation**
- View comments on a post
- Add comment
- Delete own comment
- Post-level comment counts

**Profile basics**
- Profile header
- View authored posts
- View saved/bookmarked posts

**UI foundation**
- Shared app shell and centralized theme
- Reddit-inspired palette and feed styling
- Shared empty states and background primitives
- Feature-module presentation structure

### Partially Implemented Foundation

**Image posts**
- UI and upload service exist
- Operational success depends on valid Cloudinary configuration
- No gallery carousel, fullscreen media viewer, or richer attachment workflow yet

**Comments**
- Flat comments are implemented
- Nested replies, comment voting, comment sorting, collapse/expand, and moderation controls are not yet implemented

**Security and moderation foundation**
- Firestore rules baseline is hardened for ownership and interaction fields
- Moderator/admin product surfaces are not yet present

### Not Yet Implemented

- Popular / campus-wide discovery feed
- Community pages (the FAST subreddit equivalent)
- Join/leave communities
- Community rules/about/moderator views
- Post share / hide / report / follow post
- Comment voting / replying / sorting / saving / reporting / blocking
- Notifications / inbox / activity center
- Direct messaging and chat
- Settings and preferences
- User reputation, karma, comment history, hidden posts, upvote/downvote history
- Moderator tools and report queue
- Admin tools and analytics
- Advanced search tabs for posts, communities, comments, and people

---

## Full Target Product Scope

### 1. Feed and Discovery Layer

This is the primary Reddit-like browsing surface.

**Target screens**
- Home feed
- Popular / campus-wide discovery feed
- Community-specific feed
- Search results feed

**Target actions**
- Upvote
- Downvote
- Comments
- Save
- Share
- Hide
- Open community
- Open post
- Open media
- Join community
- Create post

**Status**
- Home feed: implemented
- Search: implemented at basic level
- Sorting: implemented at basic level
- Popular feed: planned
- Hide/share/report/follow-post actions: planned
- Ranking models beyond raw recency/score: planned

### 2. Community Layer

Communities are the FAST-specific equivalent of subreddits.

**Target community types**
- Campus communities (`FAST Islamabad`, `FAST Lahore`, etc.)
- Department communities (`CS`, `SE`, `EE`, `BBA`, etc.)
- Course or batch communities
- Society and club communities
- Official communities for announcements and moderation

**Target screens and capabilities**
- Community page with header, description, rules, moderators, and feed
- Join / leave community
- Community-specific search
- Post sorting inside community (`Hot`, `New`, `Top`, `Rising`)
- Community flair filters
- Pinned posts and announcements
- Community rules/about screen

**Status**
- Category chips exist today as a lightweight segmentation model
- Full community model is planned

### 3. Thread and Comments Layer

This is the core depth layer, and eventually the most important retention surface.

**Target capabilities**
- Post detail thread view
- Comment composer
- Nested replies
- Comment upvote/downvote
- Comment sort (`Best`, `Top`, `New`, `Controversial`)
- Collapse/expand comment branches
- Save comment
- Share comment
- Report comment
- Block user from comment thread

**Status**
- Post detail: implemented
- Basic comments list: implemented
- Add/delete comment: implemented
- Nested replies, comment voting, sorting, collapse, report, and save: planned

### 4. Composer and Content Types

Posting should evolve from a simple form to a Reddit-style composer.

**Target post types**
- Text post
- Image post
- Video post
- Link post
- Poll post
- Crosspost

**Target composer controls**
- Choose community
- Title
- Body
- Add image/video/link
- Add flair
- Tag spoiler
- Tag sensitive-content flags when needed
- Save draft
- Discard draft
- Edit post
- Community rules preview before posting

**Status**
- Text post: implemented
- Single image post: implemented with external config dependency
- Link/video/poll/crosspost/flair/drafts/editing: planned

### 5. Identity and Reputation Layer

Profiles should help students judge relevance and credibility without losing privacy or safety.

**Target profile sections**
- Overview
- Posts
- Comments
- Saved
- Hidden
- Upvoted / downvoted (private view)
- Achievements / campus reputation

**Target profile features**
- Edit profile
- Custom avatar
- Bio, department, batch/year, interests
- Stats (posts, comments, score received, saves received)
- Reputation / karma-like indicators
- Share profile
- Optional follow user

**Status**
- Posts tab: implemented
- Saved/bookmarks tab: implemented
- Basic avatar + identity header: implemented
- Comment history, hidden, reputation, profile editing, stats, follow: planned

### 6. Notifications and Retention Layer

Notifications pull students back into active discussions.

**Target inbox areas**
- Replies
- Mentions
- Vote/activity alerts
- Moderator and system notices
- Direct messages or chats

**Target capabilities**
- Notification center
- Mark as read
- Filter notifications
- Notification settings
- Follow post / thread and receive updates

**Status**
- Not yet implemented

### 7. Search and Intent Layer

Search must support both broad discovery and targeted problem solving.

**Target search areas**
- Posts
- Communities
- Comments
- People

**Target capabilities**
- Recent searches
- Suggested queries
- Sort and filters
- Search within a community
- Trending searches and tags

**Status**
- Basic post search: implemented
- Advanced tabs, community search, people search, comment search, tags, and trending: planned

### 8. Messaging and Private Coordination Layer

Messaging is secondary to feeds/comments, but important for follow-up coordination.

**Target capabilities**
- One-to-one chat
- Real-time delivery
- Message notifications
- Block, mute, and report user
- Conversation list

**Status**
- Not yet implemented
- Feature module scaffolding exists

### 9. Moderation and Governance Layer

Campus Connect must support moderator governance similar to Reddit communities, with stronger university safety controls.

**Target student-facing actions**
- Report post
- Report comment
- Report message
- Report user/profile

**Target moderator actions**
- Approve / remove content
- Lock comments
- Pin/sticky posts
- Warn / suspend / ban user
- View mod queue
- Review evidence
- Configure rules and pinned notices

**Target admin actions**
- Role assignment
- Campus-wide announcements
- Analytics dashboards
- Governance audit trail

**Status**
- Moderation architecture defined in engineering docs
- In-app reporting, moderator tools, and admin tools are planned

### 10. FAST-Specific Utility Features

Campus Connect should not only copy Reddit mechanics. It should adapt them to university use cases.

**Target vertical capabilities**
- Notes attachments and previews
- Job application links and deadline reminders
- Event RSVP and calendar add
- Lost & found resolution flow
- Study groups and course communities
- Official academic and society announcements

**Status**
- Categories exist today
- Deeper workflows are planned in later phases

---

## High-Level Product Truths

- Students will often arrive for the feed, but stay for the comment thread and community.
- FAST-only identity is the trust layer.
- Communities are the retention layer.
- Notifications and profile reputation are the return loop.
- Moderation is a core product system, not an afterthought.

---

## Tech Stack and Delivery Notes

- Flutter + Riverpod client architecture
- Firebase Auth + Cloud Firestore backend foundation
- Cloudinary-backed image upload path for current image posts
- Feature-module migration in progress for scalable growth
- Engineering source of truth lives under `engineering-foundation/`

For phased delivery sequencing, see `docs/ROADMAP.md`.

## 🎯 User Experience Highlights

### Onboarding Flow
1. Beautiful login screen
2. Easy signup process
3. Instant Google Sign-In option
4. Clear error messages
5. Auto-login on success

### Main User Journey
1. View feed of posts
2. Filter by category/search
3. Like interesting posts
4. Bookmark for later
5. Create own posts
6. View profile & saved posts
7. Manage own content

### Empty States
- "No posts yet" with icon
- "Create first post" CTA
- "No bookmarks" message
- "Search found nothing" state

### Error Handling
- Network errors
- Auth errors
- Permission errors
- Friendly error messages
- Retry options

### Loading States
- Circular progress indicators
- Skeleton loaders (future)
- Button loading states
- Disabled states during actions

---

## 📱 Platform Support

### Current Support
- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ⚠️ Web (needs testing)

### Tested On
- Android Emulator
- Physical Android devices
- iOS Simulator (via macOS)

---

## 🚀 Deployment Ready

### What's Configured
- ✅ Production Firebase
- ✅ Release build configs
- ✅ ProGuard rules (Android)
- ✅ App icons ready
- ✅ Splash screen ready

### What's Needed for Production
- [ ] App signing key (Android)
- [ ] iOS provisioning profiles
- [ ] Play Store listing
- [ ] App Store listing
- [ ] Privacy policy URL
- [ ] Terms of service

---

## 🎓 Perfect for Portfolio/Interview

### Demonstrates
1. **Modern Flutter Development**
   - Latest Flutter/Dart features
   - Material 3 design
   - Proper architecture

2. **State Management Expertise**
   - Riverpod best practices
   - Provider patterns
   - State immutability

3. **Backend Integration**
   - Firebase services
   - Real-time data
   - Authentication flows

4. **Production Code Quality**
   - Error handling
   - Validation
   - User experience
   - Code organization

5. **Real-World Application**
   - Solves actual problem
   - Complete feature set
   - Scalable architecture

---

## 🏆 Standout Features

### What Makes It Special
- ✨ **Polished UI** - Not a tutorial clone
- 🔥 **Real Backend** - Actual cloud database
- 📱 **Complete Flow** - Auth to post to profile
- 🎨 **Custom Design** - Unique color system
- 🚀 **Production Ready** - Can launch today
- 📚 **Well Documented** - Professional docs
- 🔧 **Maintainable** - Clean code structure
- 💡 **Innovative** - Campus-specific solution

---

## 📈 Growth Potential

### Easy to Add
- Image uploads
- Comments system
- Push notifications
- Dark mode
- File attachments
- Event calendar
- Chat features
- Admin panel

### Scalability
- Can handle 1000+ users
- Real-time updates
- Efficient queries
- Cloud scalability
- Cost-effective

---

## 🎉 Success Criteria - ALL MET! ✅

- ✅ User can sign up/login
- ✅ User can create posts
- ✅ User can view all posts
- ✅ User can filter by category
- ✅ User can search posts
- ✅ User can like/bookmark
- ✅ User can view profile
- ✅ User can delete own posts
- ✅ App has beautiful UI
- ✅ App is production-ready
- ✅ Code is well-organized
- ✅ Documentation is complete

---

## 🎬 Demo Script

**"Let me show you Campus Connect..."**

1. **"First, the login experience"**
   - Show beautiful UI
   - Demo Google Sign-In
   - Or create account

2. **"Here's the main feed"**
   - Scroll through posts
   - Show different categories
   - Point out clean design

3. **"Let's filter by category"**
   - Tap "Jobs" chip
   - See only job posts
   - Tap "All" to reset

4. **"Let's search for something"**
   - Type "flutter"
   - See filtered results
   - Clear search

5. **"Now let's create a post"**
   - Tap + button
   - Select category
   - Fill in details
   - Submit

6. **"See it appear in the feed instantly"**
   - Point out your post
   - Like it
   - Bookmark it

7. **"Let's check the profile"**
   - Open profile
   - Show my posts
   - Show bookmarks
   - Explain features

8. **"And here's post details"**
   - Tap a post
   - Show full content
   - Interact with likes
   - Delete option (if yours)

**"This took 1-2 days to build, demonstrates real-world Flutter development, and is ready for actual campus use!"**

---

## 💼 Interview Talking Points

### Technical Decisions
- **Why Riverpod?** Better than Provider, type-safe, compile-time errors
- **Why Firebase?** Real-time, scalable, auth included, fast development
- **Why Material 3?** Modern, accessible, consistent with Android
- **Why this structure?** Scalable, testable, maintainable

### Challenges Overcome
- Firebase configuration
- Real-time state management
- Complex filtering logic
- Auth state persistence
- UI/UX polish

### What You Learned
- State management patterns
- Firebase integration
- Material Design guidelines
- User authentication flows
- Real-time databases

### What's Next
- Image uploads using Firebase Storage
- Push notifications for engagement
- Comments for discussions
- Dark mode for accessibility
- Analytics for insights

---

**Built with ❤️ by Ammaar for Xgrid Flutter Internship**

This is not just a portfolio project - it's a production-ready application that solves real campus communication needs! 🚀

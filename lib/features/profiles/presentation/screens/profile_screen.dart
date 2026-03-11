import 'package:campus_connect/features/posts/presentation/widgets/post_card.dart';
import 'package:campus_connect/providers/auth_provider.dart';
import 'package:campus_connect/providers/post_provider.dart';
import 'package:campus_connect/shared/widgets/app_empty_state.dart';
import 'package:campus_connect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authStateProvider).value;
    final authService = ref.read(authServiceProvider);

    if (currentUser == null) {
      return const Scaffold(body: Center(child: Text('Not logged in')));
    }

    final userPostsAsync = ref.watch(userPostsProvider(currentUser.uid));
    final bookmarkedPostsAsync = ref.watch(
      bookmarkedPostsProvider(currentUser.uid),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              tooltip: 'Sign out',
              onPressed: () => authService.signOut(),
              icon: const Icon(Icons.logout_rounded),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFFF5A1F), Color(0xFFFF4500)],
                ),
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: Colors.white,
                    backgroundImage: currentUser.photoURL != null
                        ? NetworkImage(currentUser.photoURL!)
                        : null,
                    child: currentUser.photoURL == null
                        ? Text(
                            (currentUser.displayName ?? 'U')[0].toUpperCase(),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    currentUser.displayName ?? 'Anonymous',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.white),
                  ),
                  Text(
                    currentUser.email ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withOpacity(0.92),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: AppColors.textPrimary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'My Posts', icon: Icon(Icons.article_outlined)),
                  Tab(
                    text: 'Bookmarks',
                    icon: Icon(Icons.bookmark_outline_rounded),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  userPostsAsync.when(
                    data: (posts) {
                      if (posts.isEmpty) {
                        return const AppEmptyState(
                          icon: Icons.edit_note_rounded,
                          title: 'No posts yet',
                          subtitle:
                              'Create your first post from the home feed.',
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) =>
                            PostCard(post: posts[index]),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => AppEmptyState(
                      icon: Icons.error_outline,
                      title: 'Could not load your posts',
                      subtitle: error.toString(),
                    ),
                  ),
                  bookmarkedPostsAsync.when(
                    data: (posts) {
                      if (posts.isEmpty) {
                        return const AppEmptyState(
                          icon: Icons.bookmark_add_outlined,
                          title: 'No bookmarks yet',
                          subtitle:
                              'Save posts from the feed to revisit later.',
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.md,
                        ),
                        itemCount: posts.length,
                        itemBuilder: (context, index) =>
                            PostCard(post: posts[index]),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => AppEmptyState(
                      icon: Icons.error_outline,
                      title: 'Could not load bookmarks',
                      subtitle: error.toString(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

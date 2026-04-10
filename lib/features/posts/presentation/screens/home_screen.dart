import 'package:campus_connect/features/posts/presentation/screens/add_post_screen.dart';
import 'package:campus_connect/features/posts/presentation/widgets/category_chip.dart';
import 'package:campus_connect/features/posts/presentation/widgets/post_card.dart';
import 'package:campus_connect/features/profiles/presentation/screens/profile_screen.dart';
import 'package:campus_connect/providers/auth_provider.dart';
import 'package:campus_connect/providers/post_provider.dart';
import 'package:campus_connect/shared/widgets/app_empty_state.dart';
import 'package:campus_connect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = ref.watch(filteredPostsProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final currentUser = ref.watch(authStateProvider).value;
    final allChipForeground = AppColors.accessibleForeground(AppColors.primary);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Connect'),
        actions: [
          Semantics(
            button: true,
            label: 'Open profile',
            child: ExcludeSemantics(
              child: IconButton(
                tooltip: 'Open profile',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                icon: CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.surfaceMuted,
                  backgroundImage: currentUser?.photoURL != null
                      ? NetworkImage(currentUser!.photoURL!)
                      : null,
                  child: currentUser?.photoURL == null
                      ? const Icon(Icons.person_outline, size: 18)
                      : null,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFF3EC), Color(0xFFF6F7F8)],
              ),
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Search posts',
                    hintText: 'Search by title or content',
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? Semantics(
                            button: true,
                            label: 'Clear search',
                            child: ExcludeSemantics(
                              child: IconButton(
                                tooltip: 'Clear search',
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {});
                                  ref.read(searchQueryProvider.notifier).state =
                                      '';
                                },
                                icon: const Icon(Icons.close_rounded),
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<SortOption>(
                        initialValue: ref.watch(sortOptionProvider),
                        decoration: const InputDecoration(
                          labelText: 'Sort',
                          prefixIcon: Icon(Icons.swap_vert_rounded),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: SortOption.popular,
                            child: Text('Most Popular'),
                          ),
                          DropdownMenuItem(
                            value: SortOption.recent,
                            child: Text('Most Recent'),
                          ),
                          DropdownMenuItem(
                            value: SortOption.oldest,
                            child: Text('Oldest First'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            ref.read(sortOptionProvider.notifier).state = value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: [
                    Semantics(
                      button: true,
                      selected: selectedCategory == null,
                      label: 'Filter posts by all categories',
                      child: ExcludeSemantics(
                        child: FilterChip(
                          label: const Text('All'),
                          selected: selectedCategory == null,
                          onSelected: (selected) {
                            ref.read(selectedCategoryProvider.notifier).state =
                                null;
                          },
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.primary.withAlpha(31),
                          labelStyle: TextStyle(
                            color: selectedCategory == null
                                ? allChipForeground
                                : AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                          showCheckmark: false,
                          side: BorderSide.none,
                        ),
                      ),
                    ),
                    ...PostCategory.all.map(
                      (category) => CategoryChip(category: category),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ref
                .watch(postsProvider)
                .when(
                  data: (_) {
                    if (filteredPosts.isEmpty) {
                      return const AppEmptyState(
                        icon: Icons.forum_outlined,
                        title: 'No posts found',
                        subtitle:
                            'Try changing filters or create the first post.',
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(
                        top: AppSpacing.sm,
                        bottom: 84,
                      ),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return PostCard(post: filteredPosts[index]);
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) => AppEmptyState(
                    icon: Icons.error_outline,
                    title: 'Feed unavailable',
                    subtitle: error.toString(),
                  ),
                ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Create a new post',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPostScreen()),
          );
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Post'),
      ),
    );
  }
}

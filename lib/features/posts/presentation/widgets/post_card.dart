import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_connect/features/posts/presentation/screens/post_detail_screen.dart';
import 'package:campus_connect/models/post_model.dart';
import 'package:campus_connect/providers/auth_provider.dart';
import 'package:campus_connect/providers/post_provider.dart';
import 'package:campus_connect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authStateProvider).value;
    final isUpvoted =
        currentUser != null && post.upvotedBy.contains(currentUser.uid);
    final isDownvoted =
        currentUser != null && post.downvotedBy.contains(currentUser.uid);
    final isBookmarked =
        currentUser != null && post.bookmarkedBy.contains(currentUser.uid);
    final firestoreService = ref.read(firestoreServiceProvider);
    final scoreColor = post.score > 0
        ? Colors.orange
        : post.score < 0
        ? Colors.blue
        : AppColors.textSecondary;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailScreen(post: post),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: post.authorPhotoUrl != null
                        ? NetworkImage(post.authorPhotoUrl!)
                        : null,
                    child: post.authorPhotoUrl == null
                        ? Text(
                            post.authorName[0].toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          )
                        : null,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                        ),
                        Text(
                          DateFormat('MMM dd, yyyy').format(post.createdAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  _CategoryBadge(category: post.category),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                post.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                post.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (post.imageUrl != null) ...[
                const SizedBox(height: AppSpacing.md),
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: post.imageUrl!,
                    width: double.infinity,
                    height: 210,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 210,
                      color: AppColors.surfaceMuted,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 210,
                      color: AppColors.surfaceMuted,
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  _ActionIcon(
                    icon: Icons.arrow_upward_rounded,
                    color: isUpvoted ? Colors.orange : AppColors.textSecondary,
                    onTap: currentUser == null
                        ? null
                        : () => firestoreService.toggleUpvote(
                            post.id,
                            currentUser.uid,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Text(
                      '${post.score}',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: scoreColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _ActionIcon(
                    icon: Icons.arrow_downward_rounded,
                    color: isDownvoted ? Colors.blue : AppColors.textSecondary,
                    onTap: currentUser == null
                        ? null
                        : () => firestoreService.toggleDownvote(
                            post.id,
                            currentUser.uid,
                          ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.comment_outlined,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text('${post.commentCount}'),
                  const Spacer(),
                  _ActionIcon(
                    icon: isBookmarked
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: isBookmarked
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    onTap: currentUser == null
                        ? null
                        : () => firestoreService.toggleBookmark(
                            post.id,
                            currentUser.uid,
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String category;

  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    final color = PostCategory.getColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PostCategory.getIcon(category), size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            category,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionIcon({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}

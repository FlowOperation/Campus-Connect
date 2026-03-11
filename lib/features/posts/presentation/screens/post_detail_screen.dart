import 'package:campus_connect/models/post_model.dart';
import 'package:campus_connect/providers/auth_provider.dart';
import 'package:campus_connect/providers/comment_provider.dart';
import 'package:campus_connect/providers/post_provider.dart';
import 'package:campus_connect/shared/widgets/app_empty_state.dart';
import 'package:campus_connect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _addComment() async {
    if (_commentController.text.trim().isEmpty) return;

    final currentUser = ref.read(authStateProvider).value;
    if (currentUser == null) return;

    try {
      await ref
          .read(firestoreServiceProvider)
          .addComment(
            postId: widget.post.id,
            content: _commentController.text.trim(),
            authorId: currentUser.uid,
            authorName: currentUser.displayName ?? 'Anonymous',
            authorPhotoUrl: currentUser.photoURL,
          );
      _commentController.clear();
      FocusScope.of(context).unfocus();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding comment: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authStateProvider).value;
    final firestoreService = ref.read(firestoreServiceProvider);
    final commentsAsync = ref.watch(commentsProvider(widget.post.id));
    final isUpvoted =
        currentUser != null && widget.post.upvotedBy.contains(currentUser.uid);
    final isDownvoted =
        currentUser != null &&
        widget.post.downvotedBy.contains(currentUser.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        actions: [
          if (currentUser != null && currentUser.uid == widget.post.authorId)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value != 'delete') return;
                await firestoreService.deletePost(widget.post.id);
                if (!context.mounted) return;
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Post deleted')));
              },
              itemBuilder: (context) => const [
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline, color: AppColors.error),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    widget.post.authorPhotoUrl != null
                                    ? NetworkImage(widget.post.authorPhotoUrl!)
                                    : null,
                                child: widget.post.authorPhotoUrl == null
                                    ? Text(
                                        widget.post.authorName[0].toUpperCase(),
                                      )
                                    : null,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.post.authorName,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                    Text(
                                      DateFormat(
                                        'MMM dd, yyyy',
                                      ).format(widget.post.createdAt),
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            widget.post.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(widget.post.description),
                          if (widget.post.imageUrl != null) ...[
                            const SizedBox(height: AppSpacing.md),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                widget.post.imageUrl!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return Container(
                                    height: 260,
                                    color: AppColors.surfaceMuted,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 260,
                                    color: AppColors.surfaceMuted,
                                    child: const Icon(
                                      Icons.broken_image_outlined,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          const SizedBox(height: AppSpacing.md),
                          Row(
                            children: [
                              IconButton(
                                onPressed: currentUser == null
                                    ? null
                                    : () => firestoreService.toggleUpvote(
                                        widget.post.id,
                                        currentUser.uid,
                                      ),
                                icon: Icon(
                                  Icons.arrow_upward_rounded,
                                  color: isUpvoted
                                      ? Colors.orange
                                      : AppColors.textSecondary,
                                ),
                              ),
                              Text('${widget.post.score}'),
                              IconButton(
                                onPressed: currentUser == null
                                    ? null
                                    : () => firestoreService.toggleDownvote(
                                        widget.post.id,
                                        currentUser.uid,
                                      ),
                                icon: Icon(
                                  Icons.arrow_downward_rounded,
                                  color: isDownvoted
                                      ? Colors.blue
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Comments',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  commentsAsync.when(
                    data: (comments) {
                      if (comments.isEmpty) {
                        return const AppEmptyState(
                          icon: Icons.chat_bubble_outline,
                          title: 'No comments yet',
                          subtitle: 'Start the conversation below.',
                        );
                      }

                      return Column(
                        children: comments.map((comment) {
                          return Card(
                            margin: const EdgeInsets.only(
                              bottom: AppSpacing.sm,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  comment.authorName[0].toUpperCase(),
                                ),
                              ),
                              title: Text(comment.authorName),
                              subtitle: Text(comment.content),
                              trailing:
                                  currentUser != null &&
                                      comment.authorId == currentUser.uid
                                  ? IconButton(
                                      onPressed: () =>
                                          firestoreService.deleteComment(
                                            comment.id,
                                            widget.post.id,
                                          ),
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: AppColors.error,
                                      ),
                                    )
                                  : null,
                            ),
                          );
                        }).toList(),
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (_, __) => const AppEmptyState(
                      icon: Icons.error_outline,
                      title: 'Could not load comments',
                      subtitle: 'Please try again in a moment.',
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (currentUser != null)
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  AppSpacing.sm,
                  AppSpacing.md,
                  AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                        ),
                        onSubmitted: (_) => _addComment(),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: _addComment,
                      icon: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

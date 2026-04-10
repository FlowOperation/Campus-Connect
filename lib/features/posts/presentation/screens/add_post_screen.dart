import 'dart:io';

import 'package:campus_connect/providers/auth_provider.dart';
import 'package:campus_connect/providers/post_provider.dart';
import 'package:campus_connect/services/image_upload_service.dart';
import 'package:campus_connect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageService = ImageUploadService();

  String _selectedCategory = PostCategory.notes;
  bool _isLoading = false;
  File? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final image = source == ImageSource.gallery
        ? await _imageService.pickImageFromGallery()
        : await _imageService.pickImageFromCamera();

    if (image != null) {
      setState(() => _selectedImage = image);
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitPost() async {
    if (!_formKey.currentState!.validate()) return;

    final currentUser = ref.read(authStateProvider).value;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to post')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      String? imageUrl;
      if (_selectedImage != null) {
        imageUrl = await _imageService.uploadPostImage(
          _selectedImage!,
          currentUser.uid,
        );
        if (imageUrl == null) {
          throw Exception('Failed to upload image');
        }
      }

      await ref
          .read(firestoreServiceProvider)
          .addPost(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            category: _selectedCategory,
            authorId: currentUser.uid,
            authorName: currentUser.displayName ?? 'Anonymous',
            authorPhotoUrl: currentUser.photoURL,
            imageUrl: imageUrl,
          );

      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Post created successfully'),
          backgroundColor: AppColors.success,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: PostCategory.all.map((category) {
                          final isSelected = _selectedCategory == category;
                          final chipColor = PostCategory.getColor(category);
                          final foregroundColor =
                              AppColors.accessibleForeground(chipColor);
                          return Semantics(
                            button: true,
                            selected: isSelected,
                            label: 'Select $category category',
                            child: ExcludeSemantics(
                              child: ChoiceChip(
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      PostCategory.getIcon(category),
                                      size: 16,
                                      color: isSelected
                                          ? foregroundColor
                                          : chipColor,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(category),
                                  ],
                                ),
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(
                                      () => _selectedCategory = category,
                                    );
                                  }
                                },
                                selectedColor: chipColor,
                                backgroundColor: chipColor.withAlpha(31),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? foregroundColor
                                      : chipColor,
                                  fontWeight: FontWeight.w700,
                                ),
                                showCheckmark: false,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextFormField(
                        controller: _titleController,
                        maxLength: 100,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter a catchy title',
                          prefixIcon: Icon(Icons.title_rounded),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a title';
                          }
                          if (value.trim().length < 5) {
                            return 'Title must be at least 5 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextFormField(
                        controller: _descriptionController,
                        maxLength: 1000,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          hintText: 'Share details about your post',
                          alignLabelWithHint: true,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a description';
                          }
                          if (value.trim().length < 10) {
                            return 'Description must be at least 10 characters';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_selectedImage != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedImage!,
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        OutlinedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : () => setState(() => _selectedImage = null),
                          icon: const Icon(Icons.delete_outline),
                          label: const Text('Remove image'),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                      OutlinedButton.icon(
                        onPressed: _isLoading ? null : _showImageSourceDialog,
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        label: Text(
                          _selectedImage == null
                              ? 'Add image (optional)'
                              : 'Change image',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitPost,
                child: _isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Publish Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:campus_connect/providers/post_provider.dart';
import 'package:campus_connect/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryChip extends ConsumerWidget {
  final String category;

  const CategoryChip({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final isSelected = selectedCategory == category;
    final categoryColor = PostCategory.getColor(category);

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: FilterChip(
        avatar: Icon(
          PostCategory.getIcon(category),
          size: 16,
          color: isSelected ? Colors.white : categoryColor,
        ),
        label: Text(category, maxLines: 1, overflow: TextOverflow.ellipsis),
        selected: isSelected,
        onSelected: (selected) {
          ref.read(selectedCategoryProvider.notifier).state = selected
              ? category
              : null;
        },
        selectedColor: categoryColor,
        backgroundColor: categoryColor.withOpacity(0.12),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : categoryColor,
          fontWeight: FontWeight.w700,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 4),
        showCheckmark: false,
        side: BorderSide.none,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

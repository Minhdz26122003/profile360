import 'dart:ui';

class CategoryItem {
  final String title;
  final String iconPath;
  final String? badge;
  final VoidCallback? onTap;

  const CategoryItem({
    required this.title,
    required this.iconPath,
    this.badge,
    this.onTap,
  });
}

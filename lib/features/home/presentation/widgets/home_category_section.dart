import 'package:democart/features/cart/domain/entities/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeCategorySection extends StatelessWidget {
  const HomeCategorySection({super.key, required this.items});

  final List<CategoryItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 18,
            childAspectRatio: 0.82,
          ),
          itemBuilder: (context, index) => _CategoryItemView(item: items[index]),
        ),
      ),
    );
  }
}

class _CategoryItemView extends StatelessWidget {
  const _CategoryItemView({required this.item});

  final CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap ?? () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(
                item.iconPath,
                width: 32,
                height: 27,
                fit: BoxFit.contain,
              ),
              if (item.badge != null)
                Positioned(
                  top: -4,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5222),
                      shape: item.badge!.length > 1
                          ? BoxShape.rectangle
                          : BoxShape.circle,
                      borderRadius: item.badge!.length > 1
                          ? BorderRadius.circular(8)
                          : null,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 15,
                      minHeight: 15,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.badge!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:democart/features/customer_profile/domain/entities/customer_activity_model.dart';
import 'package:democart/features/customer_profile/presentation/widgets/customer_activity_item.dart';
import 'package:flutter/material.dart';

class CustomerActivitySection extends StatelessWidget {
  const CustomerActivitySection({
    super.key,
    required this.activities,
    this.onViewAll,
  });

  final List<CustomerActivityModel> activities;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A7FE0).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.history_outlined,
                      size: 18,
                      color: Color(0xFF4A7FE0),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Hoạt động gần đây',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: onViewAll,
                child: const Row(
                  children: [
                    Text(
                      'Xem tất cả',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF4A7FE0),
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: Color(0xFF4A7FE0),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(
            activities.length,
            (index) => CustomerActivityItem(
              activity: activities[index],
              isLast: index == activities.length - 1,
            ),
          ),
        ],
      ),
    );
  }
}

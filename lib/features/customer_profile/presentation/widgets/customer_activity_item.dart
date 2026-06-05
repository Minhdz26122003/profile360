import 'package:democart/base/utils/responsive_widget.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_activity_model.dart';
import 'package:flutter/material.dart';

class CustomerActivityItem extends StatelessWidget {
  const CustomerActivityItem({
    super.key,
    required this.activity,
    this.isLast = false,
  });

  final CustomerActivityModel activity;
  final bool isLast;

  Color get _dotColor {
    switch (activity.type) {
      case ActivityType.booking:
        return const Color(0xFF4A7FE0);
      case ActivityType.examination:
        return const Color(0xFF10B981);
      case ActivityType.payment:
        return const Color(0xFFF59E0B);
    }
  }

  Color get _labelColor {
    switch (activity.type) {
      case ActivityType.booking:
        return const Color(0xFF4A7FE0);
      case ActivityType.examination:
        return const Color(0xFF10B981);
      case ActivityType.payment:
        return const Color(0xFFF59E0B);
    }
  }

  Color get _statusBg {
    final s = activity.status.toLowerCase();
    if (s.contains('chờ thu tiền')) return const Color(0xFFE8F0FF);
    if (s.contains('chờ thanh toán')) return const Color(0xFFFFE9D0);
    if (s.contains('xác nhận') || s.contains('hoàn')) {
      return const Color(0xFFD1FAE5);
    }
    if (s.contains('hủy')) return const Color(0xFFFFE4E6);
    return const Color(0xFFE8F0FF);
  }

  Color get _statusFg {
    final s = activity.status.toLowerCase();
    if (s.contains('chờ thu tiền')) return const Color(0xFF2D5BE3);
    if (s.contains('chờ thanh toán')) return const Color(0xFFEA7A2C);
    if (s.contains('xác nhận') || s.contains('hoàn')) {
      return const Color(0xFF059669);
    }
    if (s.contains('hủy')) return const Color(0xFFDC2626);
    return const Color(0xFF4A7FE0);
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              children: [
                Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: _dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activity.typeLabel,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: _labelColor,
                          letterSpacing: 0.2,
                        ),
                      ),
                      Text(
                        activity.date,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8A8A9A),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${activity.code}  •  ${activity.branch}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B6B7B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _statusBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          activity.status,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: _statusFg,
                          ),
                        ),
                      ),
                      if (activity.amount != null)
                        Text(
                          activity.amount!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE53E3E),
                          ),
                        )
                      else
                        const Text(
                          '—',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8A8A9A),
                          ),
                        ),
                    ],
                  ),
                  if (!isLast)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: const Divider(height: 1, color: Color(0xFFEEEEEE)),
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

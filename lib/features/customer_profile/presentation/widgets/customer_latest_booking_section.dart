import 'package:democart/base/widgets/info_row_item.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_booking_model.dart';
import 'package:flutter/material.dart';

class CustomerLatestBookingSection extends StatelessWidget {
  const CustomerLatestBookingSection({super.key, required this.booking});

  final CustomerBookingModel booking;

  @override
  Widget build(BuildContext context) {
    return InfoRowItem(
      iconColor: const Color(0xFF4A7FE0),
      icon: Icons.calendar_month_outlined,
      title: 'Thông tin lượt đặt gần nhất',
      child: Column(
        children: [
          _Row(
            label: 'Mã Booking',
            value: booking.bookingCode,
            valueColor: const Color(0xFF4A7FE0),
            bold: true,
          ),
          const SizedBox(height: 8),
          _Row(label: 'Chi nhánh', value: booking.branch),
          const SizedBox(height: 8),
          _Row(
            label: 'Trạng thái',
            valueWidget: _StatusChip(status: booking.status),
          ),
          const SizedBox(height: 8),
          _Row(label: 'Ngày tạo', value: booking.createdAt),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    this.value,
    this.valueColor,
    this.bold = false,
    this.valueWidget,
  });

  final String label;
  final String? value;
  final Color? valueColor;
  final bool bold;
  final Widget? valueWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF8A8A9A)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: valueWidget != null
              ? Align(alignment: Alignment.centerLeft, child: valueWidget)
              : Text(
                  value ?? '',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                    color: valueColor ?? const Color(0xFF1A1A2E),
                  ),
                ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  Color get _bg {
    if (status.contains('Chờ')) return const Color(0xFFFFF7E8);
    if (status.contains('Hoàn')) return const Color(0xFFD1FAE5);
    if (status.contains('Hủy')) return const Color(0xFFFFE4E6);
    return const Color(0xFFE8F0FF);
  }

  Color get _fg {
    if (status.contains('Chờ')) return const Color(0xFFD97706);
    if (status.contains('Hoàn')) return const Color(0xFF059669);
    if (status.contains('Hủy')) return const Color(0xFFDC2626);
    return const Color(0xFF4A7FE0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: _fg),
      ),
    );
  }
}

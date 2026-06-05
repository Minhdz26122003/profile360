import 'package:democart/base/widgets/info_row_item.dart';
import 'package:democart/base/widgets/service_chip.dart';
import 'package:flutter/material.dart';

class CustomCrmTab extends StatelessWidget {
  const CustomCrmTab({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        InfoRowItem(
          icon: Icons.calendar_today,
          iconColor: const Color(0xFF2D5BE3),
          title: 'BOOKING',
          child: Column(
            children: [
              _Row(
                icon: Icons.perm_contact_cal_rounded,
                label: 'Mã Booking',
                value: 'BOOK-1218182',
                valueColor: const Color(0xFF4A7FE0),
                bold: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _Row(icon: Icons.sell, label: 'Thương hiệu', value: 'Kangnam'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _Row(
                icon: Icons.calendar_month,
                label: 'Ngày hẹn/Đến',
                value: '31/05/2026 09:12',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _Row(
                icon: Icons.tag,
                label: 'NV tư vấn',
                value: 'Administrator',
                valueColor: const Color(0xFFDC2626),
                bold: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _Row(
                icon: Icons.access_time_sharp,
                label: 'Trạng thái',
                valueWidget: const _StatusChip(status: 'Hoàn thành'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _Row(icon: Icons.apartment, label: 'Chi nhánh', value: ''),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _Row(
                icon: Icons.check_circle_outline_outlined,
                label: 'Trạng thái đến',
                value: 'Yes',
                valueColor: const Color(0xFF059669),
                bold: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _DetailRow(
                icon: Icons.edit_note_outlined,
                label: 'Ghi chú tư vấn',
                value:
                    'Nâng ngực Motiva ergo 69tr mentor extra 72tr KH cọc cuối năm làm Báo gấp ưu đãi qua KH chưa cbi được thời gian, em hướng khách qua thăm khám 1 là khám xong tv cọc khám sẽ làm luôn hoặc được thì chờ khoảng khác nhanh hơn nên để xếp lại lịch tư vấn sớm để tư vấn cho chị sớm chưa ạ.',
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEEEEEE)),
              ),
              _DetailRow(
                icon: Icons.inventory_2_outlined,
                label: 'Dịch vụ quan tâm / Thực hiện',
                valueWidget: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    ServiceChip(label: 'Áo ngực Mỹ size S (XS/M/L)'),
                    ServiceChip(label: 'Xeragel (10g/tuýp)'),
                    ServiceChip(label: 'Túi ngực Nano Motiva (Chip linh hoạt)'),
                    ServiceChip(label: 'Nâng ngực 4D (nano)'),
                    ServiceChip(
                      label: 'Keo dán da Dermabond (hộp 12 ống 0.5ml)',
                    ),
                  ],
                ),
              ),
              _buttonAction(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buttonAction() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 46,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.phone_outlined,
                  size: 18,
                  color: Color(0xFF2D5BE3),
                ),
                label: const Text(
                  'Gọi khách hàng',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D5BE3),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF2D5BE3), width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 46,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.note_alt_outlined,
                  size: 18,
                  color: Colors.white,
                ),
                label: const Text(
                  'Thêm ghi chú',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF1F5BFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.icon,
    required this.label,
    this.value,
    this.valueColor,
    this.bold = false,
    this.valueWidget,
  });

  final IconData icon;
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
        Icon(icon, size: 20, color: const Color(0xFF2D5BE3)),
        const SizedBox(width: 12),
        Expanded(
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    this.value,
    this.valueColor,
    this.valueWidget,
    this.bold = false,
  });

  final IconData icon;
  final String label;
  final String? value;
  final Widget? valueWidget;
  final Color? valueColor;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: const Color(0xFF2D5BE3)),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8A8A9A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 32),
            Expanded(
              child: valueWidget != null
                  ? Align(alignment: Alignment.centerLeft, child: valueWidget)
                  : Text(
                      value ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.55,
                        fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                        color: valueColor ?? const Color(0xFF1D1F2A),
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}

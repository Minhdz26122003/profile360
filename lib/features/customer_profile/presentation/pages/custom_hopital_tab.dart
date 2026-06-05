import 'package:democart/base/widgets/service_chip.dart';
import 'package:flutter/material.dart';

class CustomHopitalTab extends StatefulWidget {
  const CustomHopitalTab({super.key, required this.title});

  final String title;

  @override
  State<CustomHopitalTab> createState() => _CustomHopitalTabState();
}

class _CustomHopitalTabState extends State<CustomHopitalTab> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {'label': 'Phiếu khám', 'icon': Icons.calendar_month_outlined},
    {'label': 'Phiếu PT-TT', 'icon': Icons.person_outline},
    {'label': 'Phiếu chuyển khoa', 'icon': Icons.swap_horiz},
    {'label': 'Tái khám', 'icon': Icons.medical_services_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _tabs.length,
            itemBuilder: (context, index) {
              final isSelected = _selectedIndex == index;
              return _buildFilterItem(
                index: index,
                label: _tabs[index]['label'] as String,
                icon: _tabs[index]['icon'] as IconData,
                isSelected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              );
            },
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [_buildContentCard()],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterItem({
    required int index,
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          left: index == 0 ? 16 : 8,
          right: index == _tabs.length - 1 ? 16 : 0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2D5BE3)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected
                  ? const Color(0xFF2D5BE3)
                  : const Color(0xFF64748B),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF2D5BE3)
                    : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentCard() {
    switch (_selectedIndex) {
      case 0:
        return _buildExaminationCard();
      case 1:
        return _buildSurgeryCard();
      case 2:
        return _buildTransferCard();
      case 3:
        return _buildFollowUpCard();
      default:
        return _buildExaminationCard();
    }
  }

  Widget _buildExaminationCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HospitalInfoRow(
            label: 'Mã phiếu',
            value: 'PK-2026-114335',
            valueColor: Color(0xFF2D5BE3),
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Thương hiệu',
            value: 'Kangnam',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Phòng khám',
            value: 'Phòng khám PTTM-KN666',
            boldValue: true,
          ),
          const _HospitalInfoRow(label: 'Bác sĩ', value: '-'),
          const _HospitalInfoRow(
            label: 'Chẩn đoán',
            value: 'NGỰC',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Trạng thái',
            valueWidget: _StatusChip(
              status: 'Chờ thu tiền',
              bg: Color(0xFFFFF7E8),
              fg: Color(0xFFD97706),
            ),
          ),
          const _HospitalInfoRow(
            label: 'Chi nhánh',
            value: 'BỆNH VIỆN KANGNAM SÀI GÒN',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Ngày khám',
            value: '31/05/2026 09:37',
            boldValue: true,
          ),
          const _HospitalInfoRow(label: 'Điều dưỡng', value: '-'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
          ),
          const Text(
            'Dịch vụ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
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
          const SizedBox(height: 24),
          _buildActionButton('Xem chi tiết phiếu khám'),
        ],
      ),
    );
  }

  Widget _buildSurgeryCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HospitalInfoRow(
            label: 'Mã phiếu PT-TT',
            value: 'PT-2026-004812',
            valueColor: Color(0xFF2D5BE3),
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Thương hiệu',
            value: 'Kangnam',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Phòng mổ',
            value: 'Phòng phẫu thuật PTTM-A2',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Bác sĩ chính',
            value: 'Dr. Nguyễn Văn A',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Phương pháp',
            value: 'Nâng mũi cấu trúc Surgiform',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Trạng thái',
            valueWidget: _StatusChip(
              status: 'Hoàn thành',
              bg: Color(0xFFD1FAE5),
              fg: Color(0xFF059669),
            ),
          ),
          const _HospitalInfoRow(
            label: 'Ngày thực hiện',
            value: '30/05/2026 14:20',
            boldValue: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
          ),
          const Text(
            'Dịch vụ đi kèm',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              ServiceChip(label: 'Nâng mũi Surgiform'),
              ServiceChip(label: 'Gây mê nội khí quản'),
            ],
          ),
          const SizedBox(height: 24),
          _buildActionButton('Xem chi tiết phiếu phẫu thuật'),
        ],
      ),
    );
  }

  Widget _buildTransferCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HospitalInfoRow(
            label: 'Mã phiếu chuyển',
            value: 'CK-2026-000411',
            valueColor: Color(0xFF2D5BE3),
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Khoa chuyển đi',
            value: 'Khoa khám bệnh',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Khoa chuyển đến',
            value: 'Khoa Phẫu thuật thẩm mỹ',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Lý do chuyển',
            value: 'Thực hiện phẫu thuật theo chỉ định bác sĩ',
          ),
          const _HospitalInfoRow(
            label: 'Người duyệt',
            value: 'Bác sĩ Lê Hoàng B',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Thời gian chuyển',
            value: '31/05/2026 10:15',
            boldValue: true,
          ),
          const SizedBox(height: 24),
          _buildActionButton('Xem chi tiết phiếu chuyển khoa'),
        ],
      ),
    );
  }

  Widget _buildFollowUpCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HospitalInfoRow(
            label: 'Mã phiếu hẹn',
            value: 'TK-2026-009822',
            valueColor: Color(0xFF2D5BE3),
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Ngày tái khám',
            value: '07/06/2026 09:00',
            valueColor: Color(0xFFDC2626),
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Nội dung',
            value: 'Tái khám định kỳ, cắt chỉ nâng ngực',
            boldValue: true,
          ),
          const _HospitalInfoRow(
            label: 'Bác sĩ hẹn',
            value: 'Dr. Nguyễn Văn A',
          ),
          const _HospitalInfoRow(
            label: 'Trạng thái',
            valueWidget: _StatusChip(
              status: 'Chưa diễn ra',
              bg: Color(0xFFE8F0FF),
              fg: Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 24),
          _buildActionButton('Xem chi tiết lịch hẹn'),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildActionButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: const Color(0xFF1F5BFF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 12),
        ],
      ),
    );
  }
}

class _HospitalInfoRow extends StatelessWidget {
  const _HospitalInfoRow({
    required this.label,
    this.value,
    this.valueWidget,
    this.boldValue = false,
    this.valueColor,
  });

  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool boldValue;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF8A8A9A),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child:
                valueWidget ??
                Text(
                  value ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: boldValue ? FontWeight.w600 : FontWeight.w400,
                    color: valueColor ?? const Color(0xFF1A1A2E),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.bg, required this.fg});

  final String status;
  final Color bg;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg),
      ),
    );
  }
}

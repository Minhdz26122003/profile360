import 'package:democart/features/customer_profile/domain/entities/customer_activity_model.dart';
import 'package:flutter/material.dart';

class CustomActionTab extends StatefulWidget {
  const CustomActionTab({
    super.key,
    required this.title,
    required this.activities,
  });

  final String title;
  final List<CustomerActivityModel> activities;

  @override
  State<CustomActionTab> createState() => _CustomActionTabState();
}

enum _ActionFilter { all, booking, examination, payment }

class _CustomActionTabState extends State<CustomActionTab> {
  _ActionFilter _selectedFilter = _ActionFilter.all;

  List<CustomerActivityModel> get _filteredActivities {
    final items = [...widget.activities]
      ..sort((a, b) => _parseDate(b.date).compareTo(_parseDate(a.date)));

    switch (_selectedFilter) {
      case _ActionFilter.all:
        return items;
      case _ActionFilter.booking:
        return items
            .where((item) => item.type == ActivityType.booking)
            .toList();
      case _ActionFilter.examination:
        return items
            .where((item) => item.type == ActivityType.examination)
            .toList();
      case _ActionFilter.payment:
        return items
            .where((item) => item.type == ActivityType.payment)
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredActivities;

    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
      children: [
        _buildFilterRow(),
        const SizedBox(height: 16),
        if (items.isEmpty)
          const _EmptyState()
        else
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            return _TimelineItem(
              activity: entry.value,
              isFirst: index == 0,
              isLast: index == items.length - 1,
            );
          }),
      ],
    );
  }

  // flitter
  Widget _buildFilterRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChipButton(
            label: 'Tất cả',
            selected: _selectedFilter == _ActionFilter.all,
            onTap: () => setState(() => _selectedFilter = _ActionFilter.all),
          ),
          const SizedBox(width: 8),
          _FilterChipButton(
            label: 'Booking',
            selected: _selectedFilter == _ActionFilter.booking,
            onTap: () =>
                setState(() => _selectedFilter = _ActionFilter.booking),
          ),
          const SizedBox(width: 8),
          _FilterChipButton(
            label: 'Phiếu khám',
            selected: _selectedFilter == _ActionFilter.examination,
            onTap: () =>
                setState(() => _selectedFilter = _ActionFilter.examination),
          ),
          const SizedBox(width: 8),
          _FilterChipButton(
            label: 'Thanh toán',
            selected: _selectedFilter == _ActionFilter.payment,
            onTap: () =>
                setState(() => _selectedFilter = _ActionFilter.payment),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.activity,
    required this.isFirst,
    required this.isLast,
  });

  final CustomerActivityModel activity;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final config = _ActivityCardConfig.fromActivity(activity);

    return Stack(
      children: [
        Positioned(
          left: 10,
          top: isFirst ? 28 : 0,
          bottom: isLast ? 26 : 0,
          child: Container(width: 1.3, color: const Color(0xFFE8EDF6)),
        ),
        Positioned(
          left: 4,
          top: 20,
          child: Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: config.dotColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: config.dotColor.withValues(alpha: 0.22),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 26, bottom: 12),
          child: _InteractionCard(activity: activity, config: config),
        ),
      ],
    );
  }
}

class _InteractionCard extends StatelessWidget {
  const _InteractionCard({required this.activity, required this.config});

  final CustomerActivityModel activity;
  final _ActivityCardConfig config;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 11),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF1F4FA)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.access_time, size: 11, color: Color(0xFFB1B8C7)),
              const SizedBox(width: 4),
              Text(
                _displayDate(activity.date),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF98A2B3),
                ),
              ),
              const Spacer(),
              Text(
                _relativeText(activity.date),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFB1B8C7),
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.local_fire_department,
                size: 15,
                color: Color(0xFFFF8A28),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            config.title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: config.titleColor,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 8),

          ...config.rows.map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: _MiniInfoRow(
                label: row.label,
                value: row.value,
                valueColor: row.valueColor,
                bold: row.bold,
                valueWidget: row.valueWidget,
              ),
            ),
          ),
          if (config.services.isNotEmpty) ...[
            const SizedBox(height: 2),
            _MiniInfoRow(
              label: 'Dịch vụ:',
              valueWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: config.services
                    .map(
                      (service) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          service,
                          style: const TextStyle(
                            fontSize: 11,

                            color: Color(0xFF344054),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _MiniInfoRow extends StatelessWidget {
  const _MiniInfoRow({
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
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF98A2B3),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child:
              valueWidget ??
              Text(
                value ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: valueColor ?? const Color(0xFF1F2937),
                  fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
        ),
      ],
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  const _FilterChipButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEFF4FF) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? const Color(0xFF9CB7FF) : const Color(0xFFE5E7EB),
            width: 1.1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? const Color(0xFF2D5BE3) : const Color(0xFF667085),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 56),
      alignment: Alignment.center,
      child: const Column(
        children: [
          Icon(Icons.timeline_outlined, size: 42, color: Color(0xFFCBD5E1)),
          SizedBox(height: 12),
          Text(
            'Chưa có tương tác phù hợp',
            style: TextStyle(fontSize: 13, color: Color(0xFF98A2B3)),
          ),
        ],
      ),
    );
  }
}

class _ActivityCardConfig {
  const _ActivityCardConfig({
    required this.title,
    required this.titleColor,
    required this.dotColor,
    required this.rows,
    required this.services,
  });

  final String title;
  final Color titleColor;
  final Color dotColor;
  final List<_InfoRowData> rows;
  final List<String> services;

  factory _ActivityCardConfig.fromActivity(CustomerActivityModel activity) {
    switch (activity.type) {
      case ActivityType.payment:
        return _ActivityCardConfig(
          title: 'THANH TOÁN',
          titleColor: const Color(0xFF16A34A),
          dotColor: const Color(0xFF22C55E),
          rows: [
            _InfoRowData(label: 'Booking:', value: activity.code),
            _InfoRowData(
              label: 'Người thu:',
              value: activity.assignee ?? activity.branch,
            ),
            _InfoRowData(
              label: 'Trạng thái:',
              valueWidget: _StatusChip(status: activity.status),
            ),
            _InfoRowData(
              label: 'Tổng tiền:',
              value: activity.amount ?? '400.000 VND',
              valueColor: const Color(0xFFEF4444),
              bold: true,
            ),
          ],
          services: const [],
        );
      case ActivityType.examination:
        return _ActivityCardConfig(
          title: 'PHIẾU KHÁM',
          titleColor: const Color(0xFF16A34A),
          dotColor: const Color(0xFF22C55E),
          rows: [
            _InfoRowData(label: 'Mã phiếu:', value: activity.code),
            _InfoRowData(
              label: 'Trạng thái:',

              valueWidget: _StatusChip(status: activity.status),
            ),
            _InfoRowData(label: 'Chi nhánh:', value: activity.branch),
          ],
          services: const [],
        );
      case ActivityType.booking:
        return _ActivityCardConfig(
          title: 'BOOKING',
          titleColor: const Color(0xFF2563EB),
          dotColor: const Color(0xFF2563EB),
          rows: [
            _InfoRowData(label: 'Mã Booking:', value: activity.code),
            _InfoRowData(label: 'Thương hiệu:', value: 'Kangnam'),
            _InfoRowData(label: 'Chi nhánh:', value: activity.branch),
          ],
          services: const [
            'Áo ngực Mỹ size S (XS/M/L), Xeragel (10g/tuýp),',
            'Túi ngực Nano Motiva (Chip linh hoạt),',
            'Nâng ngực 4D (nano), Keo dán da Dermabond',
          ],
        );
    }
  }
}

class _InfoRowData {
  const _InfoRowData({
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
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final String status;

  Color get _bg {
    if (_contains(status, const ['Chờ'])) return const Color(0xFFFFF5E8);
    if (_contains(status, const ['Đã', 'Hoàn'])) return const Color(0xFFEAFBF0);
    if (_contains(status, const ['Hủy'])) return const Color(0xFFFFE9EC);
    return const Color(0xFFEAF1FF);
  }

  Color get _fg {
    if (_contains(status, const ['Chờ'])) return const Color(0xFFD97706);
    if (_contains(status, const ['Đã', 'Hoàn'])) return const Color(0xFF16A34A);
    if (_contains(status, const ['Hủy'])) return const Color(0xFFDC2626);
    return const Color(0xFF2563EB);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _fg,
          ),
        ),
      ),
    );
  }
}

bool _contains(String value, List<String> patterns) {
  return patterns.any((pattern) => value.contains(pattern));
}

DateTime _parseDate(String value) {
  final parts = value.split(' ');
  if (parts.length != 2) return DateTime.fromMillisecondsSinceEpoch(0);

  final dateParts = parts.first.split('/');
  final timeParts = parts.last.split(':');
  if (dateParts.length != 3 || timeParts.length != 2) {
    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  return DateTime(
    int.tryParse(dateParts[2]) ?? 0,
    int.tryParse(dateParts[1]) ?? 1,
    int.tryParse(dateParts[0]) ?? 1,
    int.tryParse(timeParts[0]) ?? 0,
    int.tryParse(timeParts[1]) ?? 0,
  );
}

String _displayDate(String value) {
  final parsed = _parseDate(value);
  final hour = parsed.hour.toString().padLeft(2, '0');
  final minute = parsed.minute.toString().padLeft(2, '0');
  final day = parsed.day.toString().padLeft(2, '0');
  final month = parsed.month.toString().padLeft(2, '0');
  return '$hour:$minute - $day/$month/${parsed.year}';
}

String _relativeText(String value) {
  final parsed = _parseDate(value);
  final now = DateTime.now();
  final difference = now.difference(parsed).inDays;

  if (difference <= 0) return 'Hôm nay';
  if (difference == 1) return '1 ngày trước';
  return '$difference ngày trước';
}

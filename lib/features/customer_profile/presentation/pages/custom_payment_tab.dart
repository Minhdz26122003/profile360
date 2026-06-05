import 'package:flutter/material.dart';

class CustomPaymentTab extends StatefulWidget {
  const CustomPaymentTab({super.key, required this.title});

  final String title;

  @override
  State<CustomPaymentTab> createState() => _CustomPaymentTabState();
}

class _CustomPaymentTabState extends State<CustomPaymentTab> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _transactions = [
    {
      'code': 'BOOK-260502-00328',
      'date': '31/05/2026 18:05',
      'type': 'Nhận tiền',
      'amount': '400.000 VND',
      'agency': 'BỆNH VIỆN KANGNAM SÀI GÒN',
      'user': 'BÙI THỊ KIM THOA',
      'status': 'Đã xác nhận',
      'content': 'PT S08666505 : Keo dán da Dermabond (hộp 12 ống 0.5ml);',
    },
    {
      'code': 'BOOK-260502-00329',
      'date': '31/05/2026 09:37',
      'type': 'Nhận tiền',
      'amount': '68.000.000 VND',
      'agency': 'BỆNH VIỆN KANGNAM SÀI GÒN',
      'user': 'BÙI THỊ KIM THOA',
      'status': 'Đã xác nhận',
      'content':
          'PT S01923112: Áo ngực Mỹ size S(XS/S/M/L/XL); Xeragel(10g/tuýp)',
    },
    {
      'code': 'BOOK-260502-00330',
      'date': '15/04/2026 10:00',
      'type': 'Nhận tiền',
      'amount': '5.220.000 VND',
      'agency': 'BỆNH VIỆN KANGNAM SÀI GÒN',
      'user': 'BÙI THỊ KIM THOA',
      'status': 'Đã xác nhận',
      'content': 'PT S08666505 : Keo dán da Dermabond (hộp 12 ống 0.5ml);',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = [];
    if (_selectedIndex == 0) {
      filteredList = _transactions;
    } else if (_selectedIndex == 1) {
      filteredList = _transactions
          .where((t) => t['status'] == 'Đã xác nhận')
          .toList();
    } else if (_selectedIndex == 2) {
      filteredList = _transactions
          .where((t) => t['status'] == 'Chờ thu tiền')
          .toList();
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        _buildSummaryCard(),
        const SizedBox(height: 24),
        if (filteredList.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40),
            alignment: Alignment.center,
            child: Column(
              children: const [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 48,
                  color: Color(0xFFCBD5E1),
                ),
                SizedBox(height: 12),
                Text(
                  'Không có giao dịch nào',
                  style: TextStyle(fontSize: 13, color: Color(0xFF8A8A9A)),
                ),
              ],
            ),
          )
        else
          ...filteredList.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isFirst = index == 0;
            final isLast = index == filteredList.length - 1;
            return _buildTransactionTimelineItem(item, isFirst, isLast);
          }),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.account_balance_wallet_outlined,
                  label: 'Tổng đã thanh toán',
                  value: '73.620.000đ',
                  valueColor: const Color(0xFFDC2626),
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.description_outlined,
                  label: 'Tổng giao dịch',
                  value: '3 giao dịch',
                  valueColor: const Color(0xFF1A1A2E),
                ),
              ),
              _buildVerticalDivider(),
              Expanded(
                child: _buildMetricItem(
                  icon: Icons.calendar_month_outlined,
                  label: 'Giao dịch gần nhất',
                  value: '31/05/2026 18:05',
                  valueColor: const Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildPill(
                index: 0,
                label: 'Tất cả (3)',
                activeBg: const Color(0xFFEFF6FF),
                activeFg: const Color(0xFF2D5BE3),
                activeBorder: const Color(0xFFBFDBFE),
              ),
              const SizedBox(width: 8),
              _buildPill(
                index: 1,
                label: 'Đã xác nhận (3)',
                activeBg: const Color(0xFFD1FAE5),
                activeFg: const Color(0xFF059669),
                activeBorder: const Color(0xFFA7F3D0),
              ),
              const SizedBox(width: 8),
              _buildPill(
                index: 2,
                label: 'Chờ thu tiền (0)',
                activeBg: const Color(0xFFFFF7E8),
                activeFg: const Color(0xFFD97706),
                activeBorder: const Color(0xFFFDE68A),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Icon(icon, size: 22, color: const Color(0xFF2D5BE3)),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF8A8A9A),
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 44,
      color: const Color(0xFFEEEEEE),
      margin: const EdgeInsets.symmetric(horizontal: 4),
    );
  }

  Widget _buildPill({
    required int index,
    required String label,
    required Color activeBg,
    required Color activeFg,
    required Color activeBorder,
  }) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? activeBg : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? activeBorder : const Color(0xFFEEEEEE),
              width: 1.2,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? activeFg : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTimelineItem(
    Map<String, dynamic> item,
    bool isFirst,
    bool isLast,
  ) {
    return Stack(
      children: [
        Positioned(
          top: isFirst ? 32 : 0,
          bottom: isLast ? null : 0,
          height: isLast ? 32 : null,
          left: 5,
          child: Container(width: 1.5, color: const Color(0xFFE2E8F0)),
        ),
        Positioned(
          left: 0,
          top: 26,
          child: Container(
            width: 11,
            height: 11,
            decoration: BoxDecoration(
              color: const Color(0xFF22C55E),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF22C55E).withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 12),
          child: _buildTransactionCard(item),
        ),
      ],
    );
  }

  Widget _buildTransactionCard(Map<String, dynamic> item) {
    final isConfirmed = item['status'] == 'Đã xác nhận';
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF6B8EFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.receipt_long,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item['code'] as String,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D5BE3),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                item['date'] as String,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8A8A9A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildItemRow('Loại TT:', item['type'] as String),
          const SizedBox(height: 8),
          _buildItemRow(
            'Trạng thái:',
            item['status'] as String,
            valueWidget: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isConfirmed
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item['status'] as String,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isConfirmed
                        ? const Color(0xFF2E7D32)
                        : const Color(0xFFEF6C00),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildItemRow('Chi nhánh:', item['agency'] as String),
          const SizedBox(height: 8),
          _buildItemRow('Người thu:', item['user'] as String),
          const SizedBox(height: 8),
          _buildItemRow(
            'Tổng tiền:',
            item['amount'] as String,
            bold: true,
            valueColor: const Color(0xFFDC2626),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 12, height: 1.4),
                children: [
                  const TextSpan(
                    text: 'Nội dung:  ',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: item['content'] as String,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(
    String label,
    String value, {
    bool bold = false,
    Color? valueColor,
    Widget? valueWidget,
  }) {
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
        Expanded(
          child:
              valueWidget ??
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
                  color: valueColor ?? const Color(0xFF1D1F2A),
                ),
              ),
        ),
      ],
    );
  }
}

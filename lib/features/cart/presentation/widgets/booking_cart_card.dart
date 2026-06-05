import 'dart:math' as math;
import 'package:democart/features/cart/domain/entities/booking_cart.dart';
import 'package:flutter/material.dart';

class BookingCartCard extends StatelessWidget {
  final BookingCart cart;
  final VoidCallback onConfirm;

  const BookingCartCard({
    super.key,
    required this.cart,
    required this.onConfirm,
  });

  String _formatPrice(double price) {
    final str = price.toInt().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return '${buffer.toString()}đ';
  }

  @override
  Widget build(BuildContext context) {
    final isConfirmed = cart.status == 'Đã xác nhận';
    final cartIconBgColor = const Color(0xFF1E88E5);
    final cartIconColor = Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Khách hàng: ${cart.customerName}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C1C1C),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            cart.id,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF6E6E6E),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...cart.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6E6E6E),
                    ),
                    children: [
                      const TextSpan(text: 'Tổng tiền: '),
                      TextSpan(
                        text: _formatPrice(cart.totalPrice),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF7A00),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(height: 1, color: Color(0xFFEEEEEE)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cart.source,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6E6E6E),
                      ),
                    ),
                    const Text(
                      'Xác nhận',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 14,
            right: -28,
            child: Transform.rotate(
              angle: math.pi / 4,
              child: Container(
                width: 100,
                padding: const EdgeInsets.symmetric(vertical: 1),
                color: isConfirmed
                    ? const Color(0xFF888888)
                    : const Color.fromARGB(255, 46, 179, 80),
                child: Center(
                  child: Text(
                    cart.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 1,
            left: 1,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: cartIconBgColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.transparent, width: 1),
              ),
              child: Icon(
                Icons.shopping_cart_outlined,
                size: 16,
                color: cartIconColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

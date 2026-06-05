import 'package:democart/features/cart/domain/entities/service_item.dart';
import 'package:equatable/equatable.dart';

class BookingCart extends Equatable {
  final String id;
  final String customerName;
  final String phoneNumber;
  final List<ServiceItem> items;
  final double totalPrice;
  final String source;
  final String status;

  const BookingCart({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.items,
    required this.totalPrice,
    required this.source,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        customerName,
        phoneNumber,
        items,
        totalPrice,
        source,
        status,
      ];

  BookingCart copyWith({
    String? id,
    String? customerName,
    String? phoneNumber,
    List<ServiceItem>? items,
    double? totalPrice,
    String? source,
    String? status,
  }) {
    return BookingCart(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
      source: source ?? this.source,
      status: status ?? this.status,
    );
  }
}

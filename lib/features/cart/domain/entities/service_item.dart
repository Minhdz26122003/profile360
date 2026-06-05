import 'package:equatable/equatable.dart';

class ServiceItem extends Equatable {
  final String name;
  final int quantity;

  const ServiceItem({
    required this.name,
    required this.quantity,
  });

  @override
  List<Object?> get props => [name, quantity];

  ServiceItem copyWith({
    String? name,
    int? quantity,
  }) {
    return ServiceItem(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
    );
  }
}

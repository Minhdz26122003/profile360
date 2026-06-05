import 'package:equatable/equatable.dart';

class CustomerServiceModel extends Equatable {
  const CustomerServiceModel({required this.services});

  final List<String> services;

  @override
  List<Object?> get props => [services];
}

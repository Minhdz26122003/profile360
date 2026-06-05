import 'package:equatable/equatable.dart';

class CustomerBookingModel extends Equatable {
  const CustomerBookingModel({
    required this.bookingCode,
    required this.branch,
    required this.status,
    required this.createdAt,
  });

  final String bookingCode;
  final String branch;
  final String status;
  final String createdAt;

  @override
  List<Object?> get props => [bookingCode, branch, status, createdAt];
}

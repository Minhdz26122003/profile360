import 'package:equatable/equatable.dart';

enum ActivityType { booking, examination, payment }

class CustomerActivityModel extends Equatable {
  const CustomerActivityModel({
    required this.type,
    required this.code,
    required this.branch,
    required this.status,
    required this.date,
    this.amount,
    this.assignee,
  });

  final ActivityType type;
  final String code;
  final String branch;
  final String status;
  final String date;
  final String? amount;
  final String? assignee;

  String get typeLabel {
    switch (type) {
      case ActivityType.booking:
        return 'BOOKING';
      case ActivityType.examination:
        return 'PHIẾU KHÁM';
      case ActivityType.payment:
        return 'THANH TOÁN';
    }
  }

  @override
  List<Object?> get props => [
    type,
    code,
    branch,
    status,
    date,
    amount,
    assignee,
  ];
}

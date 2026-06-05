import 'package:equatable/equatable.dart';

class CustomerPaymentTransactionModel extends Equatable {
  const CustomerPaymentTransactionModel({
    required this.code,
    required this.date,
    required this.type,
    required this.amount,
    required this.agency,
    required this.user,
    required this.status,
    required this.content,
  });

  final String code;
  final String date;
  final String type;
  final String amount;
  final String agency;
  final String user;
  final String status;
  final String content;

  @override
  List<Object?> get props => [
    code,
    date,
    type,
    amount,
    agency,
    user,
    status,
    content,
  ];
}

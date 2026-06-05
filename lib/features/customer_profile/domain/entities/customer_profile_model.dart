import 'package:equatable/equatable.dart';

class CustomerProfileModel extends Equatable {
  const CustomerProfileModel({
    required this.id,
    required this.name,
    required this.code,
    required this.phone,
    required this.gender,
    required this.birthYear,
    required this.region,
    required this.status,
    this.avatarUrl,
  });

  final String id;
  final String name;
  final String code;
  final String phone;
  final String gender;
  final String birthYear;
  final String region;
  final String status;
  final String? avatarUrl;

  @override
  List<Object?> get props => [
        id,
        name,
        code,
        phone,
        gender,
        birthYear,
        region,
        status,
        avatarUrl,
      ];
}

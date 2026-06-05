import 'package:democart/features/customer_profile/domain/entities/customer_activity_model.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_booking_model.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_profile_model.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_service_model.dart';
import 'package:equatable/equatable.dart';

class CustomerProfileData extends Equatable {
  const CustomerProfileData({
    required this.profile,
    required this.latestBooking,
    required this.latestServices,
    required this.activities,
  });

  final CustomerProfileModel profile;
  final CustomerBookingModel latestBooking;
  final CustomerServiceModel latestServices;
  final List<CustomerActivityModel> activities;

  @override
  List<Object?> get props =>
      [profile, latestBooking, latestServices, activities];
}

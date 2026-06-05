import 'package:democart/features/customer_profile/domain/entities/customer_profile_data.dart';
import 'package:democart/features/customer_profile/presentation/cubit/customer_profile_cubit.dart';
import 'package:democart/features/customer_profile/presentation/widgets/customer_activity_section.dart';
import 'package:democart/features/customer_profile/presentation/widgets/customer_latest_booking_section.dart';
import 'package:democart/features/customer_profile/presentation/widgets/customer_latest_services_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerOverviewTab extends StatelessWidget {
  const CustomerOverviewTab({super.key, required this.data});

  final CustomerProfileData data;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<CustomerProfileCubit>().loadProfile(
        customerId: data.profile.code,
        isRefresh: true,
      ),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          CustomerLatestBookingSection(booking: data.latestBooking),
          CustomerLatestServicesSection(services: data.latestServices),
          CustomerActivitySection(activities: data.activities),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

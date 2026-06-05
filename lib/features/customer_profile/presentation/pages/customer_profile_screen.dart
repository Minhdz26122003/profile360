import 'package:democart/features/customer_profile/presentation/cubit/customer_profile_cubit.dart';
import 'package:democart/features/customer_profile/presentation/cubit/customer_profile_state.dart';
import 'package:democart/features/customer_profile/presentation/pages/custom_action_tab.dart';
import 'package:democart/features/customer_profile/presentation/pages/custom_crm_tab.dart';
import 'package:democart/features/customer_profile/presentation/pages/custom_hopital_tab.dart';
import 'package:democart/features/customer_profile/presentation/pages/custom_payment_tab.dart';
import 'package:democart/features/customer_profile/presentation/pages/customer_overview_tab.dart';
import 'package:democart/features/customer_profile/presentation/widgets/customer_header_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key, this.customerId = 'CUS709980'});

  final String customerId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          CustomerProfileCubit()..loadProfile(customerId: customerId),
      child: _CustomerProfileView(customerId: customerId),
    );
  }
}

class _CustomerProfileView extends StatelessWidget {
  const _CustomerProfileView({required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(context),
        body: BlocBuilder<CustomerProfileCubit, CustomerProfileState>(
          builder: (context, state) {
            if (state is CustomerProfileLoading ||
                state is CustomerProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is CustomerProfileError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Color(0xFFDC2626),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6B6B7B),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context
                            .read<CustomerProfileCubit>()
                            .loadProfile(customerId: customerId),
                        child: const Text('Thử lại'),
                      ),
                    ],
                  ),
                ),
              );
            }

            final data = (state as CustomerProfileLoaded).data;

            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: CustomerHeaderCard(profile: data.profile),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  SliverPersistentHeader(
                    pinned: false,
                    delegate: _TabBarSliverDelegate(
                      child: ColoredBox(
                        color: Colors.white,
                        child: _buildTabBar(),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  CustomerOverviewTab(data: data),
                  const CustomCrmTab(title: 'CRM'),
                  const CustomHopitalTab(title: 'Bệnh viện'),
                  const CustomPaymentTab(title: 'Thanh toán'),
                  CustomActionTab(
                    title: 'Tương tác',
                    activities: data.activities,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A2E)),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: const Text(
        'Hồ sơ khách hàng',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1A1A2E),
        ),
      ),
      centerTitle: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      labelColor: const Color(0xFF2D5BE3),
      unselectedLabelColor: const Color(0xFF8A8A9A),
      indicatorColor: const Color(0xFF2D5BE3),
      indicatorWeight: 2.5,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(text: 'Tổng quan'),
        Tab(text: 'CRM'),
        Tab(text: 'Bệnh viện'),
        Tab(text: 'Thanh toán'),
        Tab(text: 'Tương tác'),
      ],
    );
  }
}

class _TabBarSliverDelegate extends SliverPersistentHeaderDelegate {
  const _TabBarSliverDelegate({required this.child});

  final Widget child;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _TabBarSliverDelegate oldDelegate) {
    return oldDelegate.child != child;
  }
}

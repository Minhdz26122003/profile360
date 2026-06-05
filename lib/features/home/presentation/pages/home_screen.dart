import 'package:democart/features/home/presentation/blocs/home_cubit.dart';
import 'package:democart/features/home/presentation/blocs/home_state.dart';
import 'package:democart/features/home/presentation/widgets/health/home_health_index_section.dart';
import 'package:democart/features/home/presentation/widgets/home_banner_section.dart';
import 'package:democart/features/home/presentation/widgets/home_category_section.dart';
import 'package:democart/features/home/presentation/widgets/home_featured_services_section.dart';
import 'package:democart/features/home/presentation/widgets/home_latest_service_section.dart';
import 'package:democart/features/home/presentation/widgets/home_section_divider.dart';
import 'package:democart/features/home/presentation/widgets/news/home_news_section.dart';
import 'package:democart/features/home/presentation/widgets/offers/home_offers_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..loadHome(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().loadHome(),
                      child: const Text('Thử lại'),
                    ),
                  ],
                ),
              ),
            );
          }

          final data = (state as HomeLoaded).data;

          return SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeBannerSection(banners: data.banners),
                  const SizedBox(height: 40),
                  HomeCategorySection(items: data.categories),
                  const HomeSectionDivider(),
                  HomeLatestServiceSection(data: data.latestService),
                  const HomeSectionDivider(),
                  HomeHealthIndexSection(metrics: data.healthMetrics),
                  const HomeSectionDivider(),
                  HomeFeaturedServicesSection(
                    featuredImages: data.featuredServiceImages,
                    services: data.featuredServices,
                  ),
                  const HomeSectionDivider(),
                  HomeNewsSection(news: data.news),
                  const HomeSectionDivider(),
                  HomeOffersSection(offers: data.offers),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

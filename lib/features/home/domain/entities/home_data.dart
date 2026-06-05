import 'package:democart/features/home/domain/entities/home_banner_item.dart';
import 'package:democart/features/home/domain/entities/home_health_metric.dart';
import 'package:democart/features/home/domain/entities/home_latest_service.dart';
import 'package:democart/features/home/domain/entities/home_news_item.dart';
import 'package:democart/features/home/domain/entities/home_offer_item.dart';
import 'package:democart/features/home/domain/entities/home_service_item.dart';
import 'package:democart/features/cart/domain/entities/category_item.dart';

class HomeData {
  const HomeData({
    required this.banners,
    required this.categories,
    required this.latestService,
    required this.healthMetrics,
    required this.featuredServiceImages,
    required this.featuredServices,
    required this.news,
    required this.offers,
  });

  final List<HomeBannerItem> banners;
  final List<CategoryItem> categories;
  final HomeLatestService latestService;
  final List<HomeHealthMetric> healthMetrics;
  final List<String> featuredServiceImages;
  final List<HomeServiceItem> featuredServices;
  final List<HomeNewsItem> news;
  final List<HomeOfferItem> offers;
}

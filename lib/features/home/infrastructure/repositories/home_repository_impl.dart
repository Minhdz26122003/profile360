import 'package:democart/features/cart/domain/entities/category_item.dart';
import 'package:democart/features/home/domain/entities/home_banner_item.dart';
import 'package:democart/features/home/domain/entities/home_data.dart';
import 'package:democart/features/home/domain/entities/home_health_metric.dart';
import 'package:democart/features/home/domain/entities/home_latest_service.dart';
import 'package:democart/features/home/domain/entities/home_news_item.dart';
import 'package:democart/features/home/domain/entities/home_offer_item.dart';
import 'package:democart/features/home/domain/entities/home_service_item.dart';
import 'package:democart/features/home/infrastructure/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<HomeData> loadHome() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));

    return const HomeData(
      banners: [
        HomeBannerItem(imagePath: 'asset/images/Banner.jpg'),
        HomeBannerItem(imagePath: 'asset/images/Banner.jpg'),
        HomeBannerItem(imagePath: 'asset/images/Banner.jpg'),
      ],
      categories: [
        CategoryItem(
          title: 'Quy trình dịch vụ',
          iconPath: 'asset/icons/quytrinnh_dichvu.svg',
        ),
        CategoryItem(
          title: 'Lịch sử dịch vụ',
          iconPath: 'asset/icons/lichsu_dicvu.svg',
        ),
        CategoryItem(
          title: 'Danh sách lịch hẹn',
          iconPath: 'asset/icons/ds_lichhen.svg',
        ),
        CategoryItem(
          title: 'Chương trình ưu đãi',
          iconPath: 'asset/icons/chuongtrinh_uudai.svg',
        ),
        CategoryItem(
          title: 'Tin tức',
          iconPath: 'asset/icons/tintuc.svg',
          badge: '2',
        ),
        CategoryItem(
          title: 'Cộng tác viên',
          iconPath: 'asset/icons/congtacvien.svg',
        ),
        CategoryItem(
          title: 'Quà của tôi',
          iconPath: 'asset/icons/quacuatoi.svg',
          badge: '99+',
        ),
        CategoryItem(
          title: 'Thẻ thành viên',
          iconPath: 'asset/icons/thethanhvien.svg',
        ),
      ],
      latestService: HomeLatestService(
        date: '28/02/2026',
        services: ['Nâng mũi Hàn Quốc', 'Nâng mũi Cấu trúc Idol'],
        status: 'Hoàn thành',
        actionChips: ['Lịch tái khám', 'Hướng dẫn chăm sóc', 'Đơn thuốc'],
      ),
      healthMetrics: [
        HomeHealthMetric(
          label: 'Huyết áp',
          icon: 'asset/icons/blood.svg',
          value: '90mmHG',
        ),
        HomeHealthMetric(
          label: 'BMI',
          icon: 'asset/icons/bmi.svg',
          value: '22Kg/m2',
        ),
        HomeHealthMetric(
          label: 'Cân nặng',
          icon: 'asset/icons/weight.svg',
          value: '52Kg',
        ),
      ],
      featuredServiceImages: [
        'asset/images/hci.jpg',
        'asset/images/kangnam.jpg',
        'asset/images/kangnam2.jpg',
      ],
      featuredServices: [
        HomeServiceItem(
          imagePath: 'asset/images/service1.jpg',
          name: 'Nâng mũi Hàn Quốc',
          price: '28.800.000',
          sold: '500+',
        ),
        HomeServiceItem(
          imagePath: 'asset/images/service2.jpg',
          name: 'Nâng mũi Idol Line',
          price: '28.800.000',
          sold: '500+',
        ),
        HomeServiceItem(
          imagePath: 'asset/images/service3.jpg',
          name: 'Nâng mũi 4D',
          price: '48.800.000',
          sold: '500+',
        ),
        HomeServiceItem(
          imagePath: 'asset/images/service4.jpg',
          name: 'Nâng mũi 6D',
          price: '58.800.000',
          sold: '500+',
        ),
      ],
      news: [
        HomeNewsItem(
          imagePath: 'asset/images/new1.jpg',
          title: 'Hành trình lột xác mùa 7',
        ),
        HomeNewsItem(
          imagePath: 'asset/images/new1.jpg',
          title: 'Hành trình lột xác mùa 8',
        ),
        HomeNewsItem(
          imagePath: 'asset/images/new1.jpg',
          title: 'Ưu đãi làm đẹp tháng này',
        ),
      ],
      offers: [
        HomeOfferItem(
          imagePath: 'asset/images/offer1.jpg',
          title: 'Hành trình lột xác mùa 7',
        ),
        HomeOfferItem(
          imagePath: 'asset/images/offer1.jpg',
          title: 'Hành trình lột xác mùa 8',
        ),
        HomeOfferItem(
          imagePath: 'asset/images/offer1.jpg',
          title: 'Ưu đãi làm đẹp tháng này',
        ),
      ],
    );
  }
}

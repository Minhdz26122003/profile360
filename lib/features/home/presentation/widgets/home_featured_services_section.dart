import 'package:democart/features/home/domain/entities/home_service_item.dart';
import 'package:flutter/material.dart';

class HomeFeaturedServicesSection extends StatelessWidget {
  const HomeFeaturedServicesSection({
    super.key,
    required this.featuredImages,
    required this.services,
  });

  final List<String> featuredImages;
  final List<HomeServiceItem> services;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dịch vụ nổi bật',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: Color(0xFFB8860B),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: featuredImages.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Center(
              child: Image.asset(featuredImages[index], fit: BoxFit.contain),
            );
          },
        ),
        const SizedBox(height: 30),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: services.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            return _ServiceItemCard(service: services[index]);
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _ServiceItemCard extends StatelessWidget {
  const _ServiceItemCard({required this.service});

  final HomeServiceItem service;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 183,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              service.imagePath,
              width: 183,
              height: 184,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            service.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${service.price}đ',
                style: const TextStyle(
                  color: Color(0xFFC28710),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Đã đặt ${service.sold}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFBEBEBE),
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

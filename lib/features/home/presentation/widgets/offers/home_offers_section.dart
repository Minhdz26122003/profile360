import 'package:democart/features/home/domain/entities/home_offer_item.dart';
import 'package:democart/features/home/presentation/widgets/offers/offer_card.dart';
import 'package:flutter/material.dart';

class HomeOffersSection extends StatelessWidget {
  const HomeOffersSection({super.key, required this.offers});

  final List<HomeOfferItem> offers;

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
                'Ưu đãi độc quyền',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  'Xem tất cả',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 176,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: offers.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = offers[index];
              return OfferCard(image: item.imagePath, title: item.title);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

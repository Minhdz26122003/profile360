import 'package:democart/features/home/domain/entities/home_news_item.dart';
import 'package:democart/features/home/presentation/widgets/news/new_card.dart';
import 'package:flutter/material.dart';

class HomeNewsSection extends StatelessWidget {
  const HomeNewsSection({super.key, required this.news});

  final List<HomeNewsItem> news;

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
                'Tin tức mới nhất',
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
            itemCount: news.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = news[index];
              return NewCard(image: item.imagePath, title: item.title);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

import 'package:democart/features/home/domain/entities/home_banner_item.dart';
import 'package:flutter/material.dart';

class HomeBannerSection extends StatefulWidget {
  const HomeBannerSection({super.key, required this.banners});

  final List<HomeBannerItem> banners;

  @override
  State<HomeBannerSection> createState() => _HomeBannerSectionState();
}

class _HomeBannerSectionState extends State<HomeBannerSection> {
  late final PageController _pageController;
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return SizedBox(
      height: statusBarHeight + 280,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: statusBarHeight + 150,
            child: Image.asset(
              'asset/images/Banner_background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 382 / 260,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: widget.banners.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentBannerIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          widget.banners[index].imagePath,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.banners.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentBannerIndex == index
                            ? const Color(0xFFD19A3C)
                            : const Color(0xFFE3E3E3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

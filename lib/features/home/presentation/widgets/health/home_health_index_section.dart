import 'package:democart/features/home/domain/entities/home_health_metric.dart';
import 'package:democart/features/home/presentation/widgets/health/heal_metric_card.dart';
import 'package:flutter/material.dart';

class HomeHealthIndexSection extends StatelessWidget {
  const HomeHealthIndexSection({super.key, required this.metrics});

  final List<HomeHealthMetric> metrics;

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
                'Chỉ số sức khỏe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: metrics.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 119 / 139,
            ),
            itemBuilder: (context, index) {
              final metric = metrics[index];
              return HealthMetricCard(
                label: metric.label,
                icon: metric.icon,
                value: metric.value,
              );
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

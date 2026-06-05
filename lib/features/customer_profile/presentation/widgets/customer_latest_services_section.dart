import 'package:democart/base/widgets/service_chip.dart';
import 'package:democart/features/customer_profile/domain/entities/customer_service_model.dart';
import 'package:flutter/material.dart';

class CustomerLatestServicesSection extends StatelessWidget {
  const CustomerLatestServicesSection({super.key, required this.services});

  final CustomerServiceModel services;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A7FE0).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.medical_services_outlined,
                  size: 18,
                  color: Color(0xFF4A7FE0),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Dịch vụ gần nhất',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: services.services
                .map((service) => ServiceChip(label: service))
                .toList(),
          ),
        ],
      ),
    );
  }
}

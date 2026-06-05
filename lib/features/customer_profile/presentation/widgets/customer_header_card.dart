import 'package:democart/features/customer_profile/domain/entities/customer_profile_model.dart';
import 'package:flutter/material.dart';

class CustomerHeaderCard extends StatelessWidget {
  const CustomerHeaderCard({super.key, required this.profile});

  final CustomerProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 250, 253, 255),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color.fromARGB(255, 230, 240, 245)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(avatarUrl: profile.avatarUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            profile.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A2E),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _StatusBadge(status: profile.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mã KH: ${profile.code}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8A8A9A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoItem(
                  icon: Icons.phone_outlined,
                  label: 'SĐT',
                  value: profile.phone,
                ),
              ),
              Expanded(
                child: _InfoItem(
                  icon: Icons.transgender_outlined,
                  label: 'Giới tính',
                  value: profile.gender,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _InfoItem(
                  icon: Icons.calendar_today_outlined,
                  label: 'Năm sinh',
                  value: profile.birthYear,
                ),
              ),
              Expanded(
                child: _InfoItem(
                  icon: Icons.people_outline,
                  label: 'Trạng thái KH',
                  value: profile.status,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _InfoItem(
            icon: Icons.location_on_outlined,
            label: 'Khu vực',
            value: profile.region,
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: const BoxDecoration(
        color: Color(0xFFDDE8FF),
        shape: BoxShape.circle,
      ),
      child: avatarUrl != null
          ? ClipOval(child: Image.network(avatarUrl!, fit: BoxFit.cover))
          : const Icon(Icons.person, size: 32, color: Color(0xFF4A7FE0)),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  Color get _bg {
    switch (status.toLowerCase()) {
      case 'new':
        return const Color(0xFFE8F0FF);
      case 'vip':
        return const Color(0xFFFFF3CD);
      default:
        return const Color(0xFFE8F0FF);
    }
  }

  Color get _fg {
    switch (status.toLowerCase()) {
      case 'new':
        return const Color(0xFF4A7FE0);
      case 'vip':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF4A7FE0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _fg),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Icon(
            icon,
            size: 20,
            color: const Color.fromARGB(255, 101, 165, 238),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF8A8A9A)),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

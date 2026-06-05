import 'package:flutter/material.dart';

class HomeSectionDivider extends StatelessWidget {
  const HomeSectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Divider(height: 1, color: Color(0xFFEEEEEE)),
    );
  }
}

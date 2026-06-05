import 'package:democart/features/customer_profile/presentation/pages/customer_profile_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String customerProfile = '/customer-profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case customerProfile:
      default:
        return MaterialPageRoute<void>(
          builder: (_) => const CustomerProfileScreen(),
          settings: settings,
        );
    }
  }
}

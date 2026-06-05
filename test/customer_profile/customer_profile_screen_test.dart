import 'package:democart/features/customer_profile/presentation/pages/customer_profile_screen.dart';
import 'package:democart/features/customer_profile/presentation/widgets/customer_header_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'builds customer profile with nested scroll header and tab content',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: CustomerProfileScreen()),
      );

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));

      expect(find.byType(NestedScrollView), findsOneWidget);
      expect(find.byType(CustomerHeaderCard), findsOneWidget);
      expect(find.byType(TabBarView), findsOneWidget);
    },
  );
}

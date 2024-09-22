// ignore_for_file: prefer_const_constructors

import 'package:app_financas/presentation/modules/about/about.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AboutPage', () {
    group('route', () {
      test('is routable', () {
        expect(AboutAppPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders AboutView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AboutAppPage()));
      expect(find.byType(AboutAppView), findsOneWidget);
    });
  });
}

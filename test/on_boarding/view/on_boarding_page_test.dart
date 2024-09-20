// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/on_boarding/on_boarding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnBoardingPage', () {
    group('route', () {
      test('is routable', () {
        expect(OnBoardingPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders OnBoardingView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: OnBoardingPage()));
      expect(find.byType(OnBoardingView), findsOneWidget);
    });
  });
}

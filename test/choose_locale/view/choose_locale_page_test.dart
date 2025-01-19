// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/choose_locale/choose_locale.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChooseLocalePage', () {
    group('route', () {
      test('is routable', () {
        expect(ChooseLocalePage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders ChooseLocaleView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ChooseLocalePage()));
      expect(find.byType(ChooseLocaleView), findsOneWidget);
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/select_language/select_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SelectLanguagePage', () {
    group('route', () {
      test('is routable', () {
        expect(SelectLanguagePage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders SelectLanguageView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: SelectLanguagePage()));
      expect(find.byType(SelectLanguageView), findsOneWidget);
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/create_objectivo/create_objectivo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreateObjectivoPage', () {
    group('route', () {
      test('is routable', () {
        expect(CreateObjectivoPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders CreateObjectivoView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: CreateObjectivoPage()));
      expect(find.byType(CreateObjectivoView), findsOneWidget);
    });
  });
}

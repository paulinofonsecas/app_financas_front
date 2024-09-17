// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/objectivos/objectivos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObjectivosPage', () {
    group('route', () {
      test('is routable', () {
        expect(ObjectivosPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders ObjectivosView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ObjectivosPage()));
      expect(find.byType(ObjectivosView), findsOneWidget);
    });
  });
}

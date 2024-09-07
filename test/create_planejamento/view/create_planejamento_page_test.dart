// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/create_planejamento/create_planejamento.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreatePlanejamentoPage', () {
    group('route', () {
      test('is routable', () {
        expect(CreatePlanejamentoPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders CreatePlanejamentoView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: CreatePlanejamentoPage()));
      expect(find.byType(CreatePlanejamentoView), findsOneWidget);
    });
  });
}

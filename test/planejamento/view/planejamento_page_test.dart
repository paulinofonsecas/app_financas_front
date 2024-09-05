// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/planejamento/planejamento.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlanejamentoPage', () {
    group('route', () {
      test('is routable', () {
        expect(PlanejamentoPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders PlanejamentoView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: PlanejamentoPage()));
      expect(find.byType(PlanejamentoView), findsOneWidget);
    });
  });
}

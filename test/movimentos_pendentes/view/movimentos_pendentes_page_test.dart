// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/movimentos_pendentes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovimentosPendentesPage', () {
    group('route', () {
      test('is routable', () {
        expect(MovimentosPendentesAbba.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders MovimentosPendentesView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: MovimentosPendentesAbba()));
      expect(find.byType(MovimentosPendentesView), findsOneWidget);
    });
  });
}

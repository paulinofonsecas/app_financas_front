// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/mais_funcionalidades/mais_funcionalidades.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MaisFuncionalidadesPage', () {
    group('route', () {
      test('is routable', () {
        expect(MaisFuncionalidadesPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders MaisFuncionalidadesView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: MaisFuncionalidadesPage()));
      expect(find.byType(MaisFuncionalidadesView), findsOneWidget);
    });
  });
}

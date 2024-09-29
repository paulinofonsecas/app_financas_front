// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/criar_sub_categoria.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CriarSubCategoriaPage', () {
    group('route', () {
      test('is routable', () {
        expect(CriarSubCategoriaPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders CriarSubCategoriaView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: CriarSubCategoriaPage()));
      expect(find.byType(CriarSubCategoriaView), findsOneWidget);
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/conta/widgets/conta.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContaPage', () {
    group('route', () {
      test('is routable', () {
        expect(ContaPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders ContaView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ContaPage()));
      expect(find.byType(ContaView), findsOneWidget);
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/planejamento/planejamento.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PlanejamentoBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => PlanejamentoBloc(),
          child: MaterialApp(home: PlanejamentoBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

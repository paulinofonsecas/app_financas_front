// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/movimentos_pendentes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovimentosPendentesBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => MovimentosPendentesBloc(),
          child: MaterialApp(home: MovimentosPendentesBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

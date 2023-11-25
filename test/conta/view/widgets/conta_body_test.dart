// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/conta/conta.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContaBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => ContaBloc(),
          child: MaterialApp(home: ContaBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

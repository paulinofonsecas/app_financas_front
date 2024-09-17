// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/objectivos/objectivos.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObjectivosBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => ObjectivosBloc(),
          child: MaterialApp(home: ObjectivosBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

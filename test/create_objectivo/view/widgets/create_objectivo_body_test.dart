// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/create_objectivo/create_objectivo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CreateObjectivoBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => CreateObjectivoBloc(),
          child: MaterialApp(home: CreateObjectivoBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

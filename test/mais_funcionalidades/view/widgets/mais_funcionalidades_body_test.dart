// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/mais_funcionalidades/mais_funcionalidades.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MaisFuncionalidadesBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => MaisFuncionalidadesCubit(),
          child: MaterialApp(home: MaisFuncionalidadesBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

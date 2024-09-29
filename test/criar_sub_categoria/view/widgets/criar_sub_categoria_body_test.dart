// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/criar_sub_categoria.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CriarSubCategoriaBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => CriarSubCategoriaCubit(),
          child: MaterialApp(home: CriarSubCategoriaBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

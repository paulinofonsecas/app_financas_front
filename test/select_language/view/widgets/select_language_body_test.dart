// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/select_language/select_language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SelectLanguageBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => SelectLanguageCubit(),
          child: MaterialApp(home: SelectLanguageBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/on_boarding/on_boarding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnBoardingBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => OnBoardingCubit(),
          child: MaterialApp(home: OnBoardingBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

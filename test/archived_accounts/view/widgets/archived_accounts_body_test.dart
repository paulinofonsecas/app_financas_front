// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/archived_accounts/archived_accounts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArchivedAccountsBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => ArchivedAccountsBloc(),
          child: MaterialApp(home: ArchivedAccountsBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}

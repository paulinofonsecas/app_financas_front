// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/archived_accounts/archived_accounts.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ArchivedAccountsPage', () {
    group('route', () {
      test('is routable', () {
        expect(ArchivedAccountsPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders ArchivedAccountsView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ArchivedAccountsPage()));
      expect(find.byType(ArchivedAccountsView), findsOneWidget);
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/archived_accounts/bloc/bloc.dart';

void main() {
  group('ArchivedAccountsEvent', () {
    group('CustomArchivedAccountsEvent', () {
      test('supports value equality', () {
        expect(
          LoadArchivedAccountsEvent(),
          equals(const LoadArchivedAccountsEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(const LoadArchivedAccountsEvent(), isNotNull);
      });
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/archived_accounts/bloc/bloc.dart';

void main() {
  group('ArchivedAccountsState', () {
    test('supports value equality', () {
      expect(
        ArchivedAccountsState(),
        equals(
          const ArchivedAccountsState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const ArchivedAccountsState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const archivedAccountsState = ArchivedAccountsState(
            customProperty: 'My property',
          );
          expect(
            archivedAccountsState.copyWith(),
            equals(archivedAccountsState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const archivedAccountsState = ArchivedAccountsState(
            customProperty: 'My property',
          );
          final otherArchivedAccountsState = ArchivedAccountsState(
            customProperty: 'My property 2',
          );
          expect(archivedAccountsState, isNot(equals(otherArchivedAccountsState)));

          expect(
            archivedAccountsState.copyWith(
              customProperty: otherArchivedAccountsState.customProperty,
            ),
            equals(otherArchivedAccountsState),
          );
        },
      );
    });
  });
}

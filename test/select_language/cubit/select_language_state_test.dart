// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/select_language/cubit/cubit.dart';

void main() {
  group('SelectLanguageState', () {
    test('supports value equality', () {
      expect(
        SelectLanguageState(),
        equals(
          const SelectLanguageState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const SelectLanguageState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const selectLanguageState = SelectLanguageState(
            customProperty: 'My property',
          );
          expect(
            selectLanguageState.copyWith(),
            equals(selectLanguageState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const selectLanguageState = SelectLanguageState(
            customProperty: 'My property',
          );
          final otherSelectLanguageState = SelectLanguageState(
            customProperty: 'My property 2',
          );
          expect(selectLanguageState, isNot(equals(otherSelectLanguageState)));

          expect(
            selectLanguageState.copyWith(
              customProperty: otherSelectLanguageState.customProperty,
            ),
            equals(otherSelectLanguageState),
          );
        },
      );
    });
  });
}

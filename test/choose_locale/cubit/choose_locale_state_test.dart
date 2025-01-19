// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/choose_locale/cubit/cubit.dart';

void main() {
  group('ChooseLocaleState', () {
    test('supports value equality', () {
      expect(
        ChooseLocaleState(),
        equals(
          const ChooseLocaleState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const ChooseLocaleState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const chooseLocaleState = ChooseLocaleState(
            customProperty: 'My property',
          );
          expect(
            chooseLocaleState.copyWith(),
            equals(chooseLocaleState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const chooseLocaleState = ChooseLocaleState(
            customProperty: 'My property',
          );
          final otherChooseLocaleState = ChooseLocaleState(
            customProperty: 'My property 2',
          );
          expect(chooseLocaleState, isNot(equals(otherChooseLocaleState)));

          expect(
            chooseLocaleState.copyWith(
              customProperty: otherChooseLocaleState.customProperty,
            ),
            equals(otherChooseLocaleState),
          );
        },
      );
    });
  });
}

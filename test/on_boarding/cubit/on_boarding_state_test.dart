// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/on_boarding/cubit/cubit.dart';

void main() {
  group('OnBoardingState', () {
    test('supports value equality', () {
      expect(
        OnBoardingState(),
        equals(
          const OnBoardingState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const OnBoardingState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const onBoardingState = OnBoardingState(
            customProperty: 'My property',
          );
          expect(
            onBoardingState.copyWith(),
            equals(onBoardingState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const onBoardingState = OnBoardingState(
            customProperty: 'My property',
          );
          final otherOnBoardingState = OnBoardingState(
            customProperty: 'My property 2',
          );
          expect(onBoardingState, isNot(equals(otherOnBoardingState)));

          expect(
            onBoardingState.copyWith(
              customProperty: otherOnBoardingState.customProperty,
            ),
            equals(otherOnBoardingState),
          );
        },
      );
    });
  });
}

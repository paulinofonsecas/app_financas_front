// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/about/cubit/cubit.dart';

void main() {
  group('AboutState', () {
    test('supports value equality', () {
      expect(
        AboutState(),
        equals(
          const AboutState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AboutState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const aboutState = AboutState(
            customProperty: 'My property',
          );
          expect(
            aboutState.copyWith(),
            equals(aboutState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const aboutState = AboutState(
            customProperty: 'My property',
          );
          final otherAboutState = AboutState(
            customProperty: 'My property 2',
          );
          expect(aboutState, isNot(equals(otherAboutState)));

          expect(
            aboutState.copyWith(
              customProperty: otherAboutState.customProperty,
            ),
            equals(otherAboutState),
          );
        },
      );
    });
  });
}

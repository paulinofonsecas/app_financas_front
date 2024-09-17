// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/objectivos/bloc/bloc.dart';

void main() {
  group('ObjectivosState', () {
    test('supports value equality', () {
      expect(
        ObjectivosState(),
        equals(
          const ObjectivosState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const ObjectivosState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const objectivosState = ObjectivosState(
            customProperty: 'My property',
          );
          expect(
            objectivosState.copyWith(),
            equals(objectivosState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const objectivosState = ObjectivosState(
            customProperty: 'My property',
          );
          final otherObjectivosState = ObjectivosState(
            customProperty: 'My property 2',
          );
          expect(objectivosState, isNot(equals(otherObjectivosState)));

          expect(
            objectivosState.copyWith(
              customProperty: otherObjectivosState.customProperty,
            ),
            equals(otherObjectivosState),
          );
        },
      );
    });
  });
}

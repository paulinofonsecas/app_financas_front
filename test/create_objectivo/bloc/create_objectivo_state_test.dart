// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/bloc.dart';

void main() {
  group('CreateObjectivoState', () {
    test('supports value equality', () {
      expect(
        CreateObjectivoState(),
        equals(
          const CreateObjectivoState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CreateObjectivoState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const createObjectivoState = CreateObjectivoState(
            customProperty: 'My property',
          );
          expect(
            createObjectivoState.copyWith(),
            equals(createObjectivoState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const createObjectivoState = CreateObjectivoState(
            customProperty: 'My property',
          );
          final otherCreateObjectivoState = CreateObjectivoState(
            customProperty: 'My property 2',
          );
          expect(createObjectivoState, isNot(equals(otherCreateObjectivoState)));

          expect(
            createObjectivoState.copyWith(
              customProperty: otherCreateObjectivoState.customProperty,
            ),
            equals(otherCreateObjectivoState),
          );
        },
      );
    });
  });
}

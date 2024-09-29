// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/cubit/cubit.dart';

void main() {
  group('CriarSubCategoriaState', () {
    test('supports value equality', () {
      expect(
        CriarSubCategoriaState(),
        equals(
          const CriarSubCategoriaState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CriarSubCategoriaState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const criarSubCategoriaState = CriarSubCategoriaState(
            customProperty: 'My property',
          );
          expect(
            criarSubCategoriaState.copyWith(),
            equals(criarSubCategoriaState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const criarSubCategoriaState = CriarSubCategoriaState(
            customProperty: 'My property',
          );
          final otherCriarSubCategoriaState = CriarSubCategoriaState(
            customProperty: 'My property 2',
          );
          expect(criarSubCategoriaState, isNot(equals(otherCriarSubCategoriaState)));

          expect(
            criarSubCategoriaState.copyWith(
              customProperty: otherCriarSubCategoriaState.customProperty,
            ),
            equals(otherCriarSubCategoriaState),
          );
        },
      );
    });
  });
}

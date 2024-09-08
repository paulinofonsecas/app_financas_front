// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/create_planejamento/bloc/bloc.dart';

void main() {
  group('CreatePlanejamentoState', () {
    test('supports value equality', () {
      expect(
        CreateNewPlanejamentoState(),
        equals(
          const CreateNewPlanejamentoState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CreateNewPlanejamentoState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const createPlanejamentoState = CreateNewPlanejamentoState(
            customProperty: 'My property',
          );
          expect(
            createPlanejamentoState.copyWith(),
            equals(createPlanejamentoState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const createPlanejamentoState = CreateNewPlanejamentoState(
            customProperty: 'My property',
          );
          final otherCreatePlanejamentoState = CreateNewPlanejamentoState(
            customProperty: 'My property 2',
          );
          expect(createPlanejamentoState,
              isNot(equals(otherCreatePlanejamentoState)));

          expect(
            createPlanejamentoState.copyWith(
              customProperty: otherCreatePlanejamentoState.customProperty,
            ),
            equals(otherCreatePlanejamentoState),
          );
        },
      );
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/planejamento/bloc/bloc.dart';

void main() {
  group('PlanejamentoState', () {
    test('supports value equality', () {
      expect(
        PlanejamentoState(),
        equals(
          const PlanejamentoState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const PlanejamentoState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const planejamentoState = PlanejamentoState(
            customProperty: 'My property',
          );
          expect(
            planejamentoState.copyWith(),
            equals(planejamentoState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const planejamentoState = PlanejamentoState(
            customProperty: 'My property',
          );
          final otherPlanejamentoState = PlanejamentoState(
            customProperty: 'My property 2',
          );
          expect(planejamentoState, isNot(equals(otherPlanejamentoState)));

          expect(
            planejamentoState.copyWith(
              customProperty: otherPlanejamentoState.customProperty,
            ),
            equals(otherPlanejamentoState),
          );
        },
      );
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/bloc/bloc.dart';

void main() {
  group('MovimentosPendentesState', () {
    test('supports value equality', () {
      expect(
        MovimentosPendentesState(),
        equals(
          const MovimentosPendentesState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const MovimentosPendentesState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const movimentosPendentesState = MovimentosPendentesState(
            customProperty: 'My property',
          );
          expect(
            movimentosPendentesState.copyWith(),
            equals(movimentosPendentesState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const movimentosPendentesState = MovimentosPendentesState(
            customProperty: 'My property',
          );
          final otherMovimentosPendentesState = MovimentosPendentesState(
            customProperty: 'My property 2',
          );
          expect(movimentosPendentesState, isNot(equals(otherMovimentosPendentesState)));

          expect(
            movimentosPendentesState.copyWith(
              customProperty: otherMovimentosPendentesState.customProperty,
            ),
            equals(otherMovimentosPendentesState),
          );
        },
      );
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/bloc/bloc.dart';

void main() {
  group('MovimentosPendentesBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          MovimentosPendentesBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final movimentosPendentesBloc = MovimentosPendentesBloc();
      expect(movimentosPendentesBloc.state.customProperty,
          equals('Default Value'));
    });

    blocTest<MovimentosPendentesBloc, MovimentosPendentesState>(
      'LoadMovimentosPendentesEvent emits nothing',
      build: MovimentosPendentesBloc.new,
      act: (bloc) => bloc.add(const LoadMovimentosPendentesEvent()),
      expect: () => <MovimentosPendentesState>[],
    );
  });
}

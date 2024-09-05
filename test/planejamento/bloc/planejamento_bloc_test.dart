// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/planejamento/bloc/bloc.dart';

void main() {
  group('PlanejamentoBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          PlanejamentoBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final planejamentoBloc = PlanejamentoBloc();
      expect(planejamentoBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<PlanejamentoBloc, PlanejamentoState>(
      'CustomPlanejamentoEvent emits nothing',
      build: PlanejamentoBloc.new,
      act: (bloc) => bloc.add(const CustomPlanejamentoEvent()),
      expect: () => <PlanejamentoState>[],
    );
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/create_planejamento/bloc/bloc.dart';

void main() {
  group('CreatePlanejamentoBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CreatePlanejamentoBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final createPlanejamentoBloc = CreatePlanejamentoBloc();
      expect(createPlanejamentoBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<CreatePlanejamentoBloc, CreatePlanejamentoState>(
      'CustomCreatePlanejamentoEvent emits nothing',
      build: CreatePlanejamentoBloc.new,
      act: (bloc) => bloc.add(const CustomCreatePlanejamentoEvent()),
      expect: () => <CreatePlanejamentoState>[],
    );
  });
}

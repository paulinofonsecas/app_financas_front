// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/mais_funcionalidades/cubit/cubit.dart';

void main() {
  group('MaisFuncionalidadesCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          MaisFuncionalidadesCubit(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final maisFuncionalidadesCubit = MaisFuncionalidadesCubit();
      expect(maisFuncionalidadesCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<MaisFuncionalidadesCubit, MaisFuncionalidadesState>(
      'yourCustomFunction emits nothing',
      build: MaisFuncionalidadesCubit.new,
      act: (cubit) => cubit.yourCustomFunction(),
      expect: () => <MaisFuncionalidadesState>[],
    );
  });
}

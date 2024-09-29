// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/cubit/cubit.dart';

void main() {
  group('CriarSubCategoriaCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CriarSubCategoriaCubit(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final criarSubCategoriaCubit = CriarSubCategoriaCubit();
      expect(criarSubCategoriaCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<CriarSubCategoriaCubit, CriarSubCategoriaState>(
      'yourCustomFunction emits nothing',
      build: CriarSubCategoriaCubit.new,
      act: (cubit) => cubit.yourCustomFunction(),
      expect: () => <CriarSubCategoriaState>[],
    );
  });
}

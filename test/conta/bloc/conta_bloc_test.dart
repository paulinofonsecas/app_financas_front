// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';

void main() {
  group('ContaBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ContaBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final contaBloc = ContaBloc();
      expect(contaBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<ContaBloc, ContaState>(
      'CustomContaEvent emits nothing',
      build: ContaBloc.new,
      act: (bloc) => bloc.add(const CustomContaEvent()),
      expect: () => <ContaState>[],
    );
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/bloc.dart';

void main() {
  group('CreateObjectivoBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CreateObjectivoBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final createObjectivoBloc = CreateObjectivoBloc();
      expect(createObjectivoBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<CreateObjectivoBloc, CreateObjectivoState>(
      'CustomCreateObjectivoEvent emits nothing',
      build: CreateObjectivoBloc.new,
      act: (bloc) => bloc.add(const CustomCreateObjectivoEvent()),
      expect: () => <CreateObjectivoState>[],
    );
  });
}

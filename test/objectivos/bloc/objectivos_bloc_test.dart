// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/objectivos/bloc/bloc.dart';

void main() {
  group('ObjectivosBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ObjectivosBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final objectivosBloc = ObjectivosBloc();
      expect(objectivosBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<ObjectivosBloc, ObjectivosState>(
      'CustomObjectivosEvent emits nothing',
      build: ObjectivosBloc.new,
      act: (bloc) => bloc.add(const CustomObjectivosEvent()),
      expect: () => <ObjectivosState>[],
    );
  });
}

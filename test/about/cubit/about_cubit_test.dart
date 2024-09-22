// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/about/cubit/cubit.dart';

void main() {
  group('AboutCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          AboutCubit(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final aboutCubit = AboutCubit();
      expect(aboutCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<AboutCubit, AboutState>(
      'yourCustomFunction emits nothing',
      build: AboutCubit.new,
      act: (cubit) => cubit.yourCustomFunction(),
      expect: () => <AboutState>[],
    );
  });
}

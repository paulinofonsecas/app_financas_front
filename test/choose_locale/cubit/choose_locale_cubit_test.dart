// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/choose_locale/cubit/cubit.dart';

void main() {
  group('ChooseLocaleCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ChooseLocaleCubit(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final chooseLocaleCubit = ChooseLocaleCubit();
      expect(chooseLocaleCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<ChooseLocaleCubit, ChooseLocaleState>(
      'yourCustomFunction emits nothing',
      build: ChooseLocaleCubit.new,
      act: (cubit) => cubit.yourCustomFunction(),
      expect: () => <ChooseLocaleState>[],
    );
  });
}

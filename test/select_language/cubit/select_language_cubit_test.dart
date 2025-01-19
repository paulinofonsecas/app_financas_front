// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/select_language/cubit/cubit.dart';

void main() {
  group('SelectLanguageCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          SelectLanguageCubit(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final selectLanguageCubit = SelectLanguageCubit();
      expect(selectLanguageCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<SelectLanguageCubit, SelectLanguageState>(
      'yourCustomFunction emits nothing',
      build: SelectLanguageCubit.new,
      act: (cubit) => cubit.yourCustomFunction(),
      expect: () => <SelectLanguageState>[],
    );
  });
}

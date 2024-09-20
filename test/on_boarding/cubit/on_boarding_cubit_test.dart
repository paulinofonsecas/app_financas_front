// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/on_boarding/cubit/cubit.dart';

void main() {
  group('OnBoardingCubit', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          OnBoardingCubit(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final onBoardingCubit = OnBoardingCubit();
      expect(onBoardingCubit.state.customProperty, equals('Default Value'));
    });

    blocTest<OnBoardingCubit, OnBoardingState>(
      'yourCustomFunction emits nothing',
      build: OnBoardingCubit.new,
      act: (cubit) => cubit.yourCustomFunction(),
      expect: () => <OnBoardingState>[],
    );
  });
}

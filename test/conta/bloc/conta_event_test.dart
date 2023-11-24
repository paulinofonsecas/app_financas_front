// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';

void main() {
  group('ContaEvent', () {  
    group('CustomContaEvent', () {
      test('supports value equality', () {
        expect(
          CustomContaEvent(),
          equals(const CustomContaEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomContaEvent(),
          isNotNull
        );
      });
    });
  });
}

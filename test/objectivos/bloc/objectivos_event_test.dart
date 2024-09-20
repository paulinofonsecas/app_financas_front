// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/objectivos/bloc/bloc.dart';

void main() {
  group('ObjectivosEvent', () {  
    group('CustomObjectivosEvent', () {
      test('supports value equality', () {
        expect(
          CustomObjectivosEvent(),
          equals(const CustomObjectivosEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomObjectivosEvent(),
          isNotNull
        );
      });
    });
  });
}

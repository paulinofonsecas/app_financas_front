// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/create_planejamento/bloc/bloc.dart';

void main() {
  group('CreatePlanejamentoEvent', () {  
    group('CustomCreatePlanejamentoEvent', () {
      test('supports value equality', () {
        expect(
          CustomCreatePlanejamentoEvent(),
          equals(const CustomCreatePlanejamentoEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomCreatePlanejamentoEvent(),
          isNotNull
        );
      });
    });
  });
}

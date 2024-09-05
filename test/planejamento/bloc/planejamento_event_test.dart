// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/planejamento/bloc/bloc.dart';

void main() {
  group('PlanejamentoEvent', () {  
    group('CustomPlanejamentoEvent', () {
      test('supports value equality', () {
        expect(
          CustomPlanejamentoEvent(),
          equals(const CustomPlanejamentoEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomPlanejamentoEvent(),
          isNotNull
        );
      });
    });
  });
}

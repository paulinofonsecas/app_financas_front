// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/bloc/bloc.dart';

void main() {
  group('MovimentosPendentesEvent', () {
    group('CustomMovimentosPendentesEvent', () {
      test('supports value equality', () {
        expect(
          LoadMovimentosPendentesEvent(),
          equals(const LoadMovimentosPendentesEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(const LoadMovimentosPendentesEvent(), isNotNull);
      });
    });
  });
}

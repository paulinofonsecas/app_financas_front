// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/bloc.dart';

void main() {
  group('CreateObjectivoEvent', () {  
    group('CustomCreateObjectivoEvent', () {
      test('supports value equality', () {
        expect(
          CustomCreateObjectivoEvent(),
          equals(const CustomCreateObjectivoEvent()),
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const CustomCreateObjectivoEvent(),
          isNotNull
        );
      });
    });
  });
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/mais_funcionalidades/cubit/cubit.dart';

void main() {
  group('MaisFuncionalidadesState', () {
    test('supports value equality', () {
      expect(
        MaisFuncionalidadesState(),
        equals(
          const MaisFuncionalidadesState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const MaisFuncionalidadesState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const maisFuncionalidadesState = MaisFuncionalidadesState(
            customProperty: 'My property',
          );
          expect(
            maisFuncionalidadesState.copyWith(),
            equals(maisFuncionalidadesState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const maisFuncionalidadesState = MaisFuncionalidadesState(
            customProperty: 'My property',
          );
          final otherMaisFuncionalidadesState = MaisFuncionalidadesState(
            customProperty: 'My property 2',
          );
          expect(maisFuncionalidadesState, isNot(equals(otherMaisFuncionalidadesState)));

          expect(
            maisFuncionalidadesState.copyWith(
              customProperty: otherMaisFuncionalidadesState.customProperty,
            ),
            equals(otherMaisFuncionalidadesState),
          );
        },
      );
    });
  });
}

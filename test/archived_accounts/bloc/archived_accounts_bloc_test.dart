// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_financas/presentation/modules/archived_accounts/bloc/bloc.dart';

void main() {
  group('ArchivedAccountsBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          ArchivedAccountsBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final archivedAccountsBloc = ArchivedAccountsBloc();
      expect(
          archivedAccountsBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<ArchivedAccountsBloc, ArchivedAccountsState>(
      'CustomArchivedAccountsEvent emits nothing',
      build: ArchivedAccountsBloc.new,
      act: (bloc) => bloc.add(const LoadArchivedAccountsEvent()),
      expect: () => <ArchivedAccountsState>[],
    );
  });
}

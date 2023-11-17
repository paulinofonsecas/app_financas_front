import 'package:app_financas/app/bloc/bloc/app_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App Bloc', () {
    late AppBloc appBloc;

    setUp(() {
      appBloc = AppBloc();
    });

    tearDown(() {
      appBloc.close();
    });

    test('can be instantiated', () {
      expect(appBloc, isNotNull);
    });

    test('initial state is AppInitial', () {
      expect(appBloc.state, AppInitial());
      expect(appBloc.state.bottomNavIndex, 0);
    });

    blocTest<AppBloc, AppState>(
      'emits AppBottomNavChanged when ChangeAppBottomNavEvent is added.',
      build: () => appBloc,
      act: (bloc) => bloc.add(ChangeAppBottomNavEvent(2)),
      expect: () => const <AppState>[AppBottomNavChanged(2)],
    );
  });
}

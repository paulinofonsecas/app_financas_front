import 'package:app_financas/presentation/bloc/movimento/movimento_bloc.dart';
import 'package:app_financas/core/data/services/movimento_service.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:mockito/mockito.dart';

class MockMovimentoService extends Mock implements MovimentoService {}

void main() {
  group('Movimento Bloc', () {
    late MovimentoBloc movimentoBloc;
    var mockMovimentoService = MockMovimentoService();

    setUp(() {
      movimentoBloc = MovimentoBloc(mockMovimentoService);
    });

    tearDown(() {
      movimentoBloc.close();
    });

    test('can be instantiated', () {
      expect(movimentoBloc, isNotNull);
    });

    test('initial state is MovimentoInitial', () {
      expect(movimentoBloc.state, MovimentoInitial());
    });

    blocTest<MovimentoBloc, MovimentoState>(
      'emits MovimentoGetLastPaginatedListSuccess'
      ' when MovimentoGetPaginatedListEvent is added.',
      build: () => movimentoBloc,
      act: (bloc) {
        when(() => bloc.movimentoService.listPaginatedMovimentos(1, 10))
            .thenAnswer(((_) async => Right([movimento])));

        bloc.add(const MovimentoGetPaginatedListEvent(1, 10));
      },
      expect: () => [
        MovimentoGetLastPaginatedListSuccess(<Movimento>[movimento])
      ],
    );

    var listResult = List.generate(15, (index) => movimento);

    blocTest<MovimentoBloc, MovimentoState>(
      'emits MovimentoGetPaginatedListSuccess'
      ' when MovimentoGetPaginatedListEvent is added.',
      build: () => movimentoBloc,
      act: (bloc) {
        when(() => bloc.movimentoService.listPaginatedMovimentos(1, 10))
            .thenAnswer(((_) async => Right(listResult)));

        bloc.add(const MovimentoGetPaginatedListEvent(1, 10));
      },
      expect: () => [MovimentoGetPaginatedListSuccess(listResult, 2)],
    );

    blocTest<MovimentoBloc, MovimentoState>(
      'emits MovimentoGetPaginatedListError'
      ' when MovimentoGetPaginatedListEvent is added.',
      build: () => movimentoBloc,
      act: (bloc) {
        when(() => bloc.movimentoService.listPaginatedMovimentos(1, 10))
            .thenAnswer(
                ((_) async => Left(Failure('erro ao buscar os movimentos'))));

        bloc.add(const MovimentoGetPaginatedListEvent(1, 10));
      },
      expect: () => [
        const MovimentoGetPaginatedListError(
          'Erro ao buscar movimentos',
        )
      ],
    );
  });
}

Movimento movimento = Movimento(
  id: 1,
  userId: 1,
  cartaoId: 1,
  tipoMovimentoId: 1,
  data: DateTime.now(),
  valor: 100,
  obsMovimento: 'teste',
  descricao: 'teste',
  categoriaMovimentoId: 1,
  confirmado: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

import 'package:app_financas/score/data/provider/interfaces/i_planejamento_provider.dart';
import 'package:app_financas/score/domain/entitys/planejamento.dart';
import 'package:app_financas/score/domain/services/i_planejamento_service.dart';
import 'package:app_financas/score/erros/failure.dart';
import 'package:dartz/dartz.dart';

class PlanejamentoService implements IPlanejamentoService {
  final IPlanejamentoProvider _provider;

  PlanejamentoService({required IPlanejamentoProvider provider})
      : _provider = provider;

  @override
  Future<Either<Failure, Planejamento>> createPlanejamento(
      Planejamento planejamento) async {
    try {
      return _provider.createPlanejamento(planejamento);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Planejamento>> getPlanejamento(
      String planejamentoId) async {
    try {
      return _provider.getPlanejamento(planejamentoId);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Planejamento>> getPlanejamentoOn(DateTime date) async {
    try {
      final planejamento =
          await _provider.getAllPlanejamentos(dataReferencia: date);

      if (planejamento.isRight()) {
        final planejamentoList = planejamento.getOrElse(() => []);

        try {
          final p = planejamentoList.firstWhere((planejamento) {
            return planejamento.dataReferencia.month == date.month &&
                planejamento.dataReferencia.year == date.year;
          });
          return Right(p);
        } catch (e) {
          return Left(
            planejamento.swap().getOrElse(
                  () => NaoExistePlanejamentoAtual(
                    'Planejamento inexistente.',
                  ),
                ),
          );
        }
      } else {
        return Left(
          planejamento.swap().getOrElse(
              () => Failure('Ocorreu um erro ao buscar o planejamento.')),
        );
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Planejamento>> getPlanejamentoAtual() async {
    try {
      final planejamento = await _provider.getAllPlanejamentos();

      if (planejamento.isRight()) {
        final date = DateTime.now();
        final planejamentoList = planejamento.getOrElse(() => []);

        if (planejamentoList.isEmpty) {
          return Left(
              NaoExistePlanejamentoAtual('Nenhum planejamento encontrado.'));
        }

        // retorna um planejamento com base o mes e ano informado
        return Right(planejamentoList.firstWhere(
          (planejamento) {
            return planejamento.dataReferencia.month == date.month &&
                planejamento.dataReferencia.year == date.year;
          },
        ));
      } else {
        return Left(planejamento.swap().getOrElse(
            () => Failure('Ocorreu um erro ao buscar o planejamento atual.')));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Planejamento>>> listPlanejamentos() async {
    try {
      return _provider.getAllPlanejamentos();
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlanejamento(
      String planejamentoId) async {
    try {
      return _provider.deletePlanejamento(planejamentoId);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Planejamento>> updatePlanejamento(
      Planejamento planejamento) async {
    try {
      return _provider.updatePlanejamento(planejamento);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePlanejamentoAtual() async {
    final planejamento = await getPlanejamentoAtual();
    return planejamento.fold(
      (l) => Future.value(Left(l)),
      (r) => deletePlanejamento(r.id),
    );
  }
}

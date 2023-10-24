import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entitys/movimento.dart';
import '../provider/interfaces/i_movimento_provider.dart';

class MovimentoService implements IMovimentoService {
  final IMovimentoProvider provider;

  MovimentoService({required this.provider});

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() {
    return provider.listMovimentos();
  }

  @override
  Future<Either<Failure, Movimento>> saveMovimento(Movimento movimento) {
    return provider.saveMovimento(movimento);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentosAt(DateTime date) {
    return provider.listMovimentosAt(date);
  }

  @override
  Future<Either<Failure, bool>> editMovimento(Movimento movimento) {
    return provider.editMovimento(movimento);
  }

  @override
  Future<Either<Failure, Movimento>> getMovimento(int id) {
    return provider.getMovimento(id);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedMovimentos(
    int page,
    int pageSize,
  ) {
    return provider.listPaginatedMovimentos(page, pageSize);
  }
}

import 'package:app_financas/core/domain/entitys/sertup_configuration.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../domain/entitys/movimento.dart';
import '../provider/interfaces/i_movimento_provider.dart';

class MovimentoService implements IMovimentoService {
  final IMovimentoProvider provider;
  bool isLocal = false;

  MovimentoService({required this.provider}) {
    var sc = Get.find<SetupConfiguration>();
    isLocal = sc.isLocal;
  }

  @override
  Future<Either<Failure, List<Movimento>>> listMovimentos() {
    return provider.listMovimentos();
  }

  @override
  Future<Either<Failure, bool>> saveMovimento(Movimento movimento) {
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
    if (isLocal) {
      return _getLocalPaginatedMovimentos(page, pageSize);
    } else {
      return provider.listPaginatedMovimentos(page, pageSize);
    }
  }

  Future<Either<Failure, List<Movimento>>> _getLocalPaginatedMovimentos(
    int page,
    int pageSize,
  ) {
    return provider.listMovimentos().then((value) {
      if (value.isLeft()) {
        return const Right([]);
      } else {
        var list = value.getOrElse(() => [])
          ..sort((a, b) => a.data.compareTo(b.data));
        list = list.reversed.toList();

        var result = paginatedList(list, page, pageSize);
        return Right(result);
      }
    });
  }

  List<Movimento> paginatedList(List<Movimento> list, int page,
      [int pageSize = 10]) {
    if (page == 1) {
      return list.take(pageSize).toList();
    } else {
      return list.skip(pageSize * page).take(pageSize).toList();
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMovimento(int id) {
    return provider.deleteMovimento(id);
  }

  @override
  Future<Either<Failure, List<Movimento>>> listPaginatedContaMovimentos(
      int contaId, int page, int pageSize) async {
    var result = await listPaginatedMovimentos(page, pageSize);

    if (result.isRight()) {
      var list = result.getOrElse(() => []);
      list = list.where((element) => element.cartaoId == contaId).toList();
      return Right(list);
    } else {
      return result;
    }
  }
}

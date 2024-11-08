import 'package:app_financas/core/error/failure.dart';
import 'package:app_financas/domain/entities/conta.dart';
import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/domain/usecases/i_conta_usecase.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';

import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContaDetailsPageController extends GetxController {
  late final PagingController<int, Movimento> pagingController;
  late final IMovimentoUseCases movimentoService;
  late final IContaUseCases contaService;
  late Conta conta;
  int esFilter = 0;
  var page = 1;
  var pageSize = 10;

  ContaDetailsPageController({
    required this.conta,
  });

  @override
  void onInit() {
    contaService = getIt();
    movimentoService = getIt();
    pagingController = PagingController(firstPageKey: 1);

    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await getPaginatedContaMovimentos(pageKey);
      final isLastPage = newItems.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<Movimento>> getPaginatedContaMovimentos(
    int page,
  ) async {
    var result = await movimentoService.listPaginatedContaMovimentos(
        conta.id, page, pageSize);
    if (result is Right) {
      if (esFilter == 0) {
        return result.getOrElse(() => []);
      } else {
        return result
            .getOrElse(() => [])
            .where((element) => element.tipoMovimentoId == esFilter)
            .toList();
      }
    } else {
      throw result.swap().getOrElse(
            () => Failure(
              'Erro desconhecido no ' 'movimento screen controller',
            ),
          );
    }
  }

  void changeESFilter(int filter) {
    if (esFilter == filter) {
      return;
    }

    esFilter = filter;
    update(['geral']);
    pagingController.refresh();
  }

  void updateGeral() async {
    var result = await contaService.getConta(conta.id);

    if (result is Right) {
      conta = result.getOrElse(() => Conta.fake());
      pagingController.refresh();
      update(['geral']);
    } else {
      showErrorMessage('Error', 'Erro desconhecido ao atualizar a tela');
    }
  }
}

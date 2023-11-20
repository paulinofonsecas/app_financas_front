import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_conta_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ContaDetailsPageController extends GetxController {
  late final PagingController<int, Movimento> pagingController;
  late final IMovimentoService movimentoService;
  late final IContaService contaService;
  late Conta conta;
  int esFilter = 0;
  var page = 1;
  var pageSize = 10;

  ContaDetailsPageController({
    required this.conta,
  });

  @override
  void onInit() {
    contaService = Get.find();
    movimentoService = Get.find();
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

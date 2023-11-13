import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

class CategoriaAndTotal {
  final Categoria categoria;
  final double total;

  CategoriaAndTotal(this.categoria, this.total);
}

class EstatisticasPageController extends GetxController {
  late final IMovimentoService movimentoService;
  late final ICategoriaService categoriaService;
  List<Categoria> categorias = [];
  List<Movimento> movimentos = [];

  var esFilter = 2;
  var totalEntradas = 0.0;
  var totalSaidas = 0.0;

  @override
  void onInit() {
    movimentoService = Get.find();
    categoriaService = Get.find();
    super.onInit();
  }

  void changeESFilter(int filter) {
    if (esFilter == filter) {
      return;
    }

    esFilter = filter;
    update(['geral']);
  }

  Future<List<PieChartSectionData>?> getCategoriesChartData() async {
    categorias.clear();
    movimentos.clear();
    totalEntradas = 0.0;
    totalSaidas = 0.0;

    var categorias0 = await getCategories();
    var movimentos0 = await getMovimentos();

    var chartCategorias = <PieChartSectionData>[];

    if (categorias0 != null && movimentos0 != null) {
      var saida = <CategoriaAndTotal>[];

      for (var categoria in categorias0) {
        var total = 0.0;

        for (var movimento in movimentos0) {
          if (movimento.categoriaMovimentoId == categoria.id) {
            total += movimento.valor;
          }
        }

        if (total != 0) {
          saida.add(
            CategoriaAndTotal(categoria, total),
          );
        }

        if (esFilter == 1) {
          totalEntradas += total;
        } else if (esFilter == 2) {
          totalSaidas += total;
        }
      }

      saida.sort((a, b) => b.total.compareTo(a.total));

      for (var element in saida) {
        categorias.add(element.categoria);

        chartCategorias.add(
          PieChartSectionData(
            color: element.categoria.color,
            value: element.total,
            showTitle: false,
          ),
        );
      }

      return chartCategorias;
    } else {
      showErrorMessage('Erro', 'Ocorreu um erro ao processar as estatisticas');
      return null;
    }
  }

  Future<List<Movimento>?> getMovimentos() async {
    late Either<Failure, List<Movimento>> result;
    if (esFilter == 1) {
      result = await movimentoService.listMovimentosEntrada();
    } else if (esFilter == 2) {
      result = await movimentoService.listMovimentosSaida();
    }

    if (result is Right) {
      movimentos = result.getOrElse(() => []);

      return movimentos;
    } else {
      showErrorMessage('Erro', 'Erro ao buscar movimentos');
      return null;
    }
  }

  Future<List<Categoria>?> getCategories() async {
    late Either<Failure, List<Categoria>> result;

    if (esFilter == 1) {
      result = await categoriaService.listCategoriasEntradas();
    } else if (esFilter == 2) {
      result = await categoriaService.listCategoriasSaidas();
    }

    if (result is Right) {
      return result.getOrElse(() => []);
    } else {
      showErrorMessage('Erro', 'Erro ao buscar movimentos');
      return null;
    }
  }
}

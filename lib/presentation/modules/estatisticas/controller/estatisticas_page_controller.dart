import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/domain/services/i_categoria_service.dart';
import 'package:app_financas/core/domain/services/i_movimento_service.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:dartz/dartz.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import 'helpers/calculos_periodo_mixin.dart';
import 'helpers/helpers.dart';

class EstatisticasPageController extends GetxController
    with CalculoPeiriodoMixin {
  late final IMovimentoService movimentoService;
  late final ICategoriaService categoriaService;
  List<Categoria> categorias = [];
  List<Movimento> movimentos = [];
  var periodos = [
    'Dia',
    'Semana',
    'Mês',
    'Semestre',
    'Ano',
  ];

  var esFilter = 2;
  var totalEntradas = 0.0;
  var totalSaidas = 0.0;

  late int periodoId;
  var periodoMes = 1.obs;

  @override
  void onInit() {
    movimentoService = getIt();
    categoriaService = getIt();
    periodoMes.value = DateTime.now().month;

    periodoId = 1;
    super.onInit();
  }

  void changeESFilter(int filter) {
    if (esFilter == filter) {
      return;
    }

    esFilter = filter;
    update(['geral']);
  }

  String mygetMonthName(int month) {
    return getMonthName(month);
  }

  previousMonth() {
    if (periodoMes.value <= 1) {
      return;
    }
    periodoMes.value--;
    update(['geral']);
  }

  nextMonth() {
    if (periodoMes.value >= 12) {
      return;
    }
    periodoMes.value++;
    update(['geral']);
  }

  Future<List<PieChartSectionData>?> getCategoriesChartData() async {
    var chartCategorias = <PieChartSectionData>[];
    var movimentos = await getCategoriasPorPeriodo();

    for (var element in movimentos) {
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
  }

  Future<List<FlSpot>?> getMovimentosSpots() async {
    var chartCategorias = <FlSpot>[];
    var movimentos = await getMovimentos() ?? [];

    if (movimentos.isEmpty) {
      return null;
    }

    var movimentoAndDate = <MovimentoAndDate>[];

    if (periodoId == 0) {
      movimentoAndDate = calculateSumOfDay(
        movimentos,
        movimentoAndData: true,
      );
    } else if (periodoId == 1) {
      movimentoAndDate = calculateSumOfWeek(
        movimentos,
        movimentoAndData: true,
      );
    } else if (periodoId == 2) {
      movimentoAndDate = calculateSumOfMonth(
        movimentos,
        movimentoAndData: true,
      );
    } else if (periodoId == 3) {
      movimentoAndDate = calculateSumOfSemester(
        movimentos,
        movimentoAndData: true,
      );
    } else if (periodoId == 4) {
      movimentoAndDate = calculateSumOfYear(
        movimentos,
        movimentoAndData: true,
      );
    }

    for (var element in movimentoAndDate) {
      var x = 0;

      if (periodoId == 0) {
        x = element.dateTime.hour;
      } else if (periodoId == 1) {
        x = element.dateTime.weekday;
      } else if (periodoId == 2) {
        x = element.dateTime.day;
      } else if (periodoId == 3) {
        x = element.dateTime.month;
      } else if (periodoId == 4) {
        x = element.dateTime.month;
      }

      chartCategorias.add(
        FlSpot(
          x.toDouble(),
          element.total,
        ),
      );
    }
    chartCategorias.sort((a, b) => a.x.compareTo(b.x));
    return chartCategorias;
  }

  Future<List<CategoriaAndTotal>> getCategoriasPorPeriodo() async {
    categorias.clear();
    movimentos.clear();
    totalEntradas = 0.0;
    totalSaidas = 0.0;

    var categorias0 = await getCategories();
    var movimentos0 = await getMovimentos();
    var saida = <CategoriaAndTotal>[];

    if (categorias0 != null && movimentos0 != null) {
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
    }

    return saida;
  }

  Future<List<Movimento>?> getMovimentos() async {
    DateTime? date = DateTime(DateTime.now().year, periodoMes.value);

    if (periodoId == 3 || periodoId == 4) {
      date = null;
    }

    late Either<Failure, List<Movimento>> result;
    if (esFilter == 1) {
      result = await movimentoService.listMovimentosEntrada(
        date: date,
      );
    } else if (esFilter == 2) {
      result = await movimentoService.listMovimentosSaida(
        date: date,
      );
    }

    if (result is Right) {
      movimentos = result.getOrElse(() => []);

      if (periodoId == 0) {
        movimentos = calculateSumOfDay(movimentos);
      } else if (periodoId == 1) {
        movimentos = calculateSumOfWeek(movimentos);
      } else if (periodoId == 2) {
        movimentos = calculateSumOfMonth(movimentos);
      } else if (periodoId == 3) {
        movimentos = calculateSumOfSemester(movimentos);
      } else if (periodoId == 4) {
        movimentos = calculateSumOfYear(movimentos);
      }

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

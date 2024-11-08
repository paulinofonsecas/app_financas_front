import 'package:app_financas/domain/entities/tipo_movimento.dart';
import 'package:app_financas/domain/usecases/i_movimento_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'week_bar_chart_state.dart';

class WeekBarChartCubit extends Cubit<WeekBarChartState> {
  WeekBarChartCubit(this._movimentoService) : super(WeekBarChartInitial());

  final IMovimentoUseCases _movimentoService;

  void movimentosDeEntradaDaSemana() async {
    emit(WeekBarChartLoading());
    final result = await _movimentoService.listMovimentosDaSemana();

    result.fold(
      (l) => emit(const WeekBarChartError(
          message:
              'Ocorreu um erro ao carregar os movimentos de entrada da semana')),
      (r) {
        final movimentos =
            r.where((m) => m.tipoMovimentoId == TipoMovimento.ENTRADA).toList();

        final semana = <int, double>{
          0: 0,
          1: 0,
          2: 0,
          3: 0,
          4: 0,
          5: 0,
          6: 0,
        };
        for (var movimento in movimentos) {
          semana[movimento.data.weekday - 1] =
              semana[movimento.data.weekday - 1]! + movimento.valor;
        }

        emit(WeekBarChartSuccess(movimentos: semana));
      },
    );
  }

  void movimentosDeSaidaDaSemana() async {
    emit(WeekBarChartLoading());
    final result = await _movimentoService.listMovimentosDaSemana();

    result.fold(
      (l) => emit(const WeekBarChartError(
          message:
              'Ocorreu um erro ao carregar os movimentos de saida da semana')),
      (r) {
        final movimentos =
            r.where((m) => m.tipoMovimentoId == TipoMovimento.SAIDA).toList();

        final semana = <int, double>{0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0};
        for (var movimento in movimentos) {
          semana[movimento.data.weekday - 1] =
              semana[movimento.data.weekday - 1]! + movimento.valor;
        }

        emit(WeekBarChartSuccess(movimentos: semana));
      },
    );
  }
}

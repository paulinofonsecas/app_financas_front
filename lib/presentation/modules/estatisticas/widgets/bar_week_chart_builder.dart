import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:app_financas/presentation/modules/estatisticas/cubit/week_bar_chart_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/widgets/week_bar_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarWeekChartBuilder extends StatelessWidget {
  const BarWeekChartBuilder({super.key, required this.tipoMovimento});

  final int tipoMovimento;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WeekBarChartCubit>();

    return BlocBuilder<WeekBarChartCubit, WeekBarChartState>(
      bloc: tipoMovimento == TipoMovimento.SAIDA
          ? (cubit..movimentosDeSaidaDaSemana())
          : (cubit..movimentosDeEntradaDaSemana()),
      builder: (context, state) {
        if (state is WeekBarChartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is WeekBarChartError) {
          return Text(state.message);
        }

        if (state is WeekBarChartSuccess) {
          return WeekBarChartWidget(
            movimentos: state.movimentos,
          );
        }

        return const SizedBox();
      },
    );
  }
}

import 'package:app_financas/presentation/modules/estatisticas/cubit/filtro_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/cubit/select_tipo_movimente_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/widgets/bar_week_chart_builder.dart';
import 'package:app_financas/presentation/modules/estatisticas/widgets/filtro_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstatisticasBarWidget extends StatelessWidget {
  const EstatisticasBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FiltroCubit, FiltroState>(
      builder: (context, state) {
        if (state.filtro == FiltroSelectedType.semana) {
          return BarWeekChartBuilder(
            tipoMovimento:
                context.watch<SelectTipoMovimentoCubit>().state.filter,
          );
        }

        return const SizedBox();
      },
    );
  }
}

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/components/periodo_picker_widget.dart';
import 'package:app_financas/presentation/modules/estatisticas/controller/estatisticas_page_controller.dart';
import 'package:app_financas/presentation/modules/estatisticas/cubit/filtro_cubit.dart';
import 'package:app_financas/presentation/modules/estatisticas/graficos/estatistica_line_da_semana.dart';
import 'package:app_financas/presentation/modules/estatisticas/graficos/estatistica_por_categoria.dart';
import 'package:app_financas/presentation/modules/estatisticas/widgets/filtro_widget.dart';
import 'package:app_financas/presentation/modules/estatisticas/widgets/tipo_movimento_widget.dart';
import 'package:app_financas/presentation/modules/planejamento/planejamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EstatisticaBody extends StatelessWidget {
  const EstatisticaBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final EstatisticasPageController controller = Get.find();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gutter(),
              Text(
                'Estatisticas',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gutter(),
              Obx(
                () => PeriodoPickerWidget(
                  periodoMes:
                      controller.mygetMonthName(controller.periodoMes.value),
                  onLeftTap: controller.previousMonth,
                  onRightTap: controller.nextMonth,
                ),
              ),
              const Gutter(),
              const TipoMovimentosWidget(),
              const Gutter(),
              BlocListener<FiltroCubit, FiltroState>(
                listener: (context, state) {
                  if (state is FiltroChanged) {
                    controller.periodoId = state.filtro.id;
                    controller.update(['geral']);
                  }
                },
                child: const FiltrosWidget(),
              ),
              const Gutter(),
              const Divider(),
              const GutterLarge(),
              _BuildChartArea(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildChartArea extends StatelessWidget {
  const _BuildChartArea({
    required this.controller,
  });

  final EstatisticasPageController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      id: 'geral',
      builder: (context) {
        return const Column(
          children: [
            EstatisticaDeLinhaComFiltros(),
            Gutter(),
            EstatisticaPorCategoria(),
          ],
        );
      },
    );
  }
}

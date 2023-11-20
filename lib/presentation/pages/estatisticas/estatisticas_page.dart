import 'package:app_financas/presentation/helders/constants.dart';
import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../carteira/components/my_text_filter.dart';
import 'graficos/estatistica_por_categoria.dart';
import 'controller/estatisticas_page_controller.dart';
import 'graficos/estatistica_line_da_semana.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
  late final EstatisticasPageController controller;

  @override
  void initState() {
    controller = Get.put(EstatisticasPageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: SingleChildScrollView(
          child: GetBuilder(
            init: controller,
            id: 'geral',
            builder: (context) {
              return Column(
                children: [
                  headerSection(),
                  const Gutter(),
                  _buildFilters(),
                  const Gutter(),
                  const EstatisticaDeLinhaComFiltros(),
                  const Gutter(),
                  const EstatisticaPorCategoria(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget headerSection() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Text(
            'Estatisticas',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gutter(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(.8),
                ),
                onPressed: () {
                  controller.previousMonth();
                },
                icon: Icon(
                  Icons.keyboard_arrow_left_rounded,
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const GutterLarge(),
              Obx(
                () => Text(
                  '${controller.mygetMonthName(controller.periodoMes.value)} ${DateTime.now().year}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const GutterLarge(),
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(.8),
                ),
                onPressed: () {
                  controller.nextMonth();
                },
                icon: Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const Gutter(),
          Divider(color: Theme.of(context).colorScheme.primaryContainer),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    var controller = Get.find<EstatisticasPageController>();

    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const GutterTiny(),
          MyTextFilter(
            title: 'Saídas',
            isActive: controller.esFilter == TipoMovimento.SAIDA,
            onTap: () {
              controller.changeESFilter(TipoMovimento.SAIDA);
            },
          ),
          const GutterTiny(),
          MyTextFilter(
            title: 'Entrada',
            isActive: controller.esFilter == TipoMovimento.ENTRADA,
            onTap: () {
              controller.changeESFilter(TipoMovimento.ENTRADA);
            },
          ),
          const Spacer(),
          // select periodo
          DropdownButton<int>(
            value: controller.periodoId,
            onChanged: (int? value) {
              if (value == null) {
                return;
              }
              controller.periodoId = value;
              controller.update(['geral']);
            },
            borderRadius: BorderRadius.circular(8),
            padding: const EdgeInsets.all(kDefaultPadding / 4),
            hint: const Text('Periodo'),
            items: controller
                .getPeriods(controller.periodos)
                .map((c) => DropdownMenuItem(
                      value: c.id,
                      child: Text(c.title),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

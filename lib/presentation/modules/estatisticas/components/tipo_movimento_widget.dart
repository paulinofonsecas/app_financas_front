import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:app_financas/presentation/modules/estatisticas/controller/estatisticas_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SelectedType {
  entrada,
  saida,
  ambos,
}

class TipoMovimentosWidget extends StatefulWidget {
  const TipoMovimentosWidget({super.key});

  @override
  State<TipoMovimentosWidget> createState() => _TipoMovimentosWidgetState();
}

class _TipoMovimentosWidgetState extends State<TipoMovimentosWidget> {
  SelectedType filter = SelectedType.saida;
  late final EstatisticasPageController controller;

  @override
  void initState() {
    controller = Get.find<EstatisticasPageController>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterChip(
          selected: filter == SelectedType.saida,
          label: const Text('Saidas'),
          onSelected: (value) {
            setState(() {
              filter = SelectedType.saida;
              controller.changeESFilter(TipoMovimento.SAIDA);
            });
          },
        ),
        const SizedBox(width: 10),
        FilterChip(
          selected: filter == SelectedType.entrada,
          label: const Text('Entradas'),
          onSelected: (value) {
            setState(() {
              filter = SelectedType.entrada;
              controller.changeESFilter(TipoMovimento.ENTRADA);
            });
          },
        ),
        const SizedBox(width: 10),
        FilterChip(
          selected: filter == SelectedType.ambos,
          label: const Text('Ambos'),
          onSelected: (value) {
            setState(() {
              filter = SelectedType.ambos;
            });
          },
        ),
      ],
    );
  }
}

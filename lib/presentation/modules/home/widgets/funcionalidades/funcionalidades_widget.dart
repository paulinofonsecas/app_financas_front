import 'package:app_financas/presentation/components/escolher_tipo_movimento.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/presentation/modules/home/widgets/funcionalidades/funcionalidade_item.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/movimentos_screen.dart';
import 'package:app_financas/presentation/modules/objectivos/view/objectivos_page.dart';
import 'package:app_financas/presentation/modules/planejamento/view/planejamento_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class FuncionalidadesWidget extends StatelessWidget {
  const FuncionalidadesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomContainerButton(
            icon: Icons.add,
            label: 'Adicionar',
            onTap: () {
              customShowModalBottomSheet(
                context,
                isScrollControlled: false,
                constraints: const BoxConstraints.tightFor(),
                child: BottomEscolherTipoMovimento(
                  cloused: () {
                    Get.find<HomePageController>().update(['geral']);
                    Get.find<CarteiraPageController>().update(['geral']);
                    Get.back(closeOverlays: true);
                  },
                ),
              );
            },
          ),
          CustomContainerButton(
            icon: Icons.auto_graph,
            label: 'Movimentos',
            onTap: () {
              Get.to(MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<HomePageCubit>(),
                  ),
                  BlocProvider.value(
                    value: context.read<ShowMoneyCubit>(),
                  ),
                ],
                child: const MovimentosScreen(),
              ));
            },
          ),
          CustomContainerButton(
            icon: Icons.track_changes,
            label: 'Objectivos',
            onTap: () {
              Navigator.push(context, ObjectivosPage.route());
            },
          ),
          CustomContainerButton(
            icon: Icons.monetization_on_outlined,
            label: 'Planejamento',
            onTap: () {
              Navigator.of(context).push(PlanejamentoPage.route());
            },
          ),
        ],
      ),
    );
  }
}

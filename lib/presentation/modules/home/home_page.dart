// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/contas_cubit.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/presentation/modules/home/cubit/show_planejamento_in_home_page_cubit.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/view/movimentos_pendentes_abba.dart';
import 'package:app_financas/presentation/modules/home/widgets/carteira/card_list.dart';
import 'package:app_financas/presentation/modules/home/widgets/funcionalidades/funcionalidades_widget.dart';
import 'package:app_financas/presentation/modules/home/widgets/planejamento_widget.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/last_movimentos_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'components/action_bar.dart';
import 'components/home_screen_movimentos_widget.dart';
import 'components/saldo_disponivel_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomePageController controller;

  @override
  void initState() {
    controller = Get.put(HomePageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowPlanejamentoInHomePageCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => getIt<HomePageCubit>(),
        ),
        BlocProvider(
          create: (context) => ListMovimentosCubit(),
        ),
        BlocProvider(
          create: (context) => ShowMoneyCubit(),
        ),
        BlocProvider(
          create: (context) => getIt<ContasCubit>(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: context.theme.colorScheme.surface,
          body: SafeArea(
            bottom: false,
            child: GetBuilder(
              init: controller,
              id: 'geral',
              builder: (context) {
                return ListView(
                  children: [
                    ActionBar(),
                    SaldoDisponivelCardWidget(),
                    Gutter(),
                    CardListWidget(),
                    Gutter(),
                    FuncionalidadesWidget(),
                    Gutter(),
                    PlanejamentoWidget(),
                    MovimentosPendentesAbba(),
                    Gutter(),
                    HomeScreenMovimentosWidget(),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

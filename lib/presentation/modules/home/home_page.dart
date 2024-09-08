// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/home/abbas/components/abba_header.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/presentation/modules/home/cubit/show_planejamento_in_home_page_cubit.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/view/movimentos_pendentes_abba.dart';
import 'package:app_financas/presentation/modules/home/widgets/funcionalidades/funcionalidades_widget.dart';
import 'package:app_financas/presentation/modules/planejamento/view/planejamento_page.dart';
import 'package:app_financas/presentation/modules/planejamento/widgets/info_planejamento_section.dart';
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

    return BlocProvider(
      create: (context) => ShowPlanejamentoInHomePageCubit(getIt()),
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
                    Gutter(),
                    SaldoDisponivelCardWidget(),
                    Gutter(),
                    FuncionalidadesWidget(),
                    Gutter(),
                    _PlanejamentoWidget(),
                    Gutter(),
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

class _PlanejamentoWidget extends StatelessWidget {
  const _PlanejamentoWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: BlocBuilder<ShowPlanejamentoInHomePageCubit,
          ShowPlanejamentoInHomePageState>(
        bloc: context.read<ShowPlanejamentoInHomePageCubit>()
          ..getPlanejamento(),
        builder: (context, state) {
          if (state is ShowPlanejamentoInHomePageLoading) {
            return Center(child: const CircularProgressIndicator());
          }

          if (state is ShowPlanejamentoInHomePageEmpty) {
            return SizedBox();
          }

          if (state is ShowPlanejamentoInHomePageError) {
            log(state.message);
            return SizedBox();
          }

          if (state is ShowPlanejamentoInHomePageSuccess) {
            return Column(
              children: [
                Gutter(),
                AbbaHeader(
                  title: 'Planejamento',
                  verMaisAction: () {
                    Navigator.of(context).push(PlanejamentoPage.route());
                  },
                ),
                Gutter(),
                InkWell(
                  onTap: () =>
                      Navigator.of(context).push(PlanejamentoPage.route()),
                  child: InfoPlanejamentoSection(
                    planejamento: state.planejamento,
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

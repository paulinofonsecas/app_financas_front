// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/view/movimentos_pendentes_abba.dart';
import 'package:flutter/material.dart';
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
                MovimentosPendentesAbba(),
                Gutter(),
                HomeScreenMovimentosWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}

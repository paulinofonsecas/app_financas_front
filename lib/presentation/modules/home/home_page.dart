// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/action_bar.dart';
import 'components/entradas_saidas.dart';
import 'components/home_screen_movimentos_widget.dart';
import 'components/show_cards.dart';

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
      body: GetBuilder(
        init: controller,
        id: 'geral',
        builder: (context) {
          return ListView(
            children: [
              ActionBar(),
              SizedBox(height: kDefaultPadding * 2),
              SaldoDisponivelCardWidget(),
              SizedBox(height: kDefaultPadding),
              EntradasESaidas(),
              SizedBox(height: kDefaultPadding),
              HomeScreenMovimentosWidget(),
            ],
          );
        },
      ),
    );
  }
}

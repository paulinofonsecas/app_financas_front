// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/app/modules/movimentos/movimentos_screen.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'abbas/movimentos.dart';
import 'components/action_bar.dart';
import 'components/entradas_saidas.dart';
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
              SizedBox(height: kDefaultPadding),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShowCards(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        SizedBox(height: kDefaultPadding),
                        EntradasESaidas(),
                        SizedBox(height: kDefaultPadding * 2),
                        FutureBuilder<List<Movimento>>(
                          future: controller.listMovimentosDoDia(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            if (snapshot.hasData) {
                              return MovimentosAtHomePage(
                                movimentos: snapshot.data ?? [],
                                verMaisAction: () {
                                  Get.to(MovimentosScreen());
                                },
                              );
                            } else {
                              return Align(
                                alignment: Alignment.topCenter,
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

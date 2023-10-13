// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/app/components/escolher_tipo_movimento.dart';
import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/app/modules/movimentos/movimentos_screen.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());

    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: ListView(
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
                        if (snapshot.hasData) {
                          return Movimentos(
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return BottomEscolherTipoMovimento(
                cloused: () {
                  Get.back(closeOverlays: true);
                  controller.update();
                  setState(() {});
                },
              );
            },
          );
        },
        child: Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        useLegacyColorScheme: false,
        backgroundColor: kWhiteColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.wallet,
            ),
            label: 'Carteira',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.timeline,
            ),
            label: 'Estatisticas',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person_alt,
            ),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

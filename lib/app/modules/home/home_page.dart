// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/app/components/escolher_tipo_movimento.dart';
import 'package:app_financas/app/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/app/modules/movimentos/movimentos_screen.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'abbas/movimentos.dart';
import 'components/action_bar.dart';
import 'components/entradas_saidas.dart';
import 'components/total_balance.dart';

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
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
        backgroundColor: kAzulColor,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return BottomEscolherTipoMovimento(
                cloused: () {
                  Get.back();
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

class ShowCards extends StatefulWidget {
  const ShowCards({super.key});

  @override
  State<ShowCards> createState() => _ShowCardsState();
}

class _ShowCardsState extends State<ShowCards> {
  var pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());
    var size = MediaQuery.of(context).size;
    var cartoes = controller.getCartoes();

    return SizedBox(
      width: size.width,
      height: size.height * 0.23,
      child: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        itemCount: cartoes.length,
        itemBuilder: (context, index) {
          var cartao = cartoes[index];
          return LayoutBuilder(
            builder: (c, constraines) => Container(
              margin: EdgeInsets.only(right: kDefaultPadding),
              child: CardWidget(
                width: size.width * 0.85,
                height: index == 0
                    ? constraines.maxHeight
                    : constraines.maxHeight * 0.75,
                cartao: cartao,
              ),
            ),
          );
        },
      ),
    );
  }
}

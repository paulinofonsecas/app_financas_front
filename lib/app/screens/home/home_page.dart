// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/app/screens/adicionar_movimento/adicionar_movimentos.dart';
import 'package:app_financas/app/screens/movimentos/movimentos_screen.dart';
import 'package:app_financas/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'abbas/movimentos.dart';
import 'components/action_bar.dart';
import 'components/entradas_saidas.dart';
import 'components/total_balance.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: ListView(
        children: [
          ActionBar(),
          SizedBox(height: kDefaultPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TotalBalanceCard(),
                SizedBox(height: kDefaultPadding),
                EntradasESaidas(),
                // SizedBox(height: kDefaultPadding * 2),
                // FontesDeReceita(),
                SizedBox(height: kDefaultPadding * 2),
                Movimentos(verMaisAction: () {
                  Get.to(MovimentosScreen());
                }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kAzulColor,
        onPressed: () {
          Get.to(AdicionarMovimentos());
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

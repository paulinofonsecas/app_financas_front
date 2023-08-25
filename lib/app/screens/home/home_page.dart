// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'abbas/fontes_de_receitas.dart';
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
          Padding(
            padding: EdgeInsets.all(27.0),
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
                Movimentos(),
              ],
            ),
          ),
        ],
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

// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';

import 'abbas/fontes_de_receitas.dart';
import 'components/action_bar.dart';
import 'components/entradas_saidas.dart';
import 'components/total_balance.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: kDefaultPadding * 2),
                FontesDeReceita(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

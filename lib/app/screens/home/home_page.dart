// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'components/action_bar.dart';
import 'components/total_balance.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          ActionBar(),
          Padding(
            padding: EdgeInsets.all(27.0),
            child: TotalBalanceCard(),
          ),
        ],
      ),
    );
  }
}

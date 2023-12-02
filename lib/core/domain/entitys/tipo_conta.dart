import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipoConta {
  final int id;
  final String nome;
  final IconData icon;

  TipoConta({required this.id, required this.nome, required this.icon});

  static List<TipoConta> get tipoContas {
    return [
      TipoConta(
        id: 1,
        nome: 'Conta corrente',
        icon: FontAwesomeIcons.solidCreditCard,
      ),
      TipoConta(
        id: 2,
        nome: 'Dinheiro',
        icon: Icons.attach_money,
      ),
      TipoConta(
        id: 3,
        nome: 'Poupança',
        icon: FontAwesomeIcons.piggyBank,
      ),
      TipoConta(
        id: 4,
        nome: 'Investimento',
        icon: FontAwesomeIcons.chartLine,
      ),
      TipoConta(
        id: 5,
        nome: 'Outros',
        icon: FontAwesomeIcons.bars,
      ),
    ];
  }
}

import 'package:flutter/material.dart';

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
        icon: Icons.arrow_upward,
      ),
      TipoConta(
        id: 2,
        nome: 'Dinheiro',
        icon: Icons.arrow_downward,
      ),
      TipoConta(
        id: 3,
        nome: 'Poupança',
        icon: Icons.arrow_downward,
      ),
      TipoConta(
        id: 4,
        nome: 'Investimento',
        icon: Icons.arrow_downward,
      ),
      TipoConta(
        id: 5,
        nome: 'Outros',
        icon: Icons.arrow_downward,
      ),
    ];
  }
}

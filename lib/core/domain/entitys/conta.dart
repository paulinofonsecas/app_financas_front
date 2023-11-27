// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:app_financas/core/domain/entitys/tipo_conta.dart';

class Conta {
  final int id;
  final String nome;
  final double saldo;
  final double saldoInicial;
  final String descricao;
  final TipoConta tipoConta;
  final Color color;
  final String? iconAsset;
  final int totalDespesas;
  final int totalReceitas;
  final bool? showInSoma;
  final bool? isArchived;

  Conta({
    required this.id,
    required this.nome,
    required this.saldo,
    required this.saldoInicial,
    required this.descricao,
    required this.tipoConta,
    required this.totalDespesas,
    required this.totalReceitas,
    required this.color,
    this.iconAsset,
    this.showInSoma = true,
    this.isArchived = false,
  });

  factory Conta.fake() {
    return Conta(
      id: 0,
      nome: 'Conta fake',
      saldo: 0.0,
      saldoInicial: 0.0,
      totalDespesas: 0,
      totalReceitas: 0,
      descricao: 'Conta fake',
      tipoConta: TipoConta.tipoContas.first,
      color: Colors.blue,
      iconAsset: null,
      showInSoma: null,
      isArchived: null,
    );
  }

  Conta copyWith({
    int? id,
    String? nome,
    double? saldo,
    double? saldoInicial,
    String? descricao,
    TipoConta? tipoConta,
    Color? color,
    int? totalDespesas,
    int? totalReceitas,
    String? iconAsset,
    bool? showInSoma,
    bool? isArchived,
  }) {
    return Conta(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      saldo: saldo ?? this.saldo,
      saldoInicial: saldoInicial ?? this.saldoInicial,
      descricao: descricao ?? this.descricao,
      tipoConta: tipoConta ?? this.tipoConta,
      color: color ?? this.color,
      totalDespesas: totalDespesas ?? this.totalDespesas,
      totalReceitas: totalReceitas ?? this.totalReceitas,
      iconAsset: iconAsset ?? this.iconAsset,
      showInSoma: showInSoma ?? this.showInSoma,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'saldo': saldo,
      'saldoInicial': saldoInicial,
      'descricao': descricao,
      'tipoConta': tipoConta.id,
      'color': color.value,
      'totalDespesas': totalDespesas,
      'totalReceitas': totalReceitas,
      'iconAsset': iconAsset,
      'showInSoma': showInSoma,
      'isArchived': isArchived,
    };
  }

  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta(
      id: map['id'] as int,
      nome: map['nome'] as String,
      saldo: map['saldo'] as double,
      saldoInicial: map['saldoInicial'] as double,
      descricao: map['descricao'] as String,
      tipoConta: TipoConta.tipoContas
          .firstWhere((element) => element.id == map['tipoConta'] as int),
      color: Color(map['color'] as int),
      totalDespesas: map['totalDespesas'] as int? ?? 0,
      totalReceitas: map['totalReceitas'] as int? ?? 0,
      iconAsset: map['iconAsset'] != null ? map['iconAsset'] as String : null,
      showInSoma: map['showInSoma'] != null ? map['showInSoma'] as bool : null,
      isArchived: map['isArchived'] != null ? map['isArchived'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conta.fromJson(String source) =>
      Conta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conta(id: $id, nome: $nome, saldo: $saldo, saldoInicial: $saldoInicial, descricao: $descricao, tipoConta: $tipoConta, color: $color, iconAsset: $iconAsset, showInSoma: $showInSoma, isArchived: $isArchived)';
  }

  @override
  bool operator ==(covariant Conta other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.saldo == saldo &&
        other.saldoInicial == saldoInicial &&
        other.descricao == descricao &&
        other.tipoConta == tipoConta &&
        other.color == color &&
        other.totalDespesas == totalDespesas &&
        other.totalReceitas == totalReceitas &&
        other.iconAsset == iconAsset &&
        other.showInSoma == showInSoma &&
        other.isArchived == isArchived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        saldo.hashCode ^
        saldoInicial.hashCode ^
        descricao.hashCode ^
        tipoConta.hashCode ^
        color.hashCode ^
        iconAsset.hashCode ^
        showInSoma.hashCode ^
        isArchived.hashCode;
  }
}

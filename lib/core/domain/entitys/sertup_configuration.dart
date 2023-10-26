// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

class SetupConfiguration {
  bool isLocal;
  final List<Categoria> categorias;
  final List<Conta> contas;

  SetupConfiguration({
    required this.categorias,
    required this.contas,
    this.isLocal = false,
  });

  factory SetupConfiguration.local() {
    return SetupConfiguration(
      categorias: [],
      contas: [],
      isLocal: true,
    );
  }

  SetupConfiguration copyWith({
    List<Categoria>? categorias,
    List<Conta>? cartoes,
  }) {
    return SetupConfiguration(
      categorias: categorias ?? this.categorias,
      contas: cartoes ?? this.contas,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categorias': categorias.map((x) => x.toMap()).toList(),
      'cartoes': contas.map((x) => x.toMap()).toList(),
    };
  }

  factory SetupConfiguration.fromMap(Map<String, dynamic> map) {
    return SetupConfiguration(
      categorias: List<Categoria>.from(
        (map['categorias'] as List<dynamic>).map<Categoria>(
          (x) => Categoria.fromMap(x as Map<String, dynamic>),
        ),
      ),
      contas: List<Conta>.from(
        (map['cartoes'] as List<dynamic>).map<Conta>(
          (x) => Conta.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SetupConfiguration.fromJson(String source) =>
      SetupConfiguration.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SetupConfiguration(categorias: $categorias, cartoes: $contas)';

  @override
  bool operator ==(covariant SetupConfiguration other) {
    if (identical(this, other)) return true;

    return listEquals(other.categorias, categorias) &&
        listEquals(other.contas, contas);
  }

  @override
  int get hashCode => categorias.hashCode ^ contas.hashCode;
}

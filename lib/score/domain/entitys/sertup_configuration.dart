// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app_financas/score/domain/entitys/conta.dart';
import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';

class SetupConfiguration {
  bool isLocal;
  final List<Categoria> categoriasEntradas;
  final List<Categoria> categoriasSaidas;
  final List<Conta> contas;

  SetupConfiguration({
    required this.categoriasEntradas,
    required this.categoriasSaidas,
    required this.contas,
    this.isLocal = false,
  });

  factory SetupConfiguration.local() {
    return SetupConfiguration(
      categoriasEntradas: [],
      categoriasSaidas: [],
      contas: [],
      isLocal: true,
    );
  }

  SetupConfiguration copyWith({
    List<Categoria>? categoriasEntradas,
    List<Categoria>? categoriasSaidas,
    List<Conta>? contas,
  }) {
    return SetupConfiguration(
      categoriasEntradas: categoriasEntradas ?? this.categoriasEntradas,
      categoriasSaidas: categoriasSaidas ?? this.categoriasSaidas,
      contas: contas ?? this.contas,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoriasEntradas': categoriasEntradas.map((x) => x.toMap()).toList(),
      'categoriasSaidas': categoriasSaidas.map((x) => x.toMap()).toList(),
      'cartoes': contas.map((x) => x.toMap()).toList(),
    };
  }

  factory SetupConfiguration.fromMap(Map<String, dynamic> map) {
    return SetupConfiguration(
      categoriasEntradas: List<Categoria>.from(
        (map['categoriasEntradas'] as List<dynamic>).map<Categoria>(
          (x) => Categoria.fromMap(x as Map<String, dynamic>),
        ),
      ),
      categoriasSaidas: List<Categoria>.from(
        (map['categoriasSaidas'] as List<dynamic>).map<Categoria>(
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
      'SetupConfiguration(categorias: $categoriasEntradas, cartoes: $contas)';

  @override
  bool operator ==(covariant SetupConfiguration other) {
    if (identical(this, other)) return true;

    return listEquals(other.categoriasEntradas, categoriasEntradas) &&
        listEquals(other.contas, contas);
  }

  @override
  int get hashCode => categoriasEntradas.hashCode ^ contas.hashCode;
}

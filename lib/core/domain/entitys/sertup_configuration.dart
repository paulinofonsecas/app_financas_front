// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:app_financas/core/domain/entitys/cartao.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

class SetupConfiguration {
  final List<CategoriaMovimento> categorias;
  final List<Cartao> cartoes;

  SetupConfiguration({
    required this.categorias,
    required this.cartoes,
  });

  factory SetupConfiguration.zero() {
    return SetupConfiguration(
      categorias: [],
      cartoes: [],
    );
  }

  SetupConfiguration copyWith({
    List<CategoriaMovimento>? categorias,
    List<Cartao>? cartoes,
  }) {
    return SetupConfiguration(
      categorias: categorias ?? this.categorias,
      cartoes: cartoes ?? this.cartoes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categorias': categorias.map((x) => x.toMap()).toList(),
      'cartoes': cartoes.map((x) => x.toMap()).toList(),
    };
  }

  factory SetupConfiguration.fromMap(Map<String, dynamic> map) {
    return SetupConfiguration(
      categorias: List<CategoriaMovimento>.from(
        (map['categorias'] as List<dynamic>).map<CategoriaMovimento>(
          (x) => CategoriaMovimento.fromMap(x as Map<String, dynamic>),
        ),
      ),
      cartoes: List<Cartao>.from(
        (map['cartoes'] as List<dynamic>).map<Cartao>(
          (x) => Cartao.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SetupConfiguration.fromJson(String source) =>
      SetupConfiguration.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SetupConfiguration(categorias: $categorias, cartoes: $cartoes)';

  @override
  bool operator ==(covariant SetupConfiguration other) {
    if (identical(this, other)) return true;

    return listEquals(other.categorias, categorias) &&
        listEquals(other.cartoes, cartoes);
  }

  @override
  int get hashCode => categorias.hashCode ^ cartoes.hashCode;
}

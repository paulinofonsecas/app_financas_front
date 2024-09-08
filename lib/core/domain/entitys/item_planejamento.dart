// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemPlanejamento {
  final int id; // Identificador único do item
  final Categoria categoria; // Categoria do item (ex: Alimentação, Transporte)
  final double plafound; // Valor planejado para o item
  final List<Movimento> movimentos;

  ItemPlanejamento({
    required this.id,
    required this.categoria,
    required this.plafound,
    this.movimentos = const [],
  });

  factory ItemPlanejamento.make(Categoria categoria) {
    return ItemPlanejamento(
      id: Random.secure().nextInt(100000),
      categoria: categoria,
      plafound: 0,
      movimentos: [],
    );
  }

  // fake constructor
  factory ItemPlanejamento.fake() => ItemPlanejamento(
        id: 0,
        categoria: Categoria.fake(
          Colors
              .primaries[Random.secure().nextInt(Colors.primaries.length - 1)],
        ),
        plafound: 100000.0,
        movimentos: [
          Movimento.fake(
            valor: Random.secure().nextInt(100000).toDouble(),
          ),
        ],
      );

  // calcula o valor consumido
  double get consumido => movimentos.fold(
      0.0, (previousValue, element) => previousValue + element.valor);

  ItemPlanejamento copyWith({
    int? id,
    Categoria? categoria,
    double? plafound,
    List<Movimento>? movimentos,
  }) {
    return ItemPlanejamento(
      id: id ?? this.id,
      categoria: categoria ?? this.categoria,
      plafound: plafound ?? this.plafound,
      movimentos: movimentos ?? this.movimentos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoria': categoria.id,
      'plafound': plafound,
      // 'movimentos': movimentos.map((x) => x.toMap()).toList(),
    };
  }

  factory ItemPlanejamento.fromMap(dynamic map) {
    return ItemPlanejamento(
      id: map['id'] as int,
      categoria: Categoria.fake(),
      plafound: map['plafound'] as double,
      movimentos: [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemPlanejamento.fromJson(String source) =>
      ItemPlanejamento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ItemPlanejamento(id: $id, categoria: $categoria, plafound: $plafound, movimentos: $movimentos)';
  }

  @override
  bool operator ==(covariant ItemPlanejamento other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.categoria == categoria &&
        other.plafound == plafound &&
        listEquals(other.movimentos, movimentos);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        categoria.hashCode ^
        plafound.hashCode ^
        movimentos.hashCode;
  }
}

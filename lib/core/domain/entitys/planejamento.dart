// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app_financas/core/domain/entitys/item_planejamento.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Planejamento {
  final String id;
  final DateTime dataReferencia; // Data de referência do planejamento
  final double plafound; // Orçamento total disponível
  final List<ItemPlanejamento> itens; // Lista de itens do planejamento

  Planejamento({
    required this.id,
    required this.dataReferencia,
    required this.plafound,
    this.itens = const [],
  });

  factory Planejamento.make() {
    return Planejamento(
      id: const Uuid().v4(),
      dataReferencia: DateTime.now(),
      plafound: 0,
      itens: [],
    );
  }

  // fake construtor
  Planejamento.fake({
    DateTime? dataReferencia,
    List<ItemPlanejamento>? itens,
  })  : id = '00000000-0000',
        dataReferencia = dataReferencia ?? DateTime.now(),
        plafound = 200000.0,
        itens = itens ?? [];

  // Método para calcular o total gasto com base nos itens
  double get totalGasto => itens.fold(0, (sum, item) => sum + item.consumido);

  double get restante => plafound - totalGasto;

  double get gastoPorDia => plafound / 30;

  Planejamento copyWith({
    String? id,
    DateTime? dataReferencia,
    double? plafound,
    List<ItemPlanejamento>? itens,
  }) {
    return Planejamento(
      id: id ?? this.id,
      dataReferencia: dataReferencia ?? this.dataReferencia,
      plafound: plafound ?? this.plafound,
      itens: itens ?? this.itens,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dataReferencia': dataReferencia.millisecondsSinceEpoch,
      'plafound': plafound,
      'itens': itens.map((x) => x.toMap()).toList(),
    };
  }

  factory Planejamento.fromMap(dynamic map) {
    return Planejamento(
      id: map['id'] as String,
      dataReferencia:
          DateTime.fromMillisecondsSinceEpoch(map['dataReferencia'] as int),
      plafound: map['plafound'] as double,
      itens: List<ItemPlanejamento>.from(
        (map['itens'] as List<dynamic>).map<ItemPlanejamento>(
          (x) => ItemPlanejamento.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Planejamento.fromJson(String source) =>
      Planejamento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Planejamento(id: $id, dataReferencia: $dataReferencia, plafound: $plafound, itens: $itens)';
  }

  @override
  bool operator ==(covariant Planejamento other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.dataReferencia == dataReferencia &&
        other.plafound == plafound &&
        listEquals(other.itens, itens);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dataReferencia.hashCode ^
        plafound.hashCode ^
        itens.hashCode;
  }
}

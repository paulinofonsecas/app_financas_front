// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/domain/entities/item_planejamento.dart';
import 'package:flutter/foundation.dart';

class CreatePlanejmantoModel {
  final double plafound;
  final List<ItemPlanejamento> itens;

  CreatePlanejmantoModel({
    this.plafound = 0,
    this.itens = const [],
  });

  CreatePlanejmantoModel copyWith({
    double? plafound,
    List<ItemPlanejamento>? itens,
  }) {
    return CreatePlanejmantoModel(
      plafound: plafound ?? this.plafound,
      itens: itens ?? this.itens,
    );
  }

  @override
  String toString() =>
      'CreatePlanejmantoModel(plafound: $plafound, itens: $itens)';

  @override
  bool operator ==(covariant CreatePlanejmantoModel other) {
    if (identical(this, other)) return true;

    return other.plafound == plafound && listEquals(other.itens, itens);
  }

  @override
  int get hashCode => plafound.hashCode ^ itens.hashCode;
}

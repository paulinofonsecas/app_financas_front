// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

enum TipoCategoria {
  entrada,
  saida,
  todas,
}

class Categoria {
  int id;
  String name;
  Color? color;
  IconData? icon;
  bool isArchived;
  List<Categoria> subCategorias = [];

  Categoria({
    required this.id,
    required this.name,
    this.isArchived = false,
    this.color,
    this.icon,
    this.subCategorias = const [],
  });

  factory Categoria.make({
    required String name,
    Color? color,
    IconData? icon,
    isArchived = false,
    List<Categoria> subCategorias = const [],
  }) {
    return Categoria(
      id: const Uuid().v4().hashCode,
      name: name,
      color: color,
      icon: icon,
      isArchived: isArchived,
      subCategorias: subCategorias,
    );
  }

  factory Categoria.fake([Color? color]) {
    return Categoria(
      id: 3,
      name: 'Teste',
      color: color ?? Colors.blue,
      icon: Icons.book,
    );
  }

  factory Categoria.ajuste(int tipoMovimentoId) {
    return Categoria(
      id: 303030,
      name: 'Reajuste',
      color: tipoMovimentoId == 1 ? Colors.green : Colors.red,
      icon: FontAwesomeIcons.screwdriverWrench,
    );
  }

  factory Categoria.saldoInicial(int tipoMovimentoId) {
    return Categoria(
      id: 303040,
      name: 'Saldo inicial',
      color: tipoMovimentoId == 1 ? Colors.green : Colors.red,
      icon: FontAwesomeIcons.digitalOcean,
    );
  }

  Categoria copyWith({
    int? id,
    String? name,
    Color? color,
    IconData? icon,
    bool? isArchived,
    List<Categoria>? subCategorias,
  }) {
    return Categoria(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isArchived: isArchived ?? this.isArchived,
      subCategorias: subCategorias ?? this.subCategorias,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color?.value,
      'icon': icon != null
          ? serializeIcon(icon!, iconPack: IconPack.material)
          : null,
      'isArchived': isArchived,
      'subCategorias': subCategorias.map((e) => e.toMap()).toList(),
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
        id: map['id'] as int,
        name: map['name'] as String,
        color: map['color'] != null ? Color(map['color'] as int) : null,
        isArchived: map['isArchived'] as bool? ?? false,
        icon: map['icon'] != null
            ? deserializeIcon(
                map['icon'].cast<String, dynamic>(),
                iconPack: IconPack.material,
              )
            : null,
        subCategorias: map['subCategorias'] == null
            ? []
            : (map['subCategorias'] as List<dynamic>)
                .map((e) => Categoria.fromMap(e))
                .toList());
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Categoria(id: $id, name: $name, color: $color, '
        'icon: $icon, isArchived: $isArchived)';
  }

  @override
  bool operator ==(covariant Categoria other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.color == color &&
        other.isArchived == isArchived &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        color.hashCode ^
        icon.hashCode ^
        isArchived.hashCode;
  }
}

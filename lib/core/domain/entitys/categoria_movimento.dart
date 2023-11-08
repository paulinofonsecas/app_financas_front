// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';

enum TipoCategoria { entrada, saida, todas }

class Categoria {
  int id;
  String name;
  Color? color;
  IconData? icon;

  Categoria({
    required this.id,
    required this.name,
    this.color,
    this.icon,
  });

  factory Categoria.make({
    required String name,
    Color? color,
    IconData? icon,
  }) {
    return Categoria(
      id: -1,
      name: name,
      color: color,
      icon: icon,
    );
  }

  factory Categoria.fake() {
    return Categoria(
      id: -1,
      name: '',
      color: null,
      icon: null,
    );
  }

  Categoria copyWith({
    int? id,
    String? name,
    Color? color,
    IconData? icon,
  }) {
    return Categoria(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'color': color?.value,
      'icon': icon != null ? serializeIcon(icon!) : null,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'] != null ? Color(map['color'] as int) : null,
      icon: map['icon'] != null
          ? deserializeIcon(map['icon'].cast<String, dynamic>())
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Categoria(id: $id, name: $name, color: $color, icon: $icon)';
  }

  @override
  bool operator ==(covariant Categoria other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.color == color &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ color.hashCode ^ icon.hashCode;
  }
}

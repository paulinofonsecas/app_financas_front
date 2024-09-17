// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Objectivo {
  final String id;
  final String name;
  final String description;
  final Color color;
  final IconData icon;
  final double initialValue;
  final double targetValue;
  final double currentValue;
  final DateTime finalDate;
  final bool isPaused;

  Objectivo({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
    required this.icon,
    required this.targetValue,
    required this.finalDate,
    this.initialValue = 0,
    this.currentValue = 0,
    this.isPaused = false,
  });

  Objectivo copyWith({
    String? id,
    String? name,
    String? description,
    Color? color,
    IconData? icon,
    double? initialValue,
    double? targetValue,
    double? currentValue,
    DateTime? finalDate,
    bool? isPaused,
  }) {
    return Objectivo(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      initialValue: initialValue ?? this.initialValue,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      finalDate: finalDate ?? this.finalDate,
      isPaused: isPaused ?? this.isPaused,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'color': color.value,
      'icon': icon.codePoint,
      'initialValue': initialValue,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'finalDate': finalDate.millisecondsSinceEpoch,
      'isPaused': isPaused,
    };
  }

  factory Objectivo.fromMap(Map<String, dynamic> map) {
    return Objectivo(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      color: Color(map['color'] as int),
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
      initialValue: map['initialValue'] as double,
      targetValue: map['targetValue'] as double,
      currentValue: map['currentValue'] as double,
      finalDate: DateTime.fromMillisecondsSinceEpoch(map['finalDate'] as int),
      isPaused: map['isPaused'] as bool,
    );
  }

  factory Objectivo.fake() => Objectivo(
        id: '1',
        name: 'Carro novo',
        description: 'Novo carro',
        color: Colors.blue,
        icon: Icons.check,
        initialValue: 0,
        currentValue: 0,
        targetValue: 100,
        finalDate: DateTime(2022, 12, 31),
        isPaused: false,
      );

  factory Objectivo.make({
    required String name,
    required String description,
    required Color color,
    required IconData icon,
    required double targetValue,
    required DateTime finalDate,
    bool isPaused = false,
    double initialValue = 0,
    double currentValue = 0,
  }) {
    return Objectivo(
      id: const Uuid().v4(),
      name: name,
      description: description,
      color: color,
      icon: icon,
      targetValue: targetValue,
      finalDate: finalDate,
      initialValue: initialValue,
      currentValue: currentValue,
      isPaused: isPaused,
    );
  }

  String toJson() => json.encode(toMap());

  factory Objectivo.fromJson(String source) =>
      Objectivo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Objectivo(id: $id, name: $name, description: $description, color: $color, icon: $icon, initialValue: $initialValue, targetValue: $targetValue, currentValue: $currentValue, finalDate: $finalDate, isPaused: $isPaused)';
  }

  @override
  bool operator ==(covariant Objectivo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.color.value == color.value &&
        other.icon == icon &&
        other.initialValue == initialValue &&
        other.targetValue == targetValue &&
        other.currentValue == currentValue &&
        other.finalDate == finalDate &&
        other.isPaused == isPaused;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        color.hashCode ^
        icon.hashCode ^
        initialValue.hashCode ^
        targetValue.hashCode ^
        currentValue.hashCode ^
        finalDate.hashCode ^
        isPaused.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum TipoCategoria { entrada, saida, todas }

class Categoria {
  int id;
  String name;

  Categoria({
    required this.id,
    required this.name,
  });

  Categoria copyWith({
    int? id,
    String? name,
  }) {
    return Categoria(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Categoria.fromMap(Map<String, dynamic> map) {
    return Categoria(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categoria.fromJson(String source) =>
      Categoria.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoriaMovimento(id: $id, name: $name)';

  @override
  bool operator ==(covariant Categoria other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

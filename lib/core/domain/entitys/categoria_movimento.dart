// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoriaMovimento {
  int id;
  String name;
  
  CategoriaMovimento({
    required this.id,
    required this.name,
  });

  CategoriaMovimento copyWith({
    int? id,
    String? name,
  }) {
    return CategoriaMovimento(
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

  factory CategoriaMovimento.fromMap(Map<String, dynamic> map) {
    return CategoriaMovimento(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriaMovimento.fromJson(String source) => CategoriaMovimento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoriaMovimento(id: $id, name: $name)';

  @override
  bool operator ==(covariant CategoriaMovimento other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

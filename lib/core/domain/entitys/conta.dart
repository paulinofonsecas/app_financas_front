// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Conta {
  final int id;
  final String nome;
  final double saldo;

  Conta({
    required this.id,
    required this.nome,
    required this.saldo,
  });

  factory Conta.fake() {
    return Conta(
      id: 0,
      nome: '',
      saldo: 0,
    );
  }

  Conta copyWith({
    int? id,
    String? nome,
    double? saldo,
  }) {
    return Conta(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      saldo: saldo ?? this.saldo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'saldo': saldo,
    };
  }

  factory Conta.fromMap(Map<String, dynamic> map) {
    return Conta(
      id: map['id'] as int,
      nome: map['nome'] as String,
      saldo: map['saldo'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Conta.fromJson(String source) =>
      Conta.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Conta(id: $id, nome: $nome, saldo: $saldo)';

  @override
  bool operator ==(covariant Conta other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nome == nome && other.saldo == saldo;
  }

  @override
  int get hashCode => id.hashCode ^ nome.hashCode ^ saldo.hashCode;
}

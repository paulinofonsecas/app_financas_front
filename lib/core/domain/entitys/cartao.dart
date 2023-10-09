// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cartao {
  final int id;
  final String numero;
  final String nome;
  final double saldo;
  final int bancoId;

  Cartao({
    required this.id,
    required this.numero,
    required this.nome,
    required this.saldo,
    required this.bancoId,
  });

  Cartao copyWith({
    int? id,
    String? numero,
    String? nome,
    double? saldo,
    int? bancoId,
  }) {
    return Cartao(
      id: id ?? this.id,
      numero: numero ?? this.numero,
      nome: nome ?? this.nome,
      saldo: saldo ?? this.saldo,
      bancoId: bancoId ?? this.bancoId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'numero': numero,
      'nome': nome,
      'saldo': saldo,
      'banco_id': bancoId,
    };
  }

  factory Cartao.fromMap(Map<String, dynamic> map) {
    return Cartao(
      id: map['id'] as int,
      numero: map['numero'] as String,
      nome: map['nome'] as String,
      saldo: (map['saldo'] as int).toDouble(),
      bancoId: map['banco_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cartao.fromJson(String source) =>
      Cartao.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Conta(id: $id, numero: $numero, nome: $nome, saldo: $saldo, bancoId: $bancoId)';
  }

  @override
  bool operator ==(covariant Cartao other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.numero == numero &&
        other.nome == nome &&
        other.saldo == saldo &&
        other.bancoId == bancoId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        numero.hashCode ^
        nome.hashCode ^
        saldo.hashCode ^
        bancoId.hashCode;
  }
}

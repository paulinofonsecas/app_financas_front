// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Movimento {
  final int id;
  final double valor;
  final DateTime data;
  final String descricao;
  final int userId;
  final int cartaoId;
  final int tipoMovimentoId;
  final int categoriaMovimentoId;
  final String obsMovimento;
  final DateTime createdAt;
  final DateTime updatedAt;

  Movimento({
    required this.id,
    required this.valor,
    required this.data,
    required this.descricao,
    required this.userId,
    required this.cartaoId,
    required this.tipoMovimentoId,
    required this.categoriaMovimentoId,
    required this.obsMovimento,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Movimento.make({
    int? id,
    required double valor,
    required DateTime data,
    required String descricao,
    required int cartaoId,
    required int tipoMovimentoId,
    required int categoriaMovimentoId,
    required String obsMovimento,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Movimento(
      id: -1,
      valor: valor,
      data: data,
      descricao: descricao,
      userId: -1,
      cartaoId: cartaoId,
      tipoMovimentoId: tipoMovimentoId,
      categoriaMovimentoId: categoriaMovimentoId,
      obsMovimento: obsMovimento,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  factory Movimento.fake() {
    return Movimento(
      id: -1,
      valor: 0,
      data: DateTime.now(),
      descricao: '',
      userId: -1,
      cartaoId: -1,
      tipoMovimentoId: -1,
      categoriaMovimentoId: -1,
      obsMovimento: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Movimento copyWith({
    int? id,
    double? valor,
    DateTime? data,
    String? descricao,
    int? userId,
    int? cartaoId,
    int? tipoMovimentoId,
    int? categoriaMovimentoId,
    String? obsMovimento,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Movimento(
      id: id ?? this.id,
      valor: valor ?? this.valor,
      data: data ?? this.data,
      descricao: descricao ?? this.descricao,
      userId: userId ?? this.userId,
      cartaoId: cartaoId ?? this.cartaoId,
      tipoMovimentoId: tipoMovimentoId ?? this.tipoMovimentoId,
      categoriaMovimentoId: categoriaMovimentoId ?? this.categoriaMovimentoId,
      obsMovimento: obsMovimento ?? this.obsMovimento,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'valor': valor,
      'data': data.millisecondsSinceEpoch,
      'descricao': descricao,
      'user_id': userId,
      'cartao_id': cartaoId,
      'tipo_movimento_id': tipoMovimentoId,
      'categoria_movimento_id': categoriaMovimentoId,
      'obs_movimento': obsMovimento,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory Movimento.fromMap(Map<String, dynamic> map) {
    return Movimento(
      id: map['id'] as int,
      valor: (map['valor'] as int).toDouble(),
      data: DateTime.parse(map['data']),
      descricao: map['descricao'] as String,
      userId: map['user_id'] as int,
      cartaoId: map['cartao_id'] as int,
      tipoMovimentoId: map['tipo_movimento_id'] as int,
      categoriaMovimentoId: map['categoria_movimento_id'] as int,
      obsMovimento: map['obs_movimento'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Movimento.fromJson(String source) =>
      Movimento.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Movimento(id: $id, valor: $valor, data: $data, descricao: $descricao,'
        ' userId: $userId, cartaoId: $cartaoId, tipoMovimentoId: $tipoMovimentoId,'
        ' categoriaMovimentoId: $categoriaMovimentoId, obsMovimento: $obsMovimento,'
        ' createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Movimento other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.valor == valor &&
        other.data == data &&
        other.descricao == descricao &&
        other.userId == userId &&
        other.cartaoId == cartaoId &&
        other.tipoMovimentoId == tipoMovimentoId &&
        other.categoriaMovimentoId == categoriaMovimentoId &&
        other.obsMovimento == obsMovimento &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        valor.hashCode ^
        data.hashCode ^
        descricao.hashCode ^
        userId.hashCode ^
        cartaoId.hashCode ^
        tipoMovimentoId.hashCode ^
        categoriaMovimentoId.hashCode ^
        obsMovimento.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}

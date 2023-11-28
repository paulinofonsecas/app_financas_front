class Banco {
  final int id;
  final String nome;
  final String? acronimo;
  final String? imgAsset;

  Banco({
    required this.id,
    required this.nome,
    this.acronimo,
    this.imgAsset,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'acronimo': acronimo,
      'imgAsset': imgAsset,
    };
  }

  factory Banco.fromMap(Map<dynamic, dynamic> map) {
    return Banco(
      id: map['id'] as int,
      nome: map['nome'] as String,
      acronimo: map['acronimo'] as String,
      imgAsset: map['imgAsset'] != null ? map['imgAsset'] as String : null,
    );
  }

  @override
  String toString() {
    return 'Banco(id: $id, nome: $nome, imgAsset: $imgAsset)';
  }
}

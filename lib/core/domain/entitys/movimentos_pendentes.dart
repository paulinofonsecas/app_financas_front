import 'package:app_financas/core/domain/entitys/movimento.dart';

class MovimentosPendentes {
  final int tipoMovimentoId;
  final List<Movimento> movimentos;

  MovimentosPendentes({
    required this.tipoMovimentoId,
    required this.movimentos,
  });

  double get valor {
    if (movimentos.isEmpty) {
      return 0.0;
    }

    return movimentos
        .map((e) => e.valor)
        .reduce((value, element) => value + element);
  }
}

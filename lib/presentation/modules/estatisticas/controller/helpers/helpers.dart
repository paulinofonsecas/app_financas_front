import 'package:app_financas/domain/entities/categoria_movimento.dart';

class CategoriaAndTotal {
  final Categoria categoria;
  final double total;

  CategoriaAndTotal(this.categoria, this.total);
}

class MovimentoAndDate {
  final DateTime dateTime;
  final double total;

  MovimentoAndDate(this.dateTime, this.total);

  @override
  String toString() {
    return 'MovimentoAndDate{movimento: $dateTime, total: $total}';
  }
}

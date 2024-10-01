import 'package:app_financas/presentation/modules/estatisticas/controller/helpers/calculos_periodo_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Recupera o ultimo domingo', () {
    final data = DateTime(2024, 09, 21);

    final result = Aux().ultimoDomingo(data);

    expect(result.day, 15);
    expect(result.weekday, DateTime.sunday);
  });

  test('Recupera o proximo domingo', () {
    final data = DateTime(2024, 10, 04);

    final result = (Aux().ultimoDomingo(data)).add(const Duration(days: 7));

    expect(result.day, 6);
    expect(result.weekday, DateTime.sunday);
  });
}

class Aux with CalculoPeiriodoMixin {}

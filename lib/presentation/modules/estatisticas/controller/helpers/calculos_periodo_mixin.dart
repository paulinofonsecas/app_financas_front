import 'package:app_financas/domain/entities/movimento.dart';
import 'package:app_financas/presentation/helders/periodo.dart';

import 'helpers.dart';

mixin CalculoPeiriodoMixin {
  dynamic calculateSumOfDay(
    List<Movimento> movements, {
    bool movimentoAndData = false,
  }) {
    return movimentoAndData
        ? calculateSumOfPeriod0(
            movements,
            DateTime.now(),
            isDay: true,
          )
        : calculateSumOfPeriod(
            movements,
            DateTime.now(),
            isDay: true,
          );
  }

  dynamic calculateSumOfWeek(
    List<Movimento> movements, {
    bool movimentoAndData = false,
  }) {
    return movimentoAndData
        ? calculateSumOfPeriod0(
            movements,
            DateTime.now(),
          )
        : calculateSumOfPeriod(
            movements,
            DateTime.now(),
          );
  }

  dynamic calculateSumOfMonth(
    List<Movimento> movements, {
    bool movimentoAndData = false,
  }) {
    return movimentoAndData
        ? calculateSumOfPeriod0(
            movements,
            DateTime.now(),
            isMonth: true,
          )
        : calculateSumOfPeriod(
            movements,
            DateTime.now(),
            isMonth: true,
          );
  }

  dynamic calculateSumOfSemester(
    List<Movimento> movements, {
    bool movimentoAndData = false,
  }) {
    return movimentoAndData
        ? calculateSumOfPeriod0(
            movements,
            DateTime.now(),
            isSemester: true,
          )
        : calculateSumOfPeriod(
            movements,
            DateTime.now(),
            isSemester: true,
          );
  }

  dynamic calculateSumOfYear(
    List<Movimento> movements, {
    bool movimentoAndData = false,
  }) {
    return movimentoAndData
        ? calculateSumOfPeriod0(
            movements,
            DateTime.now(),
            isYear: true,
          )
        : calculateSumOfPeriod(
            movements,
            DateTime.now(),
            isYear: true,
          );
  }

  int diasNoMes(int ano, int mes) {
    DateTime primeiroDiaDoProximoMes;
    if (mes < 12) {
      primeiroDiaDoProximoMes = DateTime(ano, mes + 1, 1);
    } else {
      primeiroDiaDoProximoMes = DateTime(ano + 1, 1, 1);
    }

    DateTime ultimoDiaDoMes =
        primeiroDiaDoProximoMes.subtract(const Duration(days: 1));

    return ultimoDiaDoMes.day;
  }

  DateTime ultimoDomingo(DateTime periodo) {
    if (periodo.weekday == DateTime.sunday) {
      return periodo;
    } else {
      DateTime saida = periodo.copyWith();

      while (saida.weekday != DateTime.sunday) {
        saida = saida.subtract(const Duration(days: 1));
      }

      return saida;
    }
  }

  List<Movimento> calculateSumOfPeriod(
    List<Movimento> movements,
    DateTime currentDate, {
    bool isMonth = false,
    bool isSemester = false,
    bool isYear = false,
    bool isDay = false,
  }) {
    DateTime startOfPeriod;
    DateTime endOfPeriod;

    if (isMonth) {
      startOfPeriod = DateTime(currentDate.year, currentDate.month, 1);
      endOfPeriod = startOfPeriod.add(
        Duration(days: diasNoMes(currentDate.year, currentDate.month)),
      );
    } else if (isSemester) {
      int semesterStartMonth = currentDate.month <= 6 ? 1 : 7;
      startOfPeriod = DateTime(currentDate.year, semesterStartMonth, 1);
      endOfPeriod = startOfPeriod.add(
        const Duration(days: 6 * 30),
      );
    } else if (isYear) {
      startOfPeriod = DateTime(currentDate.year, 1, 1);
      endOfPeriod = startOfPeriod.add(const Duration(days: 365));
    } else if (isDay) {
      startOfPeriod =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      endOfPeriod = startOfPeriod.add(const Duration(days: 1));
    } else {
      startOfPeriod = ultimoDomingo(currentDate);
      endOfPeriod = startOfPeriod.add(const Duration(days: 6));
    }

    List<Movimento> saida = [];

    for (var movement in movements) {
      if (movement.data.isAfter(startOfPeriod) &&
          movement.data.isBefore(endOfPeriod)) {
        saida.add(movement);
      }
    }

    return saida;
  }

  List<MovimentoAndDate> calculateSumOfPeriod0(
    List<Movimento> movimentos,
    DateTime currentDate, {
    bool isMonth = false,
    bool isSemester = false,
    bool isYear = false,
    bool isDay = false,
  }) {
    DateTime startOfPeriod;
    DateTime endOfPeriod;

    if (isMonth) {
      startOfPeriod = DateTime(currentDate.year, currentDate.month, 1);
      var diasMes = diasNoMes(currentDate.year, currentDate.month);
      endOfPeriod = startOfPeriod.add(
        Duration(days: diasMes),
      );
    } else if (isSemester) {
      int semesterStartMonth = currentDate.month <= 6 ? 1 : 7;
      startOfPeriod = DateTime(currentDate.year, semesterStartMonth, 1);
      endOfPeriod = startOfPeriod.add(
        const Duration(days: 6 * 30),
      );
    } else if (isYear) {
      startOfPeriod = DateTime(currentDate.year, 1, 1);
      endOfPeriod = startOfPeriod.add(const Duration(days: 365));
    } else if (isDay) {
      startOfPeriod =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      endOfPeriod = startOfPeriod.add(const Duration(days: 1));
    } else {
      startOfPeriod =
          DateTime(currentDate.year, currentDate.month, currentDate.day)
              .subtract(Duration(days: currentDate.weekday - 1));
      endOfPeriod = startOfPeriod.add(const Duration(days: 6));
    }

    Map<DateTime, List<Movimento>> groupedMovements = {};
    movimentos.sort((a, b) => b.data.compareTo(a.data));
    // var last = movimentos.first.data;

    // movimentos = movimentos.reversed.toList();
    // endOfPeriod = DateTime(last.year, last.month, last.day + 1);

    for (var movement in movimentos) {
      late DateTime movementDate;
      if (isDay) {
        movementDate = DateTime(
          movement.data.year,
          movement.data.month,
          movement.data.day,
          movement.data.hour,
          movement.data.minute,
          movement.data.second,
        );
      } else {
        if (isSemester) {
          movementDate = DateTime(
            movement.data.year,
            movement.data.month,
          );
        } else {
          movementDate = DateTime(
            movement.data.year,
            movement.data.month,
            movement.data.day,
          );
        }
      }

      if (movementDate
              .isAfter(startOfPeriod.subtract(const Duration(seconds: 1))) &&
          movementDate.isBefore(endOfPeriod)) {
        if (!groupedMovements.containsKey(movementDate)) {
          groupedMovements[movementDate] = [];
        }
        groupedMovements[movementDate]!.add(movement);
      }
    }

    List<MovimentoAndDate> saida = [];

    groupedMovements.forEach((date, movements) {
      double totalAmount = 0.0;

      for (var movement in movements) {
        totalAmount += movement.valor;
      }

      MovimentoAndDate mergedMovement = MovimentoAndDate(
        date,
        totalAmount,
      );

      saida.add(mergedMovement);
    });

    return saida;
  }

  List<Periodo> getPeriods(List<String> periodos) {
    return periodos
        .map((e) => Periodo(title: e, id: periodos.indexOf(e)))
        .toList();
  }
}

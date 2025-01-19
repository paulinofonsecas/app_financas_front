import 'package:app_financas/app/cubit/localization_cubit.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:intl/intl.dart';

NumberFormat get numberFormat {
  final locale = getIt<LocalizationCubit>().state.locale;

  if (locale.countryCode.toLowerCase() == 'ao') {
    return NumberFormat.currency(
      symbol: 'Kz',
      customPattern: 'Kz #,##0.00',
    );
  }

  return NumberFormat.currency(
    locale: locale.locale.toString(),
  );
}

DateFormat get dateFormat => DateFormat('dd MMM y')..add_Hm();

DateFormat dataFormatada = DateFormat("d 'de' MMMM 'de' y", "pt_BR");

DateFormat get messageDateFormat => DateFormat('MMM', 'pt_BR');

DateFormat get shortDateFormat => DateFormat('dd/MMM/yyyy');

DateFormat get verboseDateFormat => DateFormat('dd MMM y')..add_Hm();

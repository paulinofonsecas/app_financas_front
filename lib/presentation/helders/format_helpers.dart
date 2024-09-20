import 'package:intl/intl.dart';

NumberFormat get numberFormat => NumberFormat.currency(
      symbol: 'Kz',
      customPattern: 'Kz #,##0.00',
    );

DateFormat get dateFormat => DateFormat('dd MMM y')..add_Hm();

DateFormat dataFormatada = DateFormat("d 'de' MMMM 'de' y", "pt_BR");

DateFormat get messageDateFormat => DateFormat('MMM', 'pt_BR');

DateFormat get shortDateFormat => DateFormat('dd/MMM/yyyy');

DateFormat get verboseDateFormat => DateFormat('dd MMM y')..add_Hm();

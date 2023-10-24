import 'package:intl/intl.dart';

NumberFormat get numberFormat => NumberFormat.currency(symbol: 'Kz ');

DateFormat get dateFormat => DateFormat('dd/M/y')..add_Hm();

DateFormat get verboseDateFormat => DateFormat('dd/M/y')..add_Hm();

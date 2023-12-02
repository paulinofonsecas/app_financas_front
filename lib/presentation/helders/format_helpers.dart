import 'package:intl/intl.dart';

NumberFormat get numberFormat => NumberFormat.currency(symbol: 'Kz');

DateFormat get dateFormat => DateFormat('dd MMM y')..add_Hm();

DateFormat get shortDateFormat => DateFormat('dd/M/yy');

DateFormat get verboseDateFormat => DateFormat('dd MMM y')..add_Hm();

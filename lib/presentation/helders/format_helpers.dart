import 'package:intl/intl.dart';

NumberFormat get numberFormat => NumberFormat.currency(name: 'Kz');

DateFormat get dateFormat => DateFormat('dd MMM y')..add_Hm();

DateFormat get verboseDateFormat => DateFormat('dd MMM y')..add_Hm();

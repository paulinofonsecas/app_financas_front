import 'package:intl/intl.dart';

NumberFormat get numberFormat => NumberFormat.currency(
      symbol: 'Kz',
      customPattern: '#,##0.00 Kz',
    );

DateFormat get dateFormat => DateFormat('dd MMM y')..add_Hm();

DateFormat get messageDateFormat => DateFormat('MMM', 'pt_BR');

DateFormat get shortDateFormat => DateFormat('dd/M/yy');

DateFormat get verboseDateFormat => DateFormat('dd MMM y')..add_Hm();

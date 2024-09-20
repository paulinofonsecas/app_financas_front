import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/create_objectivo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class DataFinalField extends HookWidget {
  const DataFinalField({super.key});

  bool isToday(DateTime date) {
    final today = DateTime.now();
    return date.day == today.day &&
        date.month == today.month &&
        date.year == today.year;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateObjectivoBloc>();
    final dateState = useState(!isToday(bloc.objectivoModel.finalDate)
        ? bloc.objectivoModel.finalDate
        : DateTime.now().add(const Duration(days: 30)));

    return InkWell(
      onTap: () async {
        var date = await showOmniDateTimePicker(
          context: context,
          type: OmniDateTimePickerType.date,
          initialDate: dateState.value,
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );

        if (date == null) return;

        bloc.objectivoModel = bloc.objectivoModel.copyWith(
          finalDate: date,
        );

        dateState.value = date;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_outlined),
            const GutterSmall(),
            Expanded(
              child: Text(
                isToday(dateState.value)
                    ? 'Selecione a data limite'
                    : dataFormatada.format(dateState.value),
                style: GoogleFonts.inter().copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

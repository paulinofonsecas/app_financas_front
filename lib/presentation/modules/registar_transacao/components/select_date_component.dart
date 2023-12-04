import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/conta/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubit/confirmar_transacao_cubit.dart';

class SelectDateComponent extends StatelessWidget {
  const SelectDateComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var selectDataCubit = context.watch<SelectDataCubit>();

    return Row(
      children: [
        Expanded(
          child: BlocBuilder<SelectDataCubit, SelectDataState>(
            bloc: selectDataCubit,
            builder: (context, state) {
              if (state is SelectDataSuccess || state is SelectDataInitial) {
                return Text(
                  verboseDateFormat.format(state.date),
                  style: GoogleFonts.inter().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }

              return Text(
                'Ocorreu um erro',
                style: GoogleFonts.inter().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        ),
        const Gutter(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor:
                Theme.of(context).colorScheme.surfaceTint.withOpacity(.1),
          ),
          onPressed: () {
            var confirmarTransacaoCubit =
                context.read<ConfirmarTransacaoCubit>();

            selectDataCubit.selecionarDateTime(
              context,
              confirmarTransacaoCubit,
            );
          },
          child: const Text('Selecionar data'),
        ),
      ],
    );
  }
}

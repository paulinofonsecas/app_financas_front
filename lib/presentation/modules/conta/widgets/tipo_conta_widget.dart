import 'package:app_financas/presentation/modules/conta/bottom_sheets/tipo_conta_bottom_sheet.dart';
import 'package:app_financas/presentation/modules/conta/cubit/tipo_conta_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TipoContaWidget extends StatelessWidget {
  const TipoContaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TipoContaCubit>()..changeTipoConta(1);

    return BlocBuilder<TipoContaCubit, TipoContaState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is TipoContaChanged) {
          var tipoConta = cubit.getTipoContaById(state.tipoContaId);

          return ListTile(
            onTap: () {
              TipoContaBottomSheet.openModalBottomSheet(
                context: context,
                cubit: context.read<TipoContaCubit>(),
              );
            },
            title: Text(tipoConta.nome),
            leading: Icon(
              tipoConta.icon,
            ),
            trailing: const Icon(
              FontAwesomeIcons.chevronRight,
              size: 16,
            ),
          );
        }

        return ListTile(
          onTap: () {
            TipoContaBottomSheet.openModalBottomSheet(
              context: context,
              cubit: cubit,
            );
          },
          title: const Text(
            'Tipo de conta',
          ),
          leading: const Icon(
            FontAwesomeIcons.buildingColumns,
          ),
          trailing: const Icon(
            FontAwesomeIcons.chevronRight,
            size: 16,
          ),
        );
      },
    );
  }
}

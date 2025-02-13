import 'package:app_financas/presentation/modules/conta/cubit/mostrar_na_tela_inicial_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IncluirNaTelaInicialWidget extends StatelessWidget {
  const IncluirNaTelaInicialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MostrarNaTelaInicialCubit, MostrarNaTelaInicialState>(
      builder: (context, state) {
        return ListTile(
          onTap: () {
            context
                .read<MostrarNaTelaInicialCubit>()
                .changeMostrarNaTelaicial();
          },
          title: const Text(
            'Mostrar na tela inicial',
          ),
          leading: const Icon(
            FontAwesomeIcons.circleInfo,
          ),
          trailing: Switch(
            value: state.mostrarNaTelaicial,
            onChanged: (value) {
              context
                  .read<MostrarNaTelaInicialCubit>()
                  .changeMostrarNaTelaicial();
            },
          ),
        );
      },
    );
  }
}

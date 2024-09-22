import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/home/movimentos_pendentes/widgets/movimentos_pendentes_body.dart';

class MovimentosPendentesAbba extends StatelessWidget {
  const MovimentosPendentesAbba({super.key});

  @override
  Widget build(BuildContext context) {
    return const MovimentosPendentesView();
  }
}

class MovimentosPendentesView extends StatelessWidget {
  const MovimentosPendentesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        //! Atualiza em funcao de um novo cadastro
        BlocListener<RegistarTransacaoBloc, RegistarTransacaoState>(
          listener: (context, state) {
            getIt<MovimentosPendentesBloc>()
                .add(const LoadMovimentosPendentesEvent());
          },
        ),
      ],
      child: const MovimentosPendentesBody(),
    );
  }
}

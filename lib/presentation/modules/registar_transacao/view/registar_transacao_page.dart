import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/cubit/select_conta_cubit.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/deletar_transacao_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/widgets/registrar_transacao_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../bloc/registar_transacao_bloc.dart';
import '../cubit/confirmar_transacao_cubit.dart';
import '../cubit/descricao_text_cubit.dart';
import '../cubit/obs_text_cubit.dart';
import '../cubit/select_data_cubit.dart';
import '../cubit/switch_transacao_cubit.dart';
import '../cubit/valor_transacao_cubit.dart';

class RegistarTransacaoPage extends StatelessWidget {
  const RegistarTransacaoPage({
    super.key,
    required this.movimentoType,
    this.movimento,
    this.contaId,
  });

  final Movimento? movimento;
  final int movimentoType;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    if (movimento != null) {
      Get.put<Movimento>(movimento!);
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DeleteTransacaoCubit(getIt()),
        ),
        BlocProvider(
          create: (context) =>
              SwitchTransacaoCubit(movimento?.tipoMovimentoId ?? movimentoType),
        ),
        BlocProvider(
          create: (context) => ValorTransacaoCubit(movimento?.valor),
        ),
        BlocProvider(
          create: (context) => ConfirmarTransacaoCubit(movimento?.confirmado),
        ),
        BlocProvider(
          create: (context) => SelectDataCubit(movimento?.data),
        ),
        BlocProvider(
          create: (context) => DescricaoTextCubit(movimento?.descricao),
        ),
        BlocProvider(
          create: (context) =>
              SelectCategoriaCubit(movimento?.categoria?.copyWith(
            subCategoria: movimento?.subCategoria,
          )),
        ),
        BlocProvider(
          create: (context) => SelectContaCubit(movimento?.cartaoId ?? contaId),
        ),
        BlocProvider(
          create: (context) => ObsTextCubit(movimento?.obsMovimento),
        ),
      ],
      child: RegistarTransacaoView(
        movimentoType: movimentoType,
        contaId: contaId,
      ),
    );
  }
}

class RegistarTransacaoView extends StatelessWidget {
  const RegistarTransacaoView({
    super.key,
    required this.movimentoType,
    this.contaId,
  });

  final int movimentoType;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    var switchCubit = context.watch<SwitchTransacaoCubit>();
    var isEntrada = switchCubit.state is SwitchTransacaoEntrada;

    return MultiBlocListener(
      listeners: [
        BlocListener<RegistarTransacaoBloc, RegistarTransacaoState>(
          listener: (context, state) {
            if (state is RegistarTransacaoSuccess) {
              Navigator.pop(context);
            }

            if (state is RegistarTransacaoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ocorreu um erro ao registrar a transação.'),
                ),
              );
            }
          },
        ),
        BlocListener<DeleteTransacaoCubit, DeleteTransacaoState>(
          listener: (context, state) {
            if (state is DeleteTransacaoSuccess) {
              Navigator.pop(context, true);
            }

            if (state is DeleteTransacaoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ocorreu um erro ao deletar a transação.'),
                ),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<RegistarTransacaoBloc, RegistarTransacaoState>(
        builder: (context, state) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: isEntrada ? kVerdeColor : kVermelhaColor,
                brightness: Theme.of(context).brightness,
              ),
            ),
            child: RegistarTransacaoBody(contaId: contaId),
          );
        },
      ),
    );
  }
}

import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:app_financas/presentation/modules/registar_transacao/bloc/registar_transacao_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'package:app_financas/presentation/modules/registar_transacao/components/body.dart';
import 'package:app_financas/constants.dart';

import 'controllers/registar_transacao_controller.dart';
import 'cubit/confirmar_transacao_cubit.dart';
import 'cubit/descricao_text_cubit.dart';
import 'cubit/select_data_cubit.dart';
import 'cubit/switch_transacao_cubit.dart';
import 'cubit/valor_transacao_cubit.dart';

class RegistarTransacaoPage extends StatelessWidget {
  const RegistarTransacaoPage({
    super.key,
    required this.movimentoType,
    this.contaId,
  });

  final int movimentoType;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConfirmarTransacaoCubit(),
        ),
        BlocProvider(
          create: (context) => SwitchTransacaoCubit(),
        ),
        BlocProvider(
          create: (context) => ValorTransacaoCubit(),
        ),
        BlocProvider(
          create: (context) => SelectDataCubit(),
        ),
        BlocProvider(
          create: (context) => DescricaoTextCubit(),
        ),
      ],
      child: _RegistarTransacaoView(
        movimentoType: movimentoType,
        contaId: contaId,
      ),
    );
  }
}

class _RegistarTransacaoView extends StatelessWidget {
  const _RegistarTransacaoView({
    Key? key,
    required this.movimentoType,
    this.contaId,
  }) : super(key: key);

  final int movimentoType;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegistarTransacaoController(
      movimentoType: movimentoType,
    ));

    return Builder(builder: (context) {
      var switchCubit = context.watch<SwitchTransacaoCubit>();
      var isEntrada = switchCubit.state is SwitchTransacaoEntrada;

      return Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: isEntrada ? kVerdeColor : kVermelhaColor,
            brightness: Theme.of(context).brightness,
          ),
        ),
        child: _BodySection(
          controller: controller,
          contaId: contaId,
        ),
      );
    });
  }
}

class _BodySection extends StatelessWidget {
  const _BodySection({
    required this.controller,
    required this.contaId,
  });

  final RegistarTransacaoController controller;
  final int? contaId;

  @override
  Widget build(BuildContext context) {
    var switchCubit = context.watch<SwitchTransacaoCubit>();
    var isEntrada = switchCubit.state is SwitchTransacaoEntrada;
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? Theme.of(context).colorScheme.shadow
          : isEntrada
              ? kVerdeColor
              : kVermelhaColor,
      body: SafeArea(
        bottom: false,
        child: _RegistarTransacaoBody(
          contaId: contaId,
          controller: controller,
        ),
      ),
    );
  }
}

class _RegistarTransacaoBody extends StatelessWidget {
  const _RegistarTransacaoBody({
    required this.contaId,
    required this.controller,
  });

  final int? contaId;
  final RegistarTransacaoController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Body(contaId: contaId),
        const _SalvarActionButton(),
      ],
    );
  }
}

class _SalvarActionButton extends StatelessWidget {
  const _SalvarActionButton();

  @override
  Widget build(BuildContext context) {
    var switchCubit = context.watch<SwitchTransacaoCubit>();
    var isEntrada = switchCubit.state is SwitchTransacaoEntrada;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultActionButton(
            text: 'Salvar',
            backgroundColor: isEntrada ? kVerdeForteColor : kVermelhaForteColor,
            foregroundColor: Colors.white,
            onPressed: () {
              // context.read<RegistarTransacaoBloc>().add(SaveTransacaoEvent());
            },
          ),
          const GutterLarge(),
        ],
      ),
    );
  }
}

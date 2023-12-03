import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'package:app_financas/presentation/modules/registar_transacao/components/body.dart';
import 'package:app_financas/constants.dart';

import 'controllers/registar_transacao_controller.dart';
import 'cubit/confirmar_transacao_cubit.dart';
import 'cubit/switch_transacao_cubit.dart';

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
    return RegistarTransacaoView(
      movimentoType: movimentoType,
      contaId: contaId,
    );
  }
}

class RegistarTransacaoView extends StatelessWidget {
  const RegistarTransacaoView({
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

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConfirmarTransacaoCubit(),
        ),
        BlocProvider(
          create: (context) => SwitchTransacaoCubit(),
        ),
      ],
      child: Builder(builder: (context) {
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
      }),
    );
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
        _BuildActionButton(
          movimentoType: controller.movimentoType,
          controller: controller,
        ),
      ],
    );
  }
}

class _BuildActionButton extends StatelessWidget {
  const _BuildActionButton({
    required this.movimentoType,
    required this.controller,
  });

  final int movimentoType;
  final RegistarTransacaoController controller;

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
            onPressed: () async {
              await controller.finalizarMovimento();
              if (controller.salvo) {
                Get.back(closeOverlays: true);
              }
            },
          ),
          const GutterLarge(),
        ],
      ),
    );
  }
}

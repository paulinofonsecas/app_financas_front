import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/conta/bloc/conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta/bottom_sheets/conta_bottom_sheet.dart';
import 'package:app_financas/presentation/modules/conta/cubit/conta_mostrar_na_tela_inicial_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../dialogs/reajustar_saldo_dialog.dart';

class ContaMonstDetailsPage extends StatelessWidget {
  const ContaMonstDetailsPage({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: conta.color,
          brightness: Theme.of(context).brightness,
        ),
      ),
      child: ContentView(
        conta: conta,
      ),
    );
  }
}

class ContentView extends StatelessWidget {
  const ContentView({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode
          ? Theme.of(context).colorScheme.shadow
          : Theme.of(context).primaryColor,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ContaBloc, GContaState>(
          buildWhen: (prev, state) => state is ListarContasSuccess,
          builder: (context, state) {
            if (state is ListarContasSuccess) {
              var contas = state.contas;
              var newConta = contas.firstWhere(
                  (element) => element.id == conta.id,
                  orElse: () => conta);
              return ContaDetailsBody(conta: newConta);
            } else {
              return ContaDetailsBody(conta: conta);
            }
          },
        ),
      ),
    );
  }
}

class ContaDetailsBody extends StatelessWidget {
  const ContaDetailsBody({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContaDetailsHeader(
          conta: conta,
        ),
        const Gutter(),
        Expanded(
          child: _ContaDetailsContent(conta: conta),
        )
      ],
    );
  }
}

class _ContaDetailsContent extends StatelessWidget {
  const _ContaDetailsContent({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding,
        ),
        child: Column(
          children: [
            const Gutter(),
            _MainInfoWidget(conta: conta),
            const GutterLarge(),
            const Gutter(),
            _FirstRowWidget(conta: conta),
            const GutterLarge(),
            _SecondRow(conta: conta),
            const GutterLarge(),
            _MostrarNaTelaInicialWidget(conta: conta)
          ],
        ),
      ),
    );
  }
}

class _MostrarNaTelaInicialWidget extends StatelessWidget {
  const _MostrarNaTelaInicialWidget({required this.conta});

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContaMostrarNaTelaInicialCubit,
        ContaMostrarNaTelaInicialState>(
      bloc: context.read<ContaMostrarNaTelaInicialCubit>()..revelState(conta),
      buildWhen: (prev, state) => prev.value != state.value,
      builder: (context, state) {
        return ListTile(
          onTap: () {
            context
                .read<ContaMostrarNaTelaInicialCubit>()
                .changeMostrarNaTelaicial(conta);
          },
          title: const Text(
            'Mostrar na tela inicial',
          ),
          leading: const Icon(
            FontAwesomeIcons.circleInfo,
          ),
          trailing: Switch(
            value: state.value,
            onChanged: (value) {
              context
                  .read<ContaMostrarNaTelaInicialCubit>()
                  .changeMostrarNaTelaicial(conta);
            },
          ),
        );
      },
    );
  }
}

class _SecondRow extends StatelessWidget {
  const _SecondRow({
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ContaInforWidget(
            icon: const Icon(
              CupertinoIcons.sort_down,
              color: kVermelhaColor,
            ),
            title: 'Qtd de despesas',
            subtitleColor: kVermelhaColor,
            subtitle: '${conta.totalDespesas} despesas',
          ),
        ),
        const Gutter(),
        Expanded(
          child: _ContaInforWidget(
            icon: const Icon(
              CupertinoIcons.sort_up,
              color: kVerdeColor,
            ),
            title: 'Qtd de receitas',
            subtitleColor: kVerdeColor,
            subtitle: '${conta.totalReceitas} receitas',
          ),
        ),
      ],
    );
  }
}

class _FirstRowWidget extends StatelessWidget {
  const _FirstRowWidget({
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ContaInforWidget(
            icon: Icon(conta.tipoConta.icon, size: 18),
            title: 'Tipo da conta',
            subtitle: conta.tipoConta.nome,
          ),
        ),
        const Gutter(),
        Expanded(
          child: _ContaInforWidget(
            icon: const Icon(FontAwesomeIcons.genderless),
            title: 'Saldo inicial',
            subtitle: numberFormat.format(conta.saldoInicial),
          ),
        ),
      ],
    );
  }
}

class _MainInfoWidget extends StatelessWidget {
  const _MainInfoWidget({
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Saldo atual',
          style: GoogleFonts.inter(
            fontSize: 12,
          ),
        ),
        const GutterSmall(),
        Text(
          numberFormat.format(conta.saldo),
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Gutter(),
        DefaultActionButton(
          text: 'Reajustar',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.all(kDefaultPadding),
                  content: ReajustarSaldoDialog(
                    conta: conta,
                  ),
                );
              },
            );
          },
          backgroundColor: kVerdeColor,
        ),
      ],
    );
  }
}

class _ContaInforWidget extends StatelessWidget {
  const _ContaInforWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  });

  final Icon icon;
  final String title;
  final String subtitle;
  final Color? subtitleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        const GutterSmall(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const GutterTiny(),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ContaDetailsHeader extends StatelessWidget {
  const _ContaDetailsHeader({
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding / 2,
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Spacer(),
            Text(
              conta.nome,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                ContaBottomSheet.show(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

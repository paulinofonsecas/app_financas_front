// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors

import 'package:app_financas/presentation/modules/carteira/cubit/contas_cubit.dart';
import 'package:app_financas/presentation/modules/conta/bloc/conta_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';

import '../cubit/reajustar_saldo_cubit.dart';
import '../dialogs/reajustar_saldo_dialog.dart';

class ContaMonstDetailsPage extends StatelessWidget {
  const ContaMonstDetailsPage({
    Key? key,
    required this.conta,
  }) : super(key: key);

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? Theme.of(context).colorScheme.shadow : kVerdeColor,
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
    Key? key,
    required this.conta,
  }) : super(key: key);

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContaDetailsHeader(
          conta: conta,
        ),
        Gutter(),
        Expanded(
          child: _ContaDetailsContent(conta: conta),
        )
      ],
    );
  }
}

class _ContaDetailsContent extends StatelessWidget {
  const _ContaDetailsContent({
    Key? key,
    required this.conta,
  }) : super(key: key);

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
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding,
        ),
        child: Column(
          children: [
            Gutter(),
            _MainInfoWidget(conta: conta),
            GutterLarge(),
            Gutter(),
            Row(
              children: [
                Expanded(
                  child: _ContaInforWidget(
                    icon: Icon(conta.tipoConta.icon, size: 18),
                    title: 'Tipo da conta',
                    subtitle: conta.tipoConta.nome,
                  ),
                ),
                Gutter(),
                Expanded(
                  child: _ContaInforWidget(
                    icon: Icon(FontAwesomeIcons.genderless),
                    title: 'Saldo inicial',
                    subtitle: numberFormat.format(conta.saldoInicial),
                  ),
                ),
              ],
            ),
            GutterLarge(),
            Row(
              children: [
                Expanded(
                  child: _ContaInforWidget(
                    icon: Icon(
                      CupertinoIcons.sort_down,
                      color: kVermelhaColor,
                    ),
                    title: 'Qtd de despesas',
                    subtitleColor: kVermelhaColor,
                    subtitle: '${conta.totalDespesas} despesas',
                  ),
                ),
                Gutter(),
                Expanded(
                  child: _ContaInforWidget(
                    icon: Icon(
                      CupertinoIcons.sort_up,
                      color: kVerdeColor,
                    ),
                    title: 'Qtd de receitas',
                    subtitleColor: kVerdeColor,
                    subtitle: '${conta.totalReceitas} receitas',
                  ),
                ),
              ],
            ),
            GutterLarge(),
            // SwitchListTile(
            //   value: true,
            //   onChanged: (v) {},
            //   activeColor: kVerdeColor,
            //   title: Text(
            //     'Mostrar na tela inicial',
            //     style: GoogleFonts.inter(
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
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
        GutterSmall(),
        Text(
          numberFormat.format(conta.saldo),
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gutter(),
        DefaultActionButton(
          text: 'Reajustar',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(kDefaultPadding),
                  content: BlocProvider(
                    create: (context) => ReajustarSaldoCubit(),
                    child: ReajustarSaldoDialog(
                      conta: conta,
                    ),
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
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
  }) : super(key: key);

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
            GutterTiny(),
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
              icon: Icon(
                FontAwesomeIcons.scaleBalanced,
                color: Colors.white,
                size: 18,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:app_financas/presentation/components/default_money_textfield.dart';
import 'package:app_financas/presentation/modules/conta/bottom_sheets/intituicoes_fin_bottom_sheet.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_picker_widget.dart';

class CreateContaBody extends StatelessWidget {
  const CreateContaBody({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? Theme.of(context).colorScheme.shadow
          : Theme.of(context).primaryColor,
      body: const SafeArea(
        bottom: false,
        child: Column(
          children: [
            _HeaderWidget(),
            _SaldoTextFieldWidget(),
            _MainContentWidget(),
          ],
        ),
      ),
    );
  }
}

class _SaldoTextFieldWidget extends StatelessWidget {
  const _SaldoTextFieldWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saldo atual na conta',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                const _SaldoWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Cancelar',
              style: GoogleFonts.inter(
                color: Colors.white,
              ),
            ),
          ),
          const Spacer(),
          Text(
            'Nova conta',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              'Cancelar',
              style: GoogleFonts.inter(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SaldoWidget extends StatelessWidget {
  const _SaldoWidget();

  @override
  Widget build(BuildContext context) {
    return DefaultMoneyTextField(
      controller: TextEditingController(),
      onChanged: (value) {},
    );
  }
}

class _MainContentWidget extends StatelessWidget {
  const _MainContentWidget();

  @override
  Widget build(BuildContext context) {
    final heightPadding = MediaQuery.of(context).viewPadding.bottom;

    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                const _InstituicaoFinanceiraWidget(),
                const Divider(),
                const _DescriptionTextFieldWidget(),
                const Divider(),
                const _TipoContaWidget(),
                const Divider(),
                const _CorContaWidget(),
                const Divider(),
                const _IncluirNaTelaInicialWidget(),
                const Divider(),
                const GutterLarge(),
                const _BotaoSalvarWidget(),
                SizedBox(height: heightPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InstituicaoFinanceiraWidget extends StatelessWidget {
  const _InstituicaoFinanceiraWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstituicaoFinanceiraCubit, InstituicaoFinanceiraState>(
      buildWhen: (p, current) => current is InstituicaoFinanceiraSelecionada,
      builder: (context, state) {
        late Banco banco;

        if (state is InstituicaoFinanceiraInitial) {
          return ListTile(
            onTap: () {
              InstitFinBottomSheet.openModalBottomSheet(context: context);
            },
            title: const Text(
              'Instituição financeira',
            ),
            leading: const Icon(
              FontAwesomeIcons.building,
            ),
            trailing: const Icon(
              FontAwesomeIcons.chevronRight,
              size: 16,
            ),
          );
        }

        if (state is InstituicaoFinanceiraSelecionada) {
          banco = state.banco;

          return BancoListItem(
            onTap: () {
              InstitFinBottomSheet.openModalBottomSheet(context: context);
            },
            banco: banco,
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _DescriptionTextFieldWidget extends StatelessWidget {
  const _DescriptionTextFieldWidget();

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: 'Descrição',
        hintStyle: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Icon(
          FontAwesomeIcons.fileLines,
          size: 20,
        ),
      ),
    );
  }
}

class _TipoContaWidget extends StatelessWidget {
  const _TipoContaWidget();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
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
  }
}

class _CorContaWidget extends StatelessWidget {
  const _CorContaWidget();

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('Cor'),
      subtitle: ColorPickerWidget(),
      leading: Icon(FontAwesomeIcons.palette),
      trailing: Icon(FontAwesomeIcons.chevronRight, size: 16),
    );
  }
}

class _IncluirNaTelaInicialWidget extends StatelessWidget {
  const _IncluirNaTelaInicialWidget();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: const Text(
        'Mostrar na tela inicial',
      ),
      leading: const Icon(
        FontAwesomeIcons.circleInfo,
      ),
      trailing: Switch(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}

class _BotaoSalvarWidget extends StatelessWidget {
  const _BotaoSalvarWidget();

  @override
  Widget build(BuildContext context) {
    return DefaultActionButton(
      onPressed: () {},
      text: 'Salvar',
    );
  }
}

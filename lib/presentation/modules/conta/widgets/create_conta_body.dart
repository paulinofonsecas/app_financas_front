// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/presentation/modules/conta/bloc/create_conta_bloc.dart';
import 'package:app_financas/presentation/modules/conta/cubit/create_conta_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/mostrar_na_tela_inicial_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/saldo_inicial_text_cubit.dart';
import 'package:app_financas/presentation/modules/conta/cubit/tipo_conta_cubit.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:app_financas/presentation/components/default_money_textfield.dart';
import 'package:app_financas/presentation/modules/conta/bottom_sheets/intituicoes_fin_bottom_sheet.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:intl/intl.dart';

import '../bottom_sheets/tipo_conta_bottom_sheet.dart';
import 'color_picker_widget.dart';

class CreateContaBody extends StatelessWidget {
  const CreateContaBody({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<CreateContaBloc, CreateContaState>(
      listener: (context, state) {
        if (state is CreateContaSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
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

class _SaldoWidget extends StatefulWidget {
  const _SaldoWidget();

  @override
  State<_SaldoWidget> createState() => _SaldoWidgetState();
}

class _SaldoWidgetState extends State<_SaldoWidget> {
  final CurrencyTextInputFormatter _formatter = CurrencyTextInputFormatter(
    NumberFormat.currency(symbol: 'Kz'),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultMoneyTextField(
      onChanged: (value) {
        context
            .read<SaldoInicialTextCubit>()
            .onTextChange(_formatter.getUnformattedValue().toString());
      },
      textInputFormatter: _formatter,
    );
  }
}

class _MainContentWidget extends StatefulWidget {
  const _MainContentWidget();

  @override
  State<_MainContentWidget> createState() => _MainContentWidgetState();
}

class _MainContentWidgetState extends State<_MainContentWidget> {
  // final TextEditingController descricaoController = TextEditingController();
  final TextEditingController nomeController = TextEditingController();

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
                _NomeTextFieldWidget(
                  textController: nomeController,
                ),
                const Divider(),
                // _DescriptionTextFieldWidget(
                //   textController: descricaoController,
                // ),
                // const Divider(),
                const _TipoContaWidget(),
                const Divider(),
                const _CorContaWidget(),
                const Divider(),
                const _IncluirNaTelaInicialWidget(),
                const Divider(),
                const GutterLarge(),
                _BotaoSalvarWidget(onTap: () {
                  var createContaBloc = context.read<CreateContaBloc>();

                  createContaBloc.add(GravarContaEvent(
                    context: context,
                    nomeConta: nomeController.text,
                  ));
                }),
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
              InstitFinBottomSheet.openModalBottomSheet(
                context: context,
                cubit: context.read<InstituicaoFinanceiraCubit>(),
              );
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
              InstitFinBottomSheet.openModalBottomSheet(
                context: context,
                cubit: context.read<InstituicaoFinanceiraCubit>(),
              );
            },
            banco: banco,
          );
        }

        return ListTile(
          onTap: () {
            InstitFinBottomSheet.openModalBottomSheet(
              context: context,
              cubit: context.read<InstituicaoFinanceiraCubit>(),
            );
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
      },
    );
  }
}

class _NomeTextFieldWidget extends StatelessWidget {
  const _NomeTextFieldWidget({
    Key? key,
    required this.textController,
  }) : super(key: key);

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: TextField(
        controller: textController,
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: 'Nome da conta',
          hintStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          prefixIcon: const Icon(
            FontAwesomeIcons.fileSignature,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _TipoContaWidget extends StatelessWidget {
  const _TipoContaWidget();

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

class _CorContaWidget extends StatelessWidget {
  const _CorContaWidget();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<CreateContaThemeCubit>(),
      child: const ListTile(
        title: Text('Cor'),
        subtitle: ColorPickerWidget(),
        leading: Icon(FontAwesomeIcons.palette),
        trailing: Icon(FontAwesomeIcons.chevronRight, size: 16),
      ),
    );
  }
}

class _IncluirNaTelaInicialWidget extends StatelessWidget {
  const _IncluirNaTelaInicialWidget();

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

class _BotaoSalvarWidget extends StatelessWidget {
  const _BotaoSalvarWidget({required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DefaultActionButton(
      onPressed: onTap,
      text: 'Salvar',
    );
  }
}

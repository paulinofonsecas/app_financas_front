// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/presentation/components/my_divider.dart';
import 'package:app_financas/presentation/components/with_icon.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:app_financas/presentation/modules/registar_transacao/components/select_date_component.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/switch_transacao_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../carteira/components/conta_listitem_component.dart';
import '../cubit/confirmar_transacao_cubit.dart';
import '../cubit/descricao_text_cubit.dart';
import '../cubit/obs_text_cubit.dart';
import '../cubit/select_data_cubit.dart';
import 'category_list_item_component.dart';
import 'register_despesa_header.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    this.contaId,
  });

  final int? contaId;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          RegisterHeader(),
          _MainContentWidget(),
        ],
      ),
    );
  }
}

class _MainContentWidget extends StatelessWidget {
  const _MainContentWidget();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(
        minHeight: size.height * .9,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const GutterLarge(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _ConfirmarTransacaoWidget(),
                const GutterSmall(),
                const MyDivider(),
                const GutterSmall(),
                const WithIcon(
                  icon: Icons.calendar_today_outlined,
                  child: SelectDateComponent(),
                ),
                const GutterSmall(),
                const MyDivider(),
                const GutterSmall(),
                const WithIcon(
                  icon: Icons.create_rounded,
                  child: _DecricaoTestWidget(),
                ),
                const GutterSmall(),
                const MyDivider(),
                const Gutter(),
                BlocBuilder<SelectCategoriaCubit, SelectCategoriaState>(
                  builder: (context, state) {
                    late IconData icon;

                    if (state is SelectCategoriaChanged) {
                      icon =
                          state.categoria.icon ?? FontAwesomeIcons.layerGroup;
                    } else {
                      icon = FontAwesomeIcons.layerGroup;
                    }

                    return WithIcon(
                      icon: icon,
                      color: state is SelectCategoriaChanged
                          ? state.categoria.color
                          : null,
                      child: const CategoryListItemComponent(),
                    );
                  },
                ),
                const Gutter(),
                const MyDivider(),
                const Gutter(),
                const WithIcon(
                  icon: FontAwesomeIcons.creditCard,
                  child: ContaListItemComponent(),
                ),
                const Gutter(),
                const MyDivider(),
                const GutterSmall(),
                const _ObsWidget(), // Observações
                const GutterSmall(),
                const MyDivider(),
                const GutterLarge(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ObsWidget extends StatelessWidget {
  const _ObsWidget();

  @override
  Widget build(BuildContext context) {
    var obsTextCubit = context.read<ObsTextCubit>();

    return WithIcon(
      icon: FontAwesomeIcons.clipboard,
      child: TextField(
        onChanged: (v) => obsTextCubit.changeText(v),
        maxLines: 1,
        decoration: const InputDecoration(
          hintText: 'Observações',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _DecricaoTestWidget extends StatelessWidget {
  const _DecricaoTestWidget();

  @override
  Widget build(BuildContext context) {
    var descricaoTextCubit = context.read<DescricaoTextCubit>();

    return TextField(
      onChanged: (valor) => descricaoTextCubit.changeText(valor),
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        hintText: 'Descrição',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

class _ConfirmarTransacaoWidget extends StatelessWidget {
  const _ConfirmarTransacaoWidget();

  @override
  Widget build(BuildContext context) {
    var confirmarTransCubit = context.read<ConfirmarTransacaoCubit>();

    void onPressed() {
      var selectDataCubit = context.read<SelectDataCubit>();
      var switchTransCubit = context.read<SwitchTransacaoCubit>();
      var isEntrada = switchTransCubit.state is SwitchTransacaoEntrada;

      if (selectDataCubit.state.date.isAfter(DateTime.now())) {
        showErrorMessage(
          'Impossível confirmar',
          'Aguarde até a data selecionada para confirmar '
              'a ${isEntrada ? 'receita' : 'despesa'} '
              'ou selecione uma data igual ou inferior a de hoje.',
          duration: const Duration(seconds: 7),
          backgroundColor: Colors.orange[700],
        );
      } else {
        confirmarTransCubit.changeConfirmarTransacao();
      }
    }

    return Row(
      children: [
        const Icon(Icons.check_circle_outlined),
        const Gutter(),
        BlocBuilder<SwitchTransacaoCubit, SwitchTransacaoState>(
          builder: (context, state) {
            var isEntrada = state is SwitchTransacaoEntrada;

            return Text(
              isEntrada ? 'Recebido' : 'Pago',
            );
          },
        ),
        const Spacer(),
        BlocBuilder<ConfirmarTransacaoCubit, ConfirmarTransacaoState>(
          builder: (context, state) {
            return Switch(
              value: state.isTransacaoConfirmad,
              onChanged: (c) => onPressed(),
            );
          },
        ),
      ],
    );
  }
}

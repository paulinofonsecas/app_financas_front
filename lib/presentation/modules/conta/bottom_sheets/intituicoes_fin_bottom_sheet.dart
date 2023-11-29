// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:flutter/material.dart';

import 'package:app_financas/core/domain/entitys/banco.dart';
import 'package:app_financas/presentation/modules/conta/conta.dart';
import 'package:app_financas/presentation/modules/conta/cubit/instituicao_financeira_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InstitFinBottomSheet extends StatefulWidget {
  const InstitFinBottomSheet({
    super.key,
  });

  static Future<dynamic> openModalBottomSheet({
    required BuildContext context,
  }) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: false,
      constraints: BoxConstraints.expand(
        height: size.height * 0.5,
      ),
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: locator<InstituicaoFinanceiraCubit>(),
          child: const InstitFinBottomSheet(),
        );
      },
    );
  }

  @override
  State<InstitFinBottomSheet> createState() => _InstitFinBottomSheetState();
}

class _InstitFinBottomSheetState extends State<InstitFinBottomSheet> {
  late final InstituicaoFinanceiraCubit _instCubit;

  @override
  void initState() {
    _instCubit = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InstituicaoFinanceiraCubit, InstituicaoFinanceiraState>(
      bloc: _instCubit..listBancos(),
      buildWhen: (previous, current) =>
          current is! InstituicaoFinanceiraSelecionada,
      builder: (context, state) {
        if (state is InstituicaoFinanceiraLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is InstituicaoFinanceiraError) {
          return const Center(
            child: Text('Ocorreu um erro ao listar os bancos'),
          );
        }

        if (state is InstituicaoFinanceiraSuccess) {
          var bancos = state.bancos;

          return ListView.builder(
            itemCount: bancos.length,
            itemBuilder: (c, i) {
              return BancoListItem(
                banco: bancos[i],
                onTap: () {
                  _instCubit.selecionarBanco(bancos[i]);
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class BancoListItem extends StatelessWidget {
  const BancoListItem({
    super.key,
    required this.banco,
    this.onTap,
  });

  final Banco banco;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading:
          banco.imgAsset != null ? _buildImageWidget() : _buildDefaultIcon(),
      title: Text(
        banco.acronimo ?? banco.nome,
      ),
      subtitle: banco.acronimo != null ? Text(banco.nome) : null,
      trailing: const Icon(
        FontAwesomeIcons.chevronRight,
        size: 16,
      ),
    );
  }

  SizedBox _buildDefaultIcon() {
    return const SizedBox(
      width: 32,
      height: 32,
      child: Icon(FontAwesomeIcons.buildingColumns),
    );
  }

  Widget _buildImageWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: Image.asset(
        banco.imgAsset!,
        width: 32,
        height: 32,
        fit: BoxFit.cover,
      ),
    );
  }
}

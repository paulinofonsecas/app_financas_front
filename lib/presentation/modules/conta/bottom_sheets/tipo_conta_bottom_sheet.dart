// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/tipo_conta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tipo_conta_cubit.dart';

class TipoContaBottomSheet extends StatefulWidget {
  const TipoContaBottomSheet({
    Key? key,
  }) : super(key: key);

  static Future<dynamic> openModalBottomSheet({
    required BuildContext context,
    required TipoContaCubit cubit,
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
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const TipoContaBottomSheet(),
      ),
    );
  }

  @override
  State<TipoContaBottomSheet> createState() => _TipoContaBottomSheetState();
}

class _TipoContaBottomSheetState extends State<TipoContaBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TipoContaCubit>();
    var tipoContas = TipoConta.tipoContas;
    return ListView.separated(
      itemCount: tipoContas.length,
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: kDefaultPadding,
        endIndent: kDefaultPadding,
      ),
      itemBuilder: (context, index) {
        var tipoConta = tipoContas[index];

        return ListTile(
          onTap: () {
            cubit.changeTipoConta(tipoConta.id);
            Navigator.pop(context);
          },
          title: Text(tipoConta.nome),
          leading: Icon(
            tipoConta.icon,
          ),
        );
      },
    );
  }
}

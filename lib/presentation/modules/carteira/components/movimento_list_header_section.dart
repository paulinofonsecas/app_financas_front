import 'package:app_financas/presentation/modules/carteira/cubit/change_tipo_movimento_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'my_text_filter.dart';

class HeaderMovimentoSection extends StatelessWidget {
  const HeaderMovimentoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ChangeTipoMovimentoCubit>().state;

    return Hero(
      tag: 'header_movimento',
      child: Material(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            MyTextFilter(
              title: 'Tudo',
              isActive: state.index == 0,
              onTap: () {
                context.read<ChangeTipoMovimentoCubit>().updateTipoMovimento(0);
              },
            ),
            const GutterTiny(),
            MyTextFilter(
              title: 'Saídas',
              isActive: state.index == 2,
              onTap: () {
                context.read<ChangeTipoMovimentoCubit>().updateTipoMovimento(2);
              },
            ),
            const GutterTiny(),
            MyTextFilter(
              title: 'Entrada',
              isActive: state.index == 1,
              onTap: () {
                context.read<ChangeTipoMovimentoCubit>().updateTipoMovimento(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circle_info.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({super.key, required this.movimento});

  final Movimento movimento;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleInfo(
          icon: Icon(
            movimento.confirmado
                ? CupertinoIcons.checkmark_alt
                : CupertinoIcons.pin,
            color: Colors.white,
          ),
          backgroundColor:
              movimento.confirmado ? kVerdeAccentColor : kVermelhaColor,
          title: isReceita(movimento.tipoMovimentoId)
              ? movimento.confirmado
                  ? 'Recebido'
                  : 'Não foi recebido'
              : movimento.confirmado
                  ? 'Pago'
                  : 'Não foi pago',
        ),
        CircleInfo(
          icon: Icon(
            movimento.tipoMovimentoId == 1
                ? CupertinoIcons.arrow_up
                : CupertinoIcons.arrow_down,
            color: Colors.white,
          ),
          backgroundColor:
              movimento.tipoMovimentoId == 1 ? kVerdeColor : kVermelhaColor,
          title: movimento.tipoMovimentoId == 1 ? 'Receita' : 'Despesa',
        ),
        // const CircleInfo(
        //   icon: Icon(
        //     CupertinoIcons.heart,
        //     color: Colors.white,
        //   ),
        //   title: 'Favorita',
        // ),
      ],
    );
  }
}

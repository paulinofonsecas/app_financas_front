import 'package:app_financas/app/components/movimento_item.dart';
import 'package:app_financas/app/modules/show_despesa_transaction/show_despesa_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../controllers/movimentos_screen_controller.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
    required this.controller,
  });

  final MovimentoScreenController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Builder(
          builder: (context) {
            return FutureBuilder<Either<Failure, List<Movimento>>>(
              future: controller.listMovimentos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                var data = snapshot.data;

                if (data == null) {
                  return const Center(
                    child:
                        Text('Ocorreu um erro ao listar os movimentos (null)'),
                  );
                }

                if (data is Left) {
                  if (kDebugMode) {
                    print(data
                        .swap()
                        .getOrElse(() => Failure('Erro desconhecido (null)')));
                  }
                  return const Center(
                    child: Text('Ocorreu um erro ao listar os movimentos'),
                  );
                }

                var movimentos = data.getOrElse(() => []);

                return ListView.builder(
                  itemCount: movimentos.length,
                  itemBuilder: (c, i) => _buildMovimentoItem(c, movimentos, i),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildMovimentoItem(context, movimentos, index) {
    var movimento = movimentos[index];
    return MovimentoItem(
      movimento: movimento,
      asset: 'assets/svgs/categories/desktop.svg',
      title: movimento.descricao,
      conta: 'Tecnologia',
      valor: movimento.valor,
      tipoMovimentoId: movimento.tipoMovimentoId,
      avatarBgColor: kAmarelhoColor,
      onTap: () {
        customShowModalBottomSheet(
          context,
          child: ShowDespesaTransactionPage(movimento: movimento),
        );
      },
    );
  }
}

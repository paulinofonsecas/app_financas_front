// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/components/movimento_item.dart';
import 'package:app_financas/app/components/page_action_bar.dart';
import 'package:app_financas/app/modules/movimentos/components/combo_box_filter.dart';
import 'package:app_financas/app/modules/movimentos/controllers/movimentos_screen_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/core/erros/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MovimentosScreen extends StatelessWidget {
  const MovimentosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(MovimentoScreenController());

    return Scaffold(
      backgroundColor: Color(0xffF3F3F3),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PageActionBar(
            title: 'Movimentos',
            actionBack: () {
              Get.back();
            },
          ),
          _buildHeaderPage(),
          SizedBox(height: kDefaultPadding),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Builder(builder: (context) {
                return FutureBuilder<Either<Failure, List<Movimento>>>(
                    future: controller.listMovimentos(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      var data = snapshot.data;

                      if (data == null) {
                        return Center(
                          child: Text(
                              'Ocorreu um erro ao listar os movimentos (null)'),
                        );
                      }

                      if (data is Left) {
                        if (kDebugMode) {
                          print(data.swap().getOrElse(
                              () => Failure('Erro desconhecido (null)')));
                        }
                        return Center(
                          child:
                              Text('Ocorreu um erro ao listar os movimentos'),
                        );
                      }

                      var movimentos = data.getOrElse(() => []);

                      return ListView.builder(
                        itemCount: movimentos.length,
                        itemBuilder: (_, index) {
                          var movimento = movimentos[index];
                          return MovimentoItem(
                            asset: 'assets/svgs/categories/desktop.svg',
                            title: movimento.descricao,
                            conta: 'Tecnologia',
                            valor: movimento.valor,
                            tipoMovimentoId: movimento.tipoMovimentoId,
                            avatarBgColor: kAmarelhoColor,
                          );
                        },
                      );
                    });
              }),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildHeaderPage() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 24.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Filtrar por',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            ComboBoxFilter(),
          ],
        ),
      ],
    ),
  );
}

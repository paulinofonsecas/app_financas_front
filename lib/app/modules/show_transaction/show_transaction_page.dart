// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/app/components/custom_bottom_sheet.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:app_financas/helders/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/show_transaction_controller.dart';

class ShowTransactionPage extends StatelessWidget {
  const ShowTransactionPage({
    super.key,
    required this.movimento,
  });

  final Movimento movimento;

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put(ShowTransactionController(), tag: 'EditTransactionController');
    return CustomBottomSheet(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              _HeaderInfo(
                movimento: movimento,
              ),
              const GutterTiny(),
              Divider(
                color: Colors.grey[100],
              ),
              const GutterTiny(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoWidget(
                        desc: 'Descrição',
                        value: movimento.descricao,
                        icon: Icon(
                          Icons.create_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      Gutter(),
                      InfoWidget(
                        desc: 'Data',
                        value: dateFormat.format(movimento.data),
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      Gutter(),
                      InfoWidget(
                        desc: 'Conta',
                        value: controller.getAccountName(movimento.cartaoId),
                        icon: Icon(
                          Icons.wallet,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoWidget(
                        desc: 'Valor',
                        value: numberFormat.format(movimento.valor),
                        icon: Icon(
                          Icons.monetization_on,
                          color: kVerdeAccentColor,
                          size: 20,
                        ),
                      ),
                      Gutter(),
                      InfoWidget(
                        desc: 'Categoria',
                        value: controller
                            .getCategoryName(movimento.categoriaMovimentoId),
                        icon: Icon(
                          Icons.category_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(),
                ],
              ),
              const Gutter(),
              ExpandedInfoWidget(
                desc: 'Observações',
                value: movimento.obsMovimento,
                icon: Icon(
                  Icons.create_sharp,
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: movimento.tipoMovimentoId == 1
                            ? kVerdeForteColor
                            : kVermelhaForteColor,
                        foregroundColor: Colors.white,
                        minimumSize: Size(Get.size.width / 2.5, 45),
                      ),
                      child: Text(
                        movimento.tipoMovimentoId == 1
                            ? 'Editar receita'
                            : 'Editar despesa',
                      ),
                    ),
                    GutterSmall(),
                    if (!movimento.confirmado)
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(Get.size.width / 2.5, 45),
                          padding: EdgeInsets.symmetric(
                            horizontal: kDefaultPadding * 3,
                            vertical: kDefaultPadding,
                          ),
                          side: BorderSide(
                            color: movimento.tipoMovimentoId == 1
                                ? kVerdeForteColor
                                : kVermelhaForteColor,
                            width: 2,
                          ),
                          foregroundColor: movimento.tipoMovimentoId == 1
                              ? kVerdeForteColor
                              : kVermelhaForteColor,
                        ),
                        child: Text(
                          movimento.tipoMovimentoId == 1 ? 'Receber' : 'Pagar',
                        ),
                      ),
                    GutterLarge(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.desc,
    required this.value,
    required this.icon,
  });

  final String desc;
  final String value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        icon,
        Gutter(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              desc,
              style: GoogleFonts.inter(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
            Text(
              value,
              softWrap: true,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ExpandedInfoWidget extends StatelessWidget {
  const ExpandedInfoWidget({
    super.key,
    required this.desc,
    required this.value,
    required this.icon,
  });

  final String desc;
  final String value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          desc,
          style: GoogleFonts.inter(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value.isEmpty ? 'Nenhuma' : value,
          softWrap: true,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  const _HeaderInfo({required this.movimento});

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
        CircleInfo(
          icon: Icon(
            CupertinoIcons.heart,
            color: Colors.white,
          ),
          title: 'Favorita',
        ),
      ],
    );
  }
}

class CircleInfo extends StatelessWidget {
  const CircleInfo({
    super.key,
    required this.icon,
    required this.title,
    this.backgroundColor,
  });

  final Widget icon;
  final String title;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor ?? Colors.grey[500],
          radius: 22,
          child: Center(
            child: icon,
          ),
        ),
        const GutterTiny(),
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.grey[600],
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

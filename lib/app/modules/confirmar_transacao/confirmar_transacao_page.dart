// ignore_for_file: prefer_const_constructors

import 'package:app_financas/app/components/custom_bottom_sheet.dart';
import 'package:app_financas/app/components/my_divider.dart';
import 'package:app_financas/app/components/with_icon.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controlleres/confirmar_transacao_controller.dart';

class ConfirmarTransacao extends StatefulWidget {
  const ConfirmarTransacao({super.key, required this.movimento});

  final Movimento movimento;

  @override
  State<ConfirmarTransacao> createState() => _ConfirmarTransacaoState();
}

class _ConfirmarTransacaoState extends State<ConfirmarTransacao> {
  late final ConfirmarTransacaoController controller;

  @override
  void initState() {
    controller = Get.put(ConfirmarTransacaoController(widget.movimento));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.setMovimento(widget.movimento);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: CustomBottomSheet(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      widget.movimento.tipoMovimentoId == 1
                          ? Icons.arrow_circle_up_outlined
                          : Icons.arrow_circle_down_outlined,
                      size: 30,
                      weight: 1,
                      color: widget.movimento.tipoMovimentoId == 1
                          ? kVerdeColor
                          : kVermelhaColor,
                    ),
                    const Gutter(),
                    Text(
                      widget.movimento.descricao,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Gutter(),
                const Gutter(),
                WithIcon(
                  icon: CupertinoIcons.money_dollar,
                  child: TextFormField(
                    controller: controller.valorTextController,
                    onChanged: controller.onValorChange,
                    focusNode: FocusNode(canRequestFocus: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: '0,00',
                      hintStyle: GoogleFonts.inter(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      prefixText: 'Kz ',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Gutter(),
                MyDivider(),
                const Gutter(),
                WithIcon(
                  icon: CupertinoIcons.calendar,
                  child: _buildSelectedDate(),
                ),
                const Gutter(),
                MyDivider(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSecondaryActionButton(context),
                    Gutter(),
                    _buildActionButton(context),
                  ],
                ),
                const Gutter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedDate() {
    var controller = Get.find<ConfirmarTransacaoController>();
    return Row(
      children: [
        GetBuilder(
          init: controller,
          builder: (context) {
            return Expanded(
              child: Text(
                controller.getSelectedDate(),
                style: GoogleFonts.inter().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
        const Gutter(),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Get.theme.colorScheme.surfaceTint.withOpacity(.1),
          ),
          onPressed: () {
            controller.selecionarDateTime(context);
          },
          child: const Text('Selecionar data'),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        controller.alterarTransacao();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.movimento.tipoMovimentoId == 1
            ? kVerdeForteColor
            : kVermelhaForteColor,
        foregroundColor: Colors.white,
        minimumSize: Size(Get.size.width / 2.5, 50),
      ),
      child: Text(
        widget.movimento.tipoMovimentoId == 1 ? 'Receber' : 'Pagar',
      ),
    );
  }

  OutlinedButton _buildSecondaryActionButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Get.back(canPop: true);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(Get.size.width / 2.5, 50),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 3,
          vertical: kDefaultPadding,
        ),
        side: BorderSide(
          color: widget.movimento.tipoMovimentoId == 1
              ? kVerdeForteColor
              : kVermelhaForteColor,
          width: 2,
        ),
        foregroundColor: widget.movimento.tipoMovimentoId == 1
            ? kVerdeForteColor
            : kVermelhaForteColor,
      ),
      child: Text('Cancelar'),
    );
  }
}

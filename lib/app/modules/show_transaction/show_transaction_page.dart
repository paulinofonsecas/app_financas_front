import 'package:app_financas/app/components/custom_bottom_sheet.dart';
import 'package:app_financas/app/modules/edit_transaction/edit_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';
import 'package:app_financas/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

import 'components/expanded_info.dart';
import 'components/header_info.dart';
import 'components/info.dart';
import 'controller/show_transaction_controller.dart';

class ShowTransactionPage extends StatefulWidget {
  const ShowTransactionPage({
    super.key,
    required this.movimento,
  });

  final Movimento movimento;

  @override
  State<ShowTransactionPage> createState() => _ShowTransactionPageState();
}

class _ShowTransactionPageState extends State<ShowTransactionPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(
      ShowTransactionController(),
      tag: 'EditTransactionController',
    );
    return CustomBottomSheet(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              HeaderInfo(movimento: widget.movimento),
              const GutterTiny(),
              Divider(color: Colors.grey[100]),
              const GutterTiny(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDescricaoInput(),
                      const Gutter(),
                      _buildDataInput(),
                      const Gutter(),
                      _buildContaInput(controller),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildValorInput(),
                      const Gutter(),
                      _buildCategoriaInput(controller),
                    ],
                  ),
                  const SizedBox(),
                ],
              ),
              const Gutter(),
              _buildObservacoesInput(),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    _buildActionButton(),
                    const GutterSmall(),
                    if (!widget.movimento.confirmado)
                      _buildSecondaryActionButton(),
                    const GutterLarge(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  OutlinedButton _buildSecondaryActionButton() {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        minimumSize: Size(Get.size.width / 2.5, 45),
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
      child: Text(
        widget.movimento.tipoMovimentoId == 1 ? 'Receber' : 'Pagar',
      ),
    );
  }

  ElevatedButton _buildActionButton() {
    return ElevatedButton(
      onPressed: () {
        customShowModalBottomSheet(
          context,
          child: EditTransactionPage(
            movimento: widget.movimento,
            movimentoType: widget.movimento.tipoMovimentoId,
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.movimento.tipoMovimentoId == 1
            ? kVerdeForteColor
            : kVermelhaForteColor,
        foregroundColor: Colors.white,
        minimumSize: Size(Get.size.width / 2.5, 45),
      ),
      child: Text(
        widget.movimento.tipoMovimentoId == 1
            ? 'Editar receita'
            : 'Editar despesa',
      ),
    );
  }

  dynamic _buildObservacoesInput() {
    return ExpandedInfo(
      desc: 'Observações',
      value: widget.movimento.obsMovimento,
      icon: const Icon(
        Icons.create_sharp,
      ),
    );
  }

  Widget _buildCategoriaInput(ShowTransactionController controller) {
    return InfoWidget(
      desc: 'Categoria',
      value: controller.getCategoryName(widget.movimento.categoriaMovimentoId),
      icon: const Icon(
        Icons.category_outlined,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  Widget _buildValorInput() {
    return InfoWidget(
      desc: 'Valor',
      value: numberFormat.format(widget.movimento.valor),
      icon: const Icon(
        Icons.monetization_on,
        color: kVerdeAccentColor,
        size: 20,
      ),
    );
  }

  Widget _buildContaInput(ShowTransactionController controller) {
    return InfoWidget(
      desc: 'Conta',
      value: controller.getAccountName(widget.movimento.cartaoId),
      icon: const Icon(
        Icons.wallet,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  Widget _buildDataInput() {
    return InfoWidget(
      desc: 'Data',
      value: dateFormat.format(widget.movimento.data),
      icon: const Icon(
        Icons.calendar_month,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  Widget _buildDescricaoInput() {
    return InfoWidget(
      desc: 'Descrição',
      value: widget.movimento.descricao,
      icon: const Icon(
        Icons.create_outlined,
        color: Colors.black,
        size: 20,
      ),
    );
  }
}

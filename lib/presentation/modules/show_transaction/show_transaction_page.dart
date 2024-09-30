import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/presentation/components/custom_bottom_sheet.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:app_financas/presentation/modules/confirmar_transacao/confirmar_transacao_page.dart';
import 'package:app_financas/presentation/modules/registar_transacao/view/registar_transacao_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/header_info.dart';
import 'components/info.dart';
import 'controller/show_transaction_controller.dart';

class ShowTransactionPage extends StatefulWidget {
  const ShowTransactionPage({
    super.key,
    required this.movimento,
    this.onEdit,
    this.onConfirmar,
  });

  final Movimento movimento;

  final Function? onEdit;
  final Function? onConfirmar;

  @override
  State<ShowTransactionPage> createState() => _ShowTransactionPageState();
}

class _ShowTransactionPageState extends State<ShowTransactionPage> {
  late final ShowTransactionController controller;

  @override
  void initState() {
    controller = Get.put(ShowTransactionController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.setMovimento(widget.movimento);

    return CustomBottomSheet(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              HeaderInfo(movimento: controller.movimento),
              const GutterTiny(),
              Divider(color: Colors.grey[100]),
              const GutterTiny(),
              _buildValorInput(),
              const Gutter(),
              _buildDescricaoInput(),
              const Gutter(),
              _buildDataInput(),
              const Gutter(),
              _buildCategoriaInput(),
              const Gutter(),
              _buildContaInput(),
              const Gutter(),
              _buildObservacoesInput(),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    _buildActionButton(),
                    const GutterSmall(),
                    if (!controller.movimento.confirmado)
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
    var controller = Get.find<ShowTransactionController>();
    return OutlinedButton(
      onPressed: () {
        Get.back();
        customShowModalBottomSheet(
          context,
          showDragHandle: false,
          child: ConfirmarTransacao(
            movimento: controller.movimento,
          ),
          isScrollControlled: false,
        ).then(
          (_) {
            widget.onConfirmar?.call();
          },
        );
      },
      style: OutlinedButton.styleFrom(
        minimumSize: Size(Get.size.width / 2.5, 50),
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 3,
          vertical: kDefaultPadding,
        ),
        side: BorderSide(
          color: controller.movimento.tipoMovimentoId == 1
              ? kVerdeForteColor
              : kVermelhaForteColor,
          width: 2,
        ),
        foregroundColor: controller.movimento.tipoMovimentoId == 1
            ? kVerdeForteColor
            : kVermelhaForteColor,
      ),
      child: Text(
        controller.movimento.tipoMovimentoId == 1 ? 'Receber' : 'Pagar',
      ),
    );
  }

  ElevatedButton _buildActionButton() {
    var controller = Get.find<ShowTransactionController>();
    return ElevatedButton(
      onPressed: () {
        Get.to(RegistarTransacaoPage(
          movimentoType: controller.movimento.tipoMovimentoId,
          movimento: controller.movimento,
        ))?.then((value) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // if (value == null) return;

          // // transação deletada
          // if (value is bool && value) {
          // }

          // // transação editada
          // if (value is Movimento) {
          //   widget.onEdit?.call();
          //   controller.updateMovimento(value);
          //   setState(() {});
          // }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: controller.movimento.tipoMovimentoId == 1
            ? kVerdeForteColor
            : kVermelhaForteColor,
        foregroundColor: Colors.white,
        minimumSize: Size(Get.size.width / 2.5, 50),
      ),
      child: Text(
        controller.movimento.tipoMovimentoId == 1
            ? 'Editar receita'
            : 'Editar despesa',
      ),
    );
  }

  dynamic _buildObservacoesInput() {
    var controller = Get.find<ShowTransactionController>();
    // return ExpandedInfo(
    //   desc: 'Observações',
    //   value: controller.movimento.obsMovimento ?? '',
    //   icon: const Icon(
    //     Icons.create_sharp,
    //   ),
    // );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.create_sharp,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Observações',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const GutterTiny(),
              Text(
                controller.movimento.obsMovimento ?? '',
                maxLines: 3,
                style: GoogleFonts.inter(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriaInput() {
    var controller = Get.find<ShowTransactionController>();

    String subCategoriaName() {
      if (controller.movimento.subCategoria != null) {
        return ' | ${controller.movimento.subCategoria!.name}';
      } else {
        return '';
      }
    }

    return InfoWidget(
      desc: 'Categoria',
      value: (controller.movimento.categoria?.name ?? 'Invalido') +
          subCategoriaName(),
      icon: Icon(
        controller.movimento.categoria?.icon ?? Icons.category_outlined,
        color: controller.movimento.categoria?.color ??
            Theme.of(context).iconTheme.color,
        size: 20,
      ),
    );
  }

  Widget _buildValorInput() {
    var controller = Get.find<ShowTransactionController>();
    return InfoWidget(
      desc: 'Valor',
      value: numberFormat.format(controller.movimento.valor),
      icon: const Icon(
        Icons.monetization_on,
        color: kVerdeAccentColor,
        size: 20,
      ),
    );
  }

  Widget _buildContaInput() {
    var controller = Get.find<ShowTransactionController>();
    return InfoWidget(
      desc: 'Conta',
      value: controller.getAccountName(controller.movimento.cartaoId),
      icon: Icon(
        Icons.wallet,
        color: Theme.of(context).iconTheme.color,
        size: 20,
      ),
    );
  }

  Widget _buildDataInput() {
    var controller = Get.find<ShowTransactionController>();
    return InfoWidget(
      desc: 'Data',
      value: dateFormat.format(controller.movimento.data),
      icon: Icon(
        Icons.calendar_month,
        color: Theme.of(context).iconTheme.color,
        size: 20,
      ),
    );
  }

  Widget _buildDescricaoInput() {
    var controller = Get.find<ShowTransactionController>();
    return InfoWidget(
      desc: 'Descrição',
      value: controller.movimento.descricao,
      icon: Icon(
        Icons.create_outlined,
        color: Theme.of(context).iconTheme.color,
        size: 20,
      ),
    );
  }
}

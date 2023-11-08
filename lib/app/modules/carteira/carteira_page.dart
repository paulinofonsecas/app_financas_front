// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/app/modules/conta_details/conta_details_page.dart';
import 'package:app_financas/core/domain/entitys/tipo_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:app_financas/app/components/movimento_item.dart';
import 'package:app_financas/app/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/app/modules/show_transaction/show_transaction_page.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/core/domain/entitys/movimento.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';

import 'components/conta_item_comp.dart';
import 'components/my_text_filter.dart';

class CarteiraPage extends StatefulWidget {
  const CarteiraPage({super.key});

  @override
  State<CarteiraPage> createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  late final PageController pageController;
  late final CarteiraPageController carteiraController;
  int currentIndex = 0;

  @override
  void initState() {
    carteiraController = Get.put(CarteiraPageController());
    pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
      keepPage: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: carteiraController,
      id: 'geral',
      builder: (context) {
        return Column(
          children: [
            headerSection(),
            const Gutter(),
            cardsSection(),
            const GutterLarge(),
            movimentoSection(),
          ],
        );
      },
    );
  }

  Widget headerSection() {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Row(
        children: [
          Text(
            'Carteira',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget movimentoSection() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerMovimentoSection(),
            const GutterTiny(),
            Expanded(
              child: PagedListView<int, Movimento>(
                pagingController: carteiraController.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Movimento>(
                  itemBuilder: (context, movimento, index) => MovimentoItem(
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
                        child: ShowTransactionPage(
                          movimento: movimento,
                          onEdit: () {
                            // controller.update(['geral']);
                            // controller.pagingController.refresh();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row headerMovimentoSection() {
    return Row(
      children: [
        MyTextFilter(
          title: 'Tudo',
          isActive: carteiraController.esFilter == 0,
          onTap: () {
            carteiraController.changeESFilter(0);
          },
        ),
        const GutterTiny(),
        MyTextFilter(
          title: 'Saídas',
          isActive: carteiraController.esFilter == TipoMovimento.SAIDA,
          onTap: () {
            carteiraController.changeESFilter(TipoMovimento.SAIDA);
          },
        ),
        const GutterTiny(),
        MyTextFilter(
          title: 'Entrada',
          isActive: carteiraController.esFilter == TipoMovimento.ENTRADA,
          onTap: () {
            carteiraController.changeESFilter(TipoMovimento.ENTRADA);
          },
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Get.to(ContaDetailsPage(conta: carteiraController.conta!));
          },
          child: const Text('Ver mais'),
        ),
      ],
    );
  }

  SizedBox cardsSection() {
    return SizedBox(
      height: 230,
      child: FutureBuilder<List<Conta>>(
        future: carteiraController.getContas(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.error != null) {
            return Text('${snapshot.error}');
          }

          var contas = snapshot.data ?? [];

          return PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              carteiraController.updateContaIndex(contas[index].id);
              carteiraController.updateConta(contas[index]);
              setState(() {
                currentIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
            itemCount: contas.length,
            itemBuilder: (context, index) {
              var conta = contas[index];

              return ContaItem(
                conta: conta,
                isActive: index == currentIndex,
                onTap: () {
                  if (index == currentIndex) {
                    Get.to(
                      ContaDetailsPage(
                        conta: conta,
                      ),
                    )?.then((value) {
                      setState(() {});
                      carteiraController.pagingController.refresh();
                      carteiraController.update(['geral']);
                    });
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}


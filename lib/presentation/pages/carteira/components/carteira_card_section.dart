import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/modules/carteira/components/conta_item_comp.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/conta_details/conta_details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarteiraCardSection extends StatefulWidget {
  const CarteiraCardSection({super.key});

  @override
  State<CarteiraCardSection> createState() => _CarteiraCardSectionState();
}

class _CarteiraCardSectionState extends State<CarteiraCardSection> {
  late final CarteiraPageController carteiraController;
  late final PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    carteiraController = Get.find<CarteiraPageController>();
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

                  return Hero(
                    tag: 'conta_${conta.id}',
                    child: ContaItem(
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
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

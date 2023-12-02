import 'package:app_financas/presentation/modules/registar_transacao/controllers/registar_transacao_controller.dart';
import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

class CategoryListItemComponent extends StatelessWidget {
  const CategoryListItemComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RegistarTransacaoController>();

    return InkWell(
      onTap: () {
        controller.selectCategory(
          context,
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
              vertical: kDefaultPadding / 3,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              border: Border.all(
                color: Colors.orangeAccent,
                width: 1,
              ),
            ),
            child: GetBuilder(
                init: controller,
                id: 'category',
                builder: (context) {
                  return FutureBuilder<Categoria?>(
                    future: controller.getCategoriaSelecionada(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            'Error',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData && snapshot.data == null) {
                        return const Center(
                          child: Text(
                            'Categoria invalida',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (snapshot.hasData &&
                          snapshot.data == Categoria.fake()) {
                        return const Center(
                          child: Text(
                            'Categoria invalida',
                            style: TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      var category = snapshot.data!;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            category.icon ?? Icons.category_outlined,
                            size: 18,
                          ),
                          const GutterSmall(),
                          Text(category.name),
                        ],
                      );
                    },
                  );
                }),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

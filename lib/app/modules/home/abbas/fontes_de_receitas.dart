import 'package:app_financas/constants.dart';
import 'package:flutter/cupertino.dart';

import 'components/abba_header.dart';
import 'components/fontes_de_receita_list.dart';

class FontesDeReceita extends StatelessWidget {
  const FontesDeReceita({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AbbaHeader(
          title: 'Fontes de Receitas',
          verMaisAction: () {},
        ),
        const SizedBox(height: kDefaultPadding),
        const SizedBox(
          height: 150,
          child: FontesDeReceitaList(),
        ),
      ],
    );
  }
}

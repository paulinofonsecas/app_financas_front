import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/planejamento.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderPlanejamentoSection extends StatelessWidget {
  const HeaderPlanejamentoSection({super.key, required this.planejamento});

  final Planejamento planejamento;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gutter(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyInfoField(
              icon: FontAwesomeIcons.coins,
              title: planejamento.restante < 0 ? 'Excedido: ' : 'Restante: ',
              valor: numberFormat.format(planejamento.restante),
            ),
            Container(
              width: 1,
              height: 30,
              color: Colors.grey,
            ),
            MyInfoField(
              icon: FontAwesomeIcons.coins,
              title: 'Gasto por dia',
              valor: numberFormat.format(planejamento.gastoPorDia),
            ),
          ],
        ),
        const Gutter(),
        const Divider(),
        const Gutter(),
      ],
    );
  }
}

class MyInfoField extends StatelessWidget {
  const MyInfoField({
    super.key,
    required this.title,
    required this.icon,
    required this.valor,
  });

  final String title;
  final IconData icon;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(width: kDefaultPadding / 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              valor,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

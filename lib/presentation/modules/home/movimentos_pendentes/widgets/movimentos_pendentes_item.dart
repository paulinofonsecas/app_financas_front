import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/movimentos_pendentes.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FontReceitaListItem extends StatelessWidget {
  const FontReceitaListItem({
    Key? key,
    required this.movimento,
  }) : super(key: key);

  final MovimentosPendentes movimento;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      height: 130,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(
                  Theme.of(context).brightness == Brightness.dark ? .5 : .2,
                ),
            blurRadius: 4,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4,
      ),
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(movimento.tipoMovimentoId == 1
                  ? FontAwesomeIcons.arrowUp
                  : FontAwesomeIcons.arrowDown),
              const Spacer(),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: movimento.tipoMovimentoId == 1
                      ? kVerdeAccentColor
                      : kVermelhaAccentColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                ),
                child: Center(
                  child: Text(
                    movimento.movimentos.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding),
          Text(
            '${movimento.tipoMovimentoId == 1 ? 'Receita' : 'Despesa'}'
            ' pendente',
            style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 11,
            ),
          ),
          const Spacer(),
          Text(
            numberFormat.format(movimento.valor),
            style: GoogleFonts.inter(
              color: kVerdeAccentColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

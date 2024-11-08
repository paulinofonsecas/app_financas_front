// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/conta.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ContaListItem extends StatelessWidget {
  const ContaListItem({
    super.key,
    required this.conta,
    this.onTap,
  });

  final Conta conta;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Dismissible(
          key: ValueKey(conta.id),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {},
          background: Container(
            color: Colors.grey,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: const Icon(
              Icons.archive,
              color: Colors.white,
            ),
          ),
          confirmDismiss: (direction) async {
            return await _showArchiveDialog(context);
          },
          child: _ContaItemWidget(conta: conta),
        ),
      ),
    );
  }

  Future<bool?> _showArchiveDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Arquivar conta'),
        );
      },
    );
  }
}

class _ContaItemWidget extends StatelessWidget {
  const _ContaItemWidget({
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kDefaultPadding,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          conta.banco.imgAsset != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(90),
                  child: Image.asset(
                    conta.banco.imgAsset!,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                )
              : const Icon(
                  FontAwesomeIcons.circleDot,
                  color: kVerdeAccentColor,
                  size: 28,
                ),
          const Gutter(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conta.nome,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      conta.banco.acronimo ?? conta.banco.nome,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  numberFormat.format(conta.saldo),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: kVerdeAccentColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

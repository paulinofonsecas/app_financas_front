// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:app_financas/presentation/helders/format_helpers.dart';

class ContaListItem extends StatelessWidget {
  const ContaListItem({
    Key? key,
    required this.conta,
    this.onTap,
  }) : super(key: key);

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
          title: Text('Deletar conta'),
        );
      },
    );
  }
}

class _ContaItemWidget extends StatelessWidget {
  const _ContaItemWidget({
    Key? key,
    required this.conta,
  }) : super(key: key);

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
        bottom: kDefaultPadding / 4,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          conta.iconAsset != null
              ? SvgPicture.asset('teste')
              : const Icon(
                  FontAwesomeIcons.moneyBill,
                  color: kVerdeAccentColor,
                ),
          const Gutter(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      conta.nome,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    _CustomIconButton(
                      icon: const Icon(Icons.more_horiz),
                      onTap: () {},
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Saldo',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      numberFormat.format(conta.saldo),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: kVerdeAccentColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const GutterTiny(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  const _CustomIconButton({
    Key? key,
    this.onTap,
    required this.icon,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: icon,
        ),
      ),
    );
  }
}

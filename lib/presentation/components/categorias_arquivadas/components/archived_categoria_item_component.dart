// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';

class ArchivedCategoriaItem extends StatelessWidget {
  const ArchivedCategoriaItem({
    Key? key,
    required this.categoria,
    this.onTap,
    this.onIconTap,
  }) : super(key: key);

  final Categoria categoria;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onIconTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding / 4,
        ),
        title: Text(
          categoria.name.capitalize.toString(),
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: CircleAvatar(
          backgroundColor:
              categoria.color ?? Theme.of(context).colorScheme.primary,
          child: Icon(
            categoria.icon ?? Icons.icecream,
            color: Colors.white,
            size: 16,
          ),
        ),
        trailing: IconButton(
          onPressed: onIconTap,
          icon: const Icon(
            Icons.archive_outlined,
          ),
        ),
      ),
    );
  }
}

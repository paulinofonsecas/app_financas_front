// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';

class CategoriaItem extends StatelessWidget {
  const CategoriaItem({
    Key? key,
    required this.categoria,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final Categoria categoria;
  final GestureTapCallback? onTap;
  final bool isSelected;

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
        leading: const CircleAvatar(
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.phone,
            color: Colors.white,
            size: 16,
          ),
        ),
        trailing: Checkbox(
          value: isSelected,
          onChanged: (c) {
            onTap?.call();
          },
          shape: const CircleBorder(),
        ),
      ),
    );
  }
}

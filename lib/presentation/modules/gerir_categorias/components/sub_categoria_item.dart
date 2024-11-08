import 'package:app_financas/constants.dart';
import 'package:app_financas/domain/entities/categoria_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class SubCategoriaItem extends StatelessWidget {
  const SubCategoriaItem({super.key, required this.subCategoria});

  final Categoria subCategoria;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: kDefaultPadding / 2,
      ),
      child: Row(
        children: [
          const GutterLarge(),
          Container(
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: subCategoria.color,
            ),
          ),
          const Gutter(),
          Text(
            subCategoria.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter/material.dart';

class CategorieAvatar extends StatelessWidget {
  const CategorieAvatar({super.key, required this.categoria});

  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: categoria.color ?? kBlackColor.withOpacity(.5),
      radius: 15,
      child: Center(
        child: Icon(
          categoria.icon ?? Icons.more_horiz,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}

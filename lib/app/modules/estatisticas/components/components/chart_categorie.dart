import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class ChartCategory extends StatelessWidget {
  const ChartCategory({
    Key? key,
    required this.categoria,
  }) : super(key: key);

  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      margin: const EdgeInsets.only(right: kDefaultPadding / 2),
      child: Row(
        children: [
          Icon(categoria.icon, color: categoria.color, size: 14),
          const Gutter(),
          Text(
            categoria.name,
            style: TextStyle(
              fontSize: 16,
              color: categoria.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app_financas/core/domain/entitys/conta.dart';
import 'package:flutter/material.dart';

class BancoImgCircularWidget extends StatelessWidget {
  const BancoImgCircularWidget({
    super.key,
    required this.conta,
  });

  final Conta conta;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Image.asset(
        conta.banco.imgAsset!,
        fit: BoxFit.cover,
        height: 20,
        width: 20,
      ),
    );
  }
}

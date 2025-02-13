import 'package:app_financas/presentation/components/default_action_button.dart';
import 'package:flutter/material.dart';

class BotaoSalvarWidget extends StatelessWidget {
  const BotaoSalvarWidget({required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return DefaultActionButton(
      onPressed: onTap,
      text: 'Salvar',
    );
  }
}

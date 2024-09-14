import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class DuetInfo extends StatelessWidget {
  const DuetInfo({
    super.key,
    required this.title,
    required this.valor,
    this.extended = false,
    this.isMoney = true,
  });

  final String title;
  final double valor;
  final bool extended;
  final bool isMoney;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            // color: Colors.black,
          ),
        ),
        extended ? const Spacer() : const GutterTiny(),
        Text(
          !isMoney ? valor.toStringAsFixed(0) : numberFormat.format(valor),
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}

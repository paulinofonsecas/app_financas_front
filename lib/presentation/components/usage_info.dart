import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class UsageInfo extends StatelessWidget {
  const UsageInfo({super.key, required this.percentage});

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: percentage > 100
                ? Theme.of(context).colorScheme.errorContainer
                : Theme.of(context).colorScheme.surfaceTint,
          ),
        ),
        const Gutter(),
        Text('$percentage% Despesas pagas'),
      ],
    );
  }
}

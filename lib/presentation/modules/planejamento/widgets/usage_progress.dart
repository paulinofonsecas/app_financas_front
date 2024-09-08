import 'package:app_financas/presentation/helders/format_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class UsageProgress extends StatelessWidget {
  const UsageProgress({
    super.key,
    required this.finalValue,
    required this.actualValue,
    required this.color,
  });

  final double finalValue;
  final double actualValue;
  final Color? color;

  double get _percent => (actualValue / finalValue * 100).roundToDouble();
  // double get _difference => (finalValue - actualValue).roundToDouble();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: LinearProgressIndicator(
                  value: actualValue / finalValue,
                  color: _percent > 100
                      ? Theme.of(context).colorScheme.errorContainer
                      : color ?? Theme.of(context).colorScheme.surfaceTint,
                  backgroundColor: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
              Align(
                alignment:
                    _percent >= 60 ? Alignment.center : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '$_percent%',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: _percent >= 60
                              ? _percent > 100
                                  ? Theme.of(context)
                                      .colorScheme
                                      .onErrorContainer
                                  : Colors.black
                              : Colors.black,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const GutterSmall(),
        Text(
          '${numberFormat.format(actualValue)} de ${numberFormat.format(finalValue)}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const Gutter(),
        UsageInfo(
          percentage: _percent,
        ),
      ],
    );
  }
}

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

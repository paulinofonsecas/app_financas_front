import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';

class PeriodoPlanejamento extends StatelessWidget {
  const PeriodoPlanejamento({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: Row(
        children: [
          const Spacer(flex: 2),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_left),
            color: Theme.of(context).colorScheme.primary,
          ),
          const Spacer(),
          Text(
            'Janeiro',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.chevron_right),
            color: Theme.of(context).colorScheme.primary,
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

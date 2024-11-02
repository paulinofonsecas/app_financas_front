import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class ContaBottomSheet extends StatelessWidget {
  const ContaBottomSheet({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (_) => const ContaBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            trailing: const Icon(Icons.archive_outlined),
            title: const Text('Arquivar conta'),
          ),
          const GutterLarge(),
        ],
      ),
    );
  }
}

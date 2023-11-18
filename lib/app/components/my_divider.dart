import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor.withOpacity(.1),
      height: 1,
    );
  }
}

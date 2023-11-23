import 'package:app_financas/constants.dart';
import 'package:flutter/material.dart';

class OmitedText extends StatelessWidget {
  const OmitedText({super.key, this.padding});

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 4,
      margin: padding ?? const EdgeInsets.symmetric(vertical: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

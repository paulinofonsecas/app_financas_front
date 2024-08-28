import 'package:flutter/material.dart';

class NotConfirmWidgetIndicator extends StatelessWidget {
  const NotConfirmWidgetIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 15,
        height: 15,
        decoration: const BoxDecoration(
          color: Colors.redAccent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

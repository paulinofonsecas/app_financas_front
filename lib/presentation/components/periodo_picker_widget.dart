// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class PeriodoPickerWidget extends StatelessWidget {
  const PeriodoPickerWidget({
    Key? key,
    this.onLeftTap,
    this.onRightTap,
    required this.periodoMes,
  }) : super(key: key);

  final GestureTapCallback? onLeftTap;
  final GestureTapCallback? onRightTap;
  final String periodoMes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const GutterLarge(),
        IconButton(
          onPressed: onLeftTap,
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Spacer(),
        Text(
          periodoMes,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onRightTap,
          icon: Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 28,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const GutterLarge(),
      ],
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PeriodoPickerWidget extends StatelessWidget {
  const PeriodoPickerWidget({
    super.key,
    this.onLeftTap,
    this.onRightTap,
    this.defaultColor,
    required this.periodoMes,
  });

  final GestureTapCallback? onLeftTap;
  final GestureTapCallback? onRightTap;
  final Color? defaultColor;
  final String periodoMes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const GutterLarge(),
        IconButton(
          onPressed: onLeftTap,
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: 18,
            color: defaultColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        const Spacer(),
        Text(
          periodoMes,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: defaultColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onRightTap,
          icon: Icon(
            FontAwesomeIcons.chevronRight,
            size: 18,
            color: defaultColor ?? Theme.of(context).colorScheme.primary,
          ),
        ),
        const GutterLarge(),
      ],
    );
  }
}

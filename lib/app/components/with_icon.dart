// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';

class WithIcon extends StatelessWidget {
  const WithIcon({
    Key? key,
    required this.icon,
    required this.child,
  }) : super(key: key);

  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          color: Get.theme.iconTheme.color?.withOpacity(.8),
          size: 22,
        ),
        const Gutter(),
        Expanded(child: child),
      ],
    );
  }
}

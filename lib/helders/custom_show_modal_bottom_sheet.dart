import 'package:flutter/material.dart';

Future<dynamic> customShowModalBottomSheet(
  BuildContext context, {
  required Widget child,
  bool isScrollControlled = true,
  BoxConstraints? constraints,
}) {
  final size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: Colors.white,
    showDragHandle: true,
    useSafeArea: true,
    constraints:
        constraints ?? BoxConstraints.expand(height: size.height * 0.8),
    builder: (context) => child,
  );
}

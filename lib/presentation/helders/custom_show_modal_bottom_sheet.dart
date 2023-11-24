import 'package:flutter/material.dart';

Future<dynamic> customShowModalBottomSheet(
  BuildContext context, {
  required Widget child,
  bool isScrollControlled = true,
  bool? showDragHandle,
  BoxConstraints? constraints,
}) {
  final size = MediaQuery.of(context).size;
  return showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    showDragHandle: showDragHandle ?? true,
    useSafeArea: true,
    useRootNavigator: true,
    constraints: constraints ??
        BoxConstraints.expand(
          height: size.height * 0.8,
        ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      ),
    ),
    builder: (context) => child,
  );
}

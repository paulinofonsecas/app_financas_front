// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key? key,
    required this.child,
    this.decoration,
  }) : super(key: key);

  final Widget child;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: child,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class IconItemComponent extends StatelessWidget {
  const IconItemComponent({
    Key? key,
    required this.color,
    required this.icon,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final IconData icon;
  final bool isSelected;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: isSelected ? color : Colors.grey,
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 17,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ColorItemComponent extends StatelessWidget {
  const ColorItemComponent({
    Key? key,
    required this.color,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  final Color color;
  final bool? isSelected;
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
          color: color,
        ),
        child: isSelected == true
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 17,
                ),
              )
            : null,
      ),
    );
  }
}

import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'color_item_comp.dart';
import 'select_outros_colors_comp.dart';

class ColorPickerList extends StatefulWidget {
  const ColorPickerList({
    super.key,
  });

  @override
  State<ColorPickerList> createState() => _ColorPickerListState();
}

class _ColorPickerListState extends State<ColorPickerList> {
  var selectedColorIndex = 0;
  late final List<Color> colors;

  @override
  void initState() {
    var cubit = context.read<ColorFieldCubit>();
    colors = (List<Color>.from(Colors.primaries)..shuffle()).take(8).toList();

    if (cubit.state is ColorFieldInitial) {
      cubit.setSelectedColor(colors[0]);
    } else {
      colors.removeAt(0);
      colors.removeWhere((color) => color == cubit.state.color);
      colors.insert(0, cubit.state.color);
      cubit.setSelectedColor(cubit.state.color);
    }

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ColorFieldCubit>();

    return BlocListener<ColorFieldCubit, ColorFieldState>(
      listener: (context, state) {
        if (state is ColorFieldSelected) {
          cubit.setSelectedColor(state.color);
          selectedColorIndex = colors.indexOf(state.color);
          setState(() {});
        }
      },
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...colors.map((color) {
                return ColorItemComponent(
                  color: color,
                  isSelected: selectedColorIndex == colors.indexOf(color),
                  onTap: () {
                    cubit.setSelectedColor(color);
                    selectedColorIndex = colors.indexOf(color);
                    setState(() {});
                  },
                );
              }),
            ],
          ),
          const Gutter(),
          const SelectOutrosColorsComponent(),
        ],
      ),
    );
  }
}

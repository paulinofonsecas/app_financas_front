import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'color_item_comp.dart';
import 'select_outros_colors_comp.dart';

class ColorPickerList extends HookWidget {
  const ColorPickerList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ColorFieldCubit>();
    final selectedColorIndex = useState(0);
    final colorsState =
        useState((List.from(Colors.primaries)..shuffle()).take(8).toList());
    final colors = colorsState.value;
    if (cubit.state is ColorFieldInitial) {
      cubit.setSelectedColor(colors[0]);
    }

    return BlocListener<ColorFieldCubit, ColorFieldState>(
      listener: (context, state) {
        if (state is ColorFieldSelected) {
          cubit.setSelectedColor(state.color);
          selectedColorIndex.value = colors.indexOf(state.color);
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
                  isSelected: selectedColorIndex.value == colors.indexOf(color),
                  onTap: () {
                    cubit.setSelectedColor(color);
                    selectedColorIndex.value = colors.indexOf(color);
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

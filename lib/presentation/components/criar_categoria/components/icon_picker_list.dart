import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/icon_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'icon_item_comp.dart';
import 'select_outros_icons_comp.dart';

class IconPickerList extends HookWidget {
  const IconPickerList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IconFieldCubit>();
    final selectedIconIndex = useState(0);
    final icons = [
      Icons.credit_card,
      Icons.attach_money,
      Icons.pie_chart,
      Icons.savings,
      Icons.monetization_on,
      Icons.receipt_long,
      Icons.shopping_cart,
    ];

    return BlocListener<IconFieldCubit, IconFieldState>(
      listener: (context, state) {
        if (state is IconFieldSelected) {
          cubit.setSelectedIcon(state.icon);
          selectedIconIndex.value = icons.indexOf(state.icon);
        }
      },
      child: Column(
        children: [
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: icons
                  .map((icon) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: IconItemComponent(
                            color: context.watch<ColorFieldCubit>().state.color,
                            isSelected:
                                icons.indexOf(icon) == selectedIconIndex.value,
                            icon: icon,
                            onTap: () {
                              cubit.setSelectedIcon(icon);
                              selectedIconIndex.value = icons.indexOf(icon);
                            }),
                      ))
                  .toList(),
            ),
          ),
          const Gutter(),
          const SelectOutrosIconsComponent(),
        ],
      ),
    );
  }
}

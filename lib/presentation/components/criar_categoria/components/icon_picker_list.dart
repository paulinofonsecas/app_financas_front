import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/icon_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import 'icon_item_comp.dart';
import 'select_outros_icons_comp.dart';

class IconPickerList extends StatefulWidget {
  const IconPickerList({super.key});

  @override
  State<IconPickerList> createState() => _IconPickerListState();
}

class _IconPickerListState extends State<IconPickerList> {
  var selectedIconIndex = 0;
  final icons = [
    Icons.credit_card,
    Icons.attach_money,
    Icons.pie_chart,
    Icons.savings,
    Icons.monetization_on,
    Icons.receipt_long,
    Icons.shopping_cart,
  ];

  @override
  void initState() {
    icons.remove(context.read<IconFieldCubit>().state.icon);
    icons.insert(0, context.read<IconFieldCubit>().state.icon);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<IconFieldCubit>();

    return BlocListener<IconFieldCubit, IconFieldState>(
      listener: (context, state) {
        if (state is IconFieldSelected) {
          if (!icons.contains(state.icon)) {
            icons.removeAt(0);
            icons.insert(0, state.icon);
          }
          selectedIconIndex = icons.indexOf(state.icon);
          setState(() {});
        }
      },
      child: Column(
        children: [
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: icons
                  .map(
                    (icon) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: IconItemComponent(
                        color: context.watch<ColorFieldCubit>().state.color,
                        isSelected: icons.indexOf(icon) == selectedIconIndex,
                        icon: icon,
                        onTap: () {
                          cubit.setSelectedIcon(icon);
                          selectedIconIndex = icons.indexOf(icon);
                          setState(() {});
                        },
                      ),
                    ),
                  )
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

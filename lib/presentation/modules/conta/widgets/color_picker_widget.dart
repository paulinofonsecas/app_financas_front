import 'package:app_financas/presentation/modules/conta/cubit/create_conta_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key, this.defaultColor = Colors.blue});

  final Color defaultColor;

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.greenAccent,
      Colors.brown,
    ];

    return BlocBuilder<CreateContaThemeCubit, CreateContaThemeState>(
      buildWhen: (previous, current) {
        return previous != current && current is CreateContaThemeChanged;
      },
      builder: (context, state) {
        if (state is CreateContaThemeChanged) {
          return Row(
            children: colors
                .map((e) => _ColorItem(
                      color: e,
                      isSelected: state.color == e,
                      onTap: () {
                        context.read<CreateContaThemeCubit>().changeColor(e);
                      },
                    ))
                .toList(),
          );
        }

        return Row(
          children: colors
              .map((e) => _ColorItem(
                    color: e,
                    isSelected: defaultColor == e,
                    onTap: () {
                      context.read<CreateContaThemeCubit>().changeColor(e);
                    },
                  ))
              .toList(),
        );
      },
    );
  }
}

class _ColorItem extends StatelessWidget {
  const _ColorItem({
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

  final Color color;
  final Function()? onTap;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: isSelected!
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}

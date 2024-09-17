import 'package:app_financas/presentation/components/criar_categoria/components/color_field_comp.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:app_financas/presentation/modules/create_objectivo/create_objectivo.dart';
import 'package:flutter/material.dart';

class ColorField extends StatelessWidget {
  const ColorField({super.key});

  @override
  Widget build(BuildContext context) {
    final preObj = context.watch<CreateObjectivoBloc>().preObj;
    context.read<ColorFieldCubit>().setSelectedColor(
        preObj?.color ?? Theme.of(context).colorScheme.surfaceTint);

    return const ColorFieldComp();
  }
}

import 'package:app_financas/presentation/components/criar_categoria/components/icon_field_comp.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/icon_field_cubit.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/create_objectivo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IconField extends StatelessWidget {
  const IconField({super.key});

  @override
  Widget build(BuildContext context) {
    final preObj = context.watch<CreateObjectivoBloc>().preObj;
    context.read<IconFieldCubit>().setSelectedIcon(preObj?.icon ?? Icons.home);

    return const IconFieldComp();
  }
}

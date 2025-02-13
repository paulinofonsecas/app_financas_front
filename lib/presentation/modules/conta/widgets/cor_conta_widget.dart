import 'package:app_financas/presentation/modules/conta/cubit/create_conta_theme_cubit.dart';
import 'package:app_financas/presentation/modules/conta/widgets/color_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CorContaWidget extends StatelessWidget {
  const CorContaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<CreateContaThemeCubit>(),
      child: const ListTile(
        title: Text('Cor'),
        subtitle: ColorPickerWidget(),
        leading: Icon(FontAwesomeIcons.palette),
        trailing: Icon(FontAwesomeIcons.chevronRight, size: 16),
      ),
    );
  }
}

import 'package:app_financas/presentation/modules/conta/widgets/create_conta_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/create_conta_theme_cubit.dart';

class CreateContaPage extends StatefulWidget {
  const CreateContaPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const CreateContaPage());
  }

  @override
  State<CreateContaPage> createState() => _CreateContaPageState();
}

class _CreateContaPageState extends State<CreateContaPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateContaThemeCubit(),
      child: const CreateContaView(),
    );
  }
}

class CreateContaView extends StatelessWidget {
  const CreateContaView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateContaThemeCubit, CreateContaThemeState>(
      builder: (context, state) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: state.color,
              brightness: Theme.of(context).brightness,
            ),
          ),
          child: const CreateContaBody(),
        );
      },
    );
  }
}

import 'package:app_financas/presentation/modules/conta/bloc/create_conta_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'header_widget.dart';
import 'main_content_widget.dart';
import 'saldo_text_field_widget.dart';

class CreateContaBody extends StatelessWidget {
  const CreateContaBody({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<CreateContaBloc, CreateContaState>(
      listener: (context, state) {
        if (state is CreateContaSuccess) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: isDark
            ? Theme.of(context).colorScheme.shadow
            : Theme.of(context).primaryColor,
        body: const SafeArea(
          bottom: false,
          child: Column(
            children: [
              HeaderWidget(),
              SaldoTextFieldWidget(),
              MainContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/create_objectivo_bloc.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/color_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/data_final_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/descricao_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/icon_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/nome_objectivo_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/valor_alvo_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/valor_inicial_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class CreateObjectivoBody extends StatelessWidget {
  const CreateObjectivoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = context.read<CreateObjectivoBloc>().formKey;

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Form(
        key: formKey,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ValorAlvoField(),
            GutterTiny(),
            Divider(),
            ValorInicialField(),
            Divider(),
            NomeObjectivoField(),
            Divider(),
            DataFinalField(),
            Divider(),
            ColorField(),
            GutterTiny(),
            Divider(),
            IconField(),
            GutterTiny(),
            Divider(),
            DescricaoField(),
          ],
        ),
      ),
    );
  }
}

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/create_objectivo_bloc.dart';
import 'package:app_financas/presentation/modules/create_objectivo/cubit/delete_objectivo_cubit.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/color_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/data_final_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/descricao_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/icon_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/nome_objectivo_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/valor_alvo_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/valor_atual_field.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/valor_inicial_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class CreateObjectivoBody extends StatelessWidget {
  const CreateObjectivoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateObjectivoBloc>();
    final formKey = context.read<CreateObjectivoBloc>().formKey;

    return BlocListener<DeleteObjectivoCubit, DeleteObjectivoState>(
      listener: (context, state) {
        if (state is DeleteObjectivoSuccess) {
          Navigator.pop(context);
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ValorAlvoField(),
                const GutterTiny(),
                const Divider(),
                const ValorInicialField(),
                const Divider(),
                if (bloc.objectivoModel.currentValue > 0) ...[
                  const ValorAtualField(),
                  const Divider()
                ],
                const NomeObjectivoField(),
                const Divider(),
                const DataFinalField(),
                const Divider(),
                const ColorField(),
                const GutterTiny(),
                const Divider(),
                const IconField(),
                const GutterTiny(),
                const Divider(),
                const DescricaoField(),
                if (bloc.objectivoModel.targetValue > 0) ...[
                  const Gutter(),
                  Center(
                    child:
                        BlocBuilder<DeleteObjectivoCubit, DeleteObjectivoState>(
                      builder: (context, state) {
                        if (state is DeleteObjectivoLoading) {
                          return const CircularProgressIndicator();
                        }

                        return FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            if (context.read<DeleteObjectivoCubit>().state
                                is! DeleteObjectivoLoading) {
                              context
                                  .read<DeleteObjectivoCubit>()
                                  .deleteObjectivo(bloc.objectivoModel);
                            }
                          },
                          child: const Text('Excluir objetivo'),
                        );
                      },
                    ),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}

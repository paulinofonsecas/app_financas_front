import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/cubit/criar_sub_categoria_cubit.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/widgets/descricao_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CriarSubCategoriaBody extends StatefulWidget {
  const CriarSubCategoriaBody({super.key, required this.categoria});

  final Categoria categoria;

  @override
  State<CriarSubCategoriaBody> createState() => _CriarSubCategoriaBodyState();
}

class _CriarSubCategoriaBodyState extends State<CriarSubCategoriaBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final controller = TextEditingController();

  @override
  void initState() {
    final cubit = context.read<CriarSubCategoriaCubit>();
    if (cubit.state is CriarSubCategoriaEdit) {
      controller.text =
          (cubit.state as CriarSubCategoriaEdit).subCategoria.name;
    }

    super.initState();
  }

  Future<void> deletarSubCategoria(
      context, CriarSubCategoriaCubit cubit) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Deseja realmente deletar esta subCategoria?'),
          content: const Text(
            'As transações relacionadas a esta categoria'
            ' serão movidas para a categoria mão.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                cubit.deleteSubCategoria(
                  widget.categoria,
                  cubit.subCategoria!,
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CriarSubCategoriaCubit>();

    return BlocListener<CriarSubCategoriaCubit, CriarSubCategoriaState>(
      listener: (context, state) {
        if (state is CriarSubCategoriaFailed) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }

        if (state is CriarSubCategoriaSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Criar nova subcategoria',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Gutter(),
                DescricaoTextField(
                  controller: controller,
                ),
                const Divider(),
                const Gutter(),
                if (cubit.subCategoria != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          deletarSubCategoria(context, cubit);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        icon: const Icon(
                          FontAwesomeIcons.trash,
                          size: 14,
                        ),
                        label: const Text('Deletar'),
                      ),
                      const Gutter(),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.boxArchive,
                          size: 14,
                        ),
                        label: const Text('Arquivar'),
                      ),
                    ],
                  ),
                const GutterLarge(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('CANCELAR'),
                    ),
                    FilledButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context
                              .read<CriarSubCategoriaCubit>()
                              .createSubCategoria(
                                widget.categoria,
                                controller.text,
                              );
                        }
                      },
                      child: const Text('CONCLUÍDO'),
                    )
                  ],
                ),
                const GutterLarge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

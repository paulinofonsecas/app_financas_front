// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/components/my_divider.dart';
import 'package:app_financas/presentation/components/with_icon.dart';
import 'package:app_financas/presentation/cubit/update_categoria_cubit.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/view/criar_sub_categoria_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/color_field_comp.dart';
import 'components/footer_section_component.dart';
import 'components/icon_field_comp.dart';
import 'components/name_text_field_comp.dart';
import 'controllers/editar_categoria_controller.dart';

class EditarCategoriaComponent extends StatefulWidget {
  const EditarCategoriaComponent({
    super.key,
    required this.tipoCategoria,
    required this.categoria,
  });

  final TipoCategoria tipoCategoria;
  final Categoria categoria;

  static Future<dynamic> openModalBottomSheet({
    required BuildContext context,
    required TipoCategoria tipoCategoria,
    required Categoria categoria,
  }) async {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: false,
      constraints: BoxConstraints.expand(),
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => UpdateCategoriaCubit(
            categoriaService: getIt(),
            tipoCategoria: tipoCategoria,
          ),
          child: EditarCategoriaComponent(
            tipoCategoria: tipoCategoria,
            categoria: categoria,
          ),
        );
      },
    );
  }

  @override
  State<EditarCategoriaComponent> createState() =>
      _EditarCategoriaComponentState();
}

class _EditarCategoriaComponentState extends State<EditarCategoriaComponent> {
  @override
  initState() {
    Get.put(EditarCategoriaController(
      tipoCategoria: widget.tipoCategoria,
      categoria: widget.categoria,
    ));
    super.initState();
  }

  @override
  void dispose() {
    Get.find<EditarCategoriaController>().nameTextController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<EditarCategoriaController>()) {
      Get.replace(
        EditarCategoriaController(
          tipoCategoria: widget.tipoCategoria,
          categoria: widget.categoria,
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Editar categoria',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GutterLarge(),
            WithIcon(
              icon: Icons.description,
              color: Colors.grey,
              child: NameTextFieldComp(),
            ),
            MyDivider(),
            Gutter(),
            ColorFieldComp(),
            Gutter(),
            MyDivider(),
            GutterSmall(),
            IconFieldComp(),
            Gutter(),
            MyDivider(),
            Gutter(),
            if (widget.categoria.subCategorias.isNotEmpty)
              BuildSubCategorias(
                tipoCategoria: widget.tipoCategoria,
                oldCategoria: widget.categoria,
              ),
            GutterLarge(),
            FooterSectionComponent(),
          ],
        ),
      ),
    );
  }
}

class BuildSubCategorias extends StatelessWidget {
  const BuildSubCategorias({
    super.key,
    required this.tipoCategoria,
    required this.oldCategoria,
  });

  final TipoCategoria tipoCategoria;
  final Categoria oldCategoria;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<EditarCategoriaController>();

    return BlocBuilder<UpdateCategoriaCubit, UpdateCategoriaState>(
      bloc: context.read<UpdateCategoriaCubit>()..updateCategoria(oldCategoria),
      builder: (context, state) {
        if (state is UpdateCategoriaLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is UpdateCategoriaFailed) {
          return SizedBox();
        }

        late Categoria categoria = oldCategoria;
        if (state is UpdateCategoriaSuccess) {
          categoria = state.categoria;
          controller.categoria = categoria;
        }

        return Column(
          children: [
            Text(
              'Subcategorias',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ...(categoria.subCategorias
                  ..sort((a, b) => a.name.compareTo(b.name)))
                .map(
              (subCategoria) => ListTile(
                onTap: () {
                  CriarSubCategoriaPage.show(
                    context,
                    categoria,
                    tipoCategoria,
                    subCategoria,
                  ).then(
                    (value) {
                      // ignore: use_build_context_synchronously
                      context
                          .read<UpdateCategoriaCubit>()
                          .updateCategoria(oldCategoria);
                    },
                  );
                },
                title: Text(subCategoria.name),
                leading: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: categoria.color,
                    shape: BoxShape.circle,
                  ),
                ),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
          ],
        );
      },
    );
  }
}

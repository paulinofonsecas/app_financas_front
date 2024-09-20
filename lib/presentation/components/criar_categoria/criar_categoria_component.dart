// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/constants.dart';
import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/criar_categoria_cubit.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/icon_field_cubit.dart';
import 'package:app_financas/presentation/components/my_divider.dart';
import 'package:app_financas/presentation/components/with_icon.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/color_field_comp.dart';
import 'components/icon_field_comp.dart';
import 'components/name_text_field_comp.dart';

class CriarCategoriaComponent extends StatefulWidget {
  const CriarCategoriaComponent({
    super.key,
    required this.tipoCategoria,
  });

  final TipoCategoria tipoCategoria;

  static Future<dynamic> openModalBottomSheet({
    required BuildContext context,
    required TipoCategoria tipoCategoria,
  }) async {
    var size = MediaQuery.of(context).size;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      showDragHandle: true,
      useSafeArea: true,
      useRootNavigator: false,
      constraints: BoxConstraints.expand(
        height: size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CriarCategoriaCubit(getIt(), tipoCategoria),
            ),
            BlocProvider(
              create: (context) => ColorFieldCubit(),
            ),
            BlocProvider(
              create: (context) => IconFieldCubit(),
            ),
          ],
          child: CriarCategoriaComponent(
            tipoCategoria: tipoCategoria,
          ),
        );
      },
    );
  }

  @override
  State<CriarCategoriaComponent> createState() =>
      _CriarCategoriaComponentState();
}

class _CriarCategoriaComponentState extends State<CriarCategoriaComponent> {
  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorState = context.watch<ColorFieldCubit>().state;
    final iconState = context.watch<IconFieldCubit>().state;

    return MultiBlocListener(
      listeners: [
        BlocListener<CriarCategoriaCubit, CriarCategoriaState>(
          listener: (context, state) {
            if (state is CriarCategoriaSuccess) {
              Get.back();
            }

            if (state is CriarCategoriaError) {
              showErrorMessage('Erro', 'Erro ao criar categoria');
            }
          },
        ),
      ],
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Criar categoria',
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
                  child: NameTextFieldComp(
                    controller: _textController,
                  ),
                ),
                MyDivider(),
                Gutter(),
                ColorFieldComp(),
                Gutter(),
                MyDivider(),
                GutterSmall(),
                IconFieldComp(),
                GutterLarge(),
                GutterLarge(),
                _buildButtons(context, colorState, iconState, _formKey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildButtons(
    BuildContext context,
    ColorFieldState colorState,
    IconFieldState iconState,
    GlobalKey<FormState> formKey,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancelar',
            style: GoogleFonts.inter(
              color: Colors.grey,
            ),
          ),
        ),
        FilledButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            context.read<CriarCategoriaCubit>().cadastrarCategoria(
                  _textController.text,
                  colorState.color,
                  iconState.icon,
                );
          },
          child: Text(
            'Adicionar',
          ),
        ),
      ],
    );
  }
}

import 'package:app_financas/core/domain/entitys/objectivo.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/color_field_cubit.dart';
import 'package:app_financas/presentation/components/criar_categoria/cubit/icon_field_cubit.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/create_objectivo/bloc/bloc.dart';
import 'package:app_financas/presentation/modules/create_objectivo/cubit/delete_objectivo_cubit.dart';
import 'package:app_financas/presentation/modules/create_objectivo/view/pre_create_objectivo.dart';
import 'package:app_financas/presentation/modules/create_objectivo/widgets/create_objectivo_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template create_objectivo_page}
/// A description for CreateObjectivoPage
/// {@endtemplate}
class CreateObjectivoPage extends StatelessWidget {
  /// {@macro create_objectivo_page}
  const CreateObjectivoPage({super.key, required this.preObj, this.objectivo});

  final PreCreateObjModel? preObj;
  final Objectivo? objectivo;

  /// The static route for CreateObjectivoPage
  static Route<dynamic> route(
      {PreCreateObjModel? preObjectivo, Objectivo? objectivo}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => CreateObjectivoPage(
        preObj: preObjectivo,
        objectivo: objectivo,
      ),
    );
  }

  Objectivo get _getObjectivo =>
      objectivo ??
      Objectivo.empty().copyWith(
        name: preObj?.title ?? '',
        color: preObj?.color ?? Colors.transparent,
        icon: preObj?.icon ?? Icons.home,
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CreateObjectivoBloc(
            service: getIt(),
            objectivo: _getObjectivo,
          ),
        ),
        BlocProvider(
          create: (context) => DeleteObjectivoCubit(getIt()),
        ),
        BlocProvider(
          create: (context) => ColorFieldCubit(),
        ),
        BlocProvider(
          create: (context) => IconFieldCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        final isSaving =
            context.read<CreateObjectivoBloc>().state is CreateObjectivoLoading;
        final isDeleting = context.read<DeleteObjectivoCubit>().state
            is DeleteObjectivoLoading;

        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton.icon(
                onPressed: isDeleting || isSaving
                    ? null
                    : () {
                        final bloc = context.read<CreateObjectivoBloc>();
                        if (bloc.formKey.currentState!.validate()) {
                          bloc.add(SaveObjectivoEvent(bloc.objectivoModel));
                        }
                      },
                icon: const Icon(Icons.done),
                iconAlignment: IconAlignment.end,
                label: const Text('Salvar'),
              ),
              const GutterSmall(),
            ],
            title: Text(
              objectivo != null ? 'Editar objectivo' : 'Novo objectivo',
            ),
          ),
          body: const CreateObjectivoView(),
        );
      }),
    );
  }
}

/// {@template create_objectivo_view}
/// Displays the Body of CreateObjectivoView
/// {@endtemplate}
class CreateObjectivoView extends StatelessWidget {
  /// {@macro create_objectivo_view}
  const CreateObjectivoView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateObjectivoBloc, CreateObjectivoState>(
          listener: (context, state) {
            if (state is CreateObjectivoSuccess) {
              Navigator.pop(context);
            }

            if (state is CreateObjectivoError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
        ),
        BlocListener<ColorFieldCubit, ColorFieldState>(
          listener: (context, state) {
            if (state is ColorFieldSelected) {
              context.read<CreateObjectivoBloc>().objectivoModel = context
                  .read<CreateObjectivoBloc>()
                  .objectivoModel
                  .copyWith(color: state.color);
            }
          },
        ),
        BlocListener<IconFieldCubit, IconFieldState>(
          listener: (context, state) {
            if (state is IconFieldSelected) {
              context.read<CreateObjectivoBloc>().objectivoModel = context
                  .read<CreateObjectivoBloc>()
                  .objectivoModel
                  .copyWith(icon: state.icon);
            }
          },
        ),
      ],
      child: const CreateObjectivoBody(),
    );
  }
}

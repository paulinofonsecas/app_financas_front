import 'package:app_financas/score/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/cubit/cubit.dart';
import 'package:app_financas/presentation/modules/criar_sub_categoria/widgets/criar_sub_categoria_body.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/select_categoria_cubit.dart';
import 'package:app_financas/presentation/modules/registar_transacao/cubit/switch_transacao_cubit.dart';
import 'package:flutter/material.dart';

/// {@template criar_sub_categoria_page}
/// A description for CriarSubCategoriaPage
/// {@endtemplate}
class CriarSubCategoriaPage extends StatelessWidget {
  /// {@macro criar_sub_categoria_page}
  const CriarSubCategoriaPage({
    super.key,
    required this.categoria,
    required this.tipoCategoria,
    this.subCategoria,
  });

  final Categoria categoria;
  final TipoCategoria tipoCategoria;
  final Categoria? subCategoria;

  static Future<void> show(
    BuildContext context,
    Categoria categoria,
    TipoCategoria tipoCategoria, [
    Categoria? subCategoria,
  ]) =>
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        builder: (context) => CriarSubCategoriaPage(
          categoria: categoria,
          tipoCategoria: tipoCategoria,
          subCategoria: subCategoria,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CriarSubCategoriaCubit(
            categoriaService: getIt(),
            tipoCategoria: tipoCategoria,
            subCategoria: subCategoria,
          ),
        ),
        BlocProvider(
          create: (context) => SelectCategoriaCubit(categoria),
        ),
        BlocProvider(
          create: (context) => SwitchTransacaoCubit(1),
        ),
      ],
      child: CriarSubCategoriaView(categoria: categoria),
    );
  }
}

/// {@template criar_sub_categoria_view}
/// Displays the Body of CriarSubCategoriaView
/// {@endtemplate}
class CriarSubCategoriaView extends StatelessWidget {
  /// {@macro criar_sub_categoria_view}
  const CriarSubCategoriaView({super.key, required this.categoria});

  final Categoria categoria;

  @override
  Widget build(BuildContext context) {
    return CriarSubCategoriaBody(categoria: categoria);
  }
}

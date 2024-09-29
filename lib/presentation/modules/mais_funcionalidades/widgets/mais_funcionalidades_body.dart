import 'package:app_financas/core/domain/entitys/categoria_movimento.dart';
import 'package:app_financas/presentation/modules/about/view/about_app_page.dart';
import 'package:app_financas/presentation/modules/conta/view/conta_home_page.dart';
import 'package:app_financas/presentation/modules/gerir_categorias/gerir_categorias_page.dart';
import 'package:app_financas/presentation/modules/setting/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// {@template mais_funcionalidades_body}
/// Body of the MaisFuncionalidadesPage.
///
/// Add what it does
/// {@endtemplate}
class MaisFuncionalidadesBody extends StatelessWidget {
  /// {@macro mais_funcionalidades_body}
  const MaisFuncionalidadesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                GerirCategoriasPage.route(TipoCategoria.saida),
              );
            },
            title: const Text('Gerir categorias'),
            leading: const Icon(FontAwesomeIcons.bookmark),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                ContaPage.route(),
              );
            },
            title: const Text('Gerir contas'),
            leading: const Icon(FontAwesomeIcons.buildingColumns),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push(SettingsPage.route());
            },
            title: const Text('Configurações'),
            leading: const Icon(FontAwesomeIcons.gear),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.of(context).push(AboutAppPage.route());
            },
            title: const Text('Sobre'),
            leading: const Icon(FontAwesomeIcons.circleInfo),
            trailing: const Icon(Icons.chevron_right),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

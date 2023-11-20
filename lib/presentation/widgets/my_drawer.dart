import 'package:app_financas/presentation/cubit/theme/app_theme_cubit.dart';
import 'package:app_financas/presentation/pages/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Center(
              child: Text('Kwanzagest'),
            ),
          ),
          ListTile(
            title: const Text('Configurações'),
            leading: const Icon(Icons.settings),
            onTap: () {
              Get.to(const SettingPage());
            },
          ),
          BlocBuilder<AppThemeCubit, AppThemeState>(
            builder: (context, state) {
              return ListTile(
                title: const Text('Alterar tema'),
                leading: Icon(
                  state.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onTap: () {
                  context.read<AppThemeCubit>().toggleTheme();
                },
              );
            },
          )
        ],
      ),
    );
  }
}

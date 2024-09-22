import 'package:app_financas/presentation/modules/setting/cubit/change_theme_color_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsBody extends HookWidget {
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Geral'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              value: const Text('English'),
            ),
            SettingsTile.navigation(
              onPressed: (_) {
                _showColorPicker(context);
              },
              leading: const Icon(Icons.format_paint),
              title: const Text('Alterar tema'),
              value: Container(
                width: 40,
                height: 20,
                decoration: BoxDecoration(
                  color: context.watch<ChangeThemeColorCubit>().state.color,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Planejamento'),
          tiles: <SettingsTile>[
            SettingsTile.switchTile(
              initialValue: true,
              onToggle: (value) {},
              leading: const Icon(FontAwesomeIcons.listCheck),
              title: const Text('Incluir movimentos anteriores'),
            ),
          ],
        ),
        SettingsSection(
          title: const Text('Dados'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(FontAwesomeIcons.database),
              title: const Text('Deletar todos movimentos'),
            ),
            SettingsTile.navigation(
              leading: const Icon(
                FontAwesomeIcons.trashCan,
                color: Colors.red,
              ),
              title: const Text('Limpar base de dados'),
            ),
          ],
        ),
      ],
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Selecionar cor'),
        content: SingleChildScrollView(
          child: MaterialPicker(
            pickerColor: context.read<ChangeThemeColorCubit>().state.color,
            onColorChanged: (c) {
              context.read<ChangeThemeColorCubit>().changeThemeColor(c);
              Navigator.of(context).pop();
            },
            enableLabel: false, // only on portrait mode
          ),
        ),
      ),
    );
  }
}

import 'package:app_financas/app/modules/setting/setting_page.dart';
import 'package:flutter/material.dart';
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
          )
        ],
      ),
    );
  }
}

import 'package:app_financas/app/components/escolher_tipo_movimento.dart';
import 'package:app_financas/app/components/my_drawer.dart';
import 'package:app_financas/app/modules/app/controllers/app_page_controller.dart';
import 'package:app_financas/app/modules/carteira/carteira_page.dart';
import 'package:app_financas/app/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/app/modules/home/home_page.dart';
import 'package:app_financas/app/modules/setting/setting_page.dart';
import 'package:app_financas/helders/custom_show_modal_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/controllers/home_page_controller.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final AppPageController controller;
  late final List<Widget> telas;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    
    controller.setContext(context);
  }

  @override
  void initState() {
    controller = Get.put(AppPageController());

    telas = const [
      HomePage(),
      CarteiraPage(),
      Center(child: Text('Estatisticas')),
      SettingPage(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      drawer: const MyDrawer(),
      body: Obx(
        () => IndexedStack(
          index: controller.index.value,
          children: telas,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customShowModalBottomSheet(
            context,
            isScrollControlled: false,
            constraints: const BoxConstraints.tightFor(),
            child: BottomEscolherTipoMovimento(
              cloused: () {
                Get.find<HomePageController>().update(['geral']);
                Get.find<CarteiraPageController>().update(['geral']);
                Get.back(closeOverlays: true);
                setState(() {});
              },
            ),
          );
        },
        child: Icon(
          CupertinoIcons.add,
          color: Get.theme.floatingActionButtonTheme.foregroundColor,
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.index.value,
            onTap: (i) => controller.index.value = i,
            type: BottomNavigationBarType.fixed,
            useLegacyColorScheme: false,
            backgroundColor: Get.theme.bottomAppBarTheme.color,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.wallet,
                ),
                label: 'Carteira',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.timeline,
                ),
                label: 'Estatisticas',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.person_alt,
                ),
                label: 'Perfil',
              ),
            ],
          )),
    );
  }
}

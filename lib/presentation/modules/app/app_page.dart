// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/app/bloc/app_bloc.dart';
import 'package:app_financas/presentation/components/my_drawer.dart';
import 'package:app_financas/presentation/modules/app/widgets/bottom_nav_widget.dart';
import 'package:app_financas/presentation/modules/carteira/carteira_page.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/presentation/modules/home/home_page.dart';
import 'package:app_financas/presentation/modules/registar_transacao/registar_transacao.dart';
import 'package:app_financas/presentation/modules/setting/setting_page.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../estatisticas/estatisticas_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final List<Widget> telas;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    telas = [
      const HomePage(),
      const CarteiraPage(),
      const EstatisticasPage(),
      const SettingPage(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) {
        return previous.bottomNavIndex != current.bottomNavIndex;
      },
      builder: (context, navBarState) {
        return Scaffold(
          backgroundColor: context.theme.colorScheme.surface,
          drawer: const MyDrawer(),
          body: SafeArea(
            child: IndexedStack(
              index: navBarState.bottomNavIndex,
              children: telas,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton:
              canShowFAB(navBarState) ? const _CustomFAB() : null,
          bottomNavigationBar: BottomNavBar(
            index: navBarState.bottomNavIndex,
            onTap: (index) {
              context.read<AppBloc>().add(AppChangeBottomNavIndexEvent(index));
            },
          ),
        );
      },
    );
  }

  bool canShowFAB(AppState state) {
    return (state.bottomNavIndex == 0 || state.bottomNavIndex == 1);
  }
}

class _CustomFAB extends StatelessWidget {
  const _CustomFAB();

  void cloused() {
    Get.find<HomePageController>().update(['geral']);
    Get.find<CarteiraPageController>().update(['geral']);
    Get.back(closeOverlays: true);
  }

  @override
  Widget build(BuildContext context) {
    return FabCircularMenuPlus(
      alignment: Alignment.bottomCenter,
      fabOpenIcon: const Icon(Icons.add),
      fabSize: 60,
      fabCloseIcon: const Icon(Icons.close),
      fabColor: Theme.of(context).colorScheme.primaryContainer,
      ringDiameter: 500,
      ringWidth: 150,
      ringDiameterLimitFactor: 2.5,
      ringColor: Theme.of(context).colorScheme.secondaryContainer,
      animationDuration: const Duration(milliseconds: 300),
      children: <Widget>[
        TextButton.icon(
          icon: const Icon(Icons.arrow_upward),
          label: const Text('Entrada'),
          onPressed: () {
            Get.to(const RegistarTransacaoPage(
              movimentoType: 1,
            ))?.then(
              (value) {
                cloused();
              },
            );
          },
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          icon: const Icon(Icons.swap_horiz_outlined),
          label: const Text('Transferencia'),
          onPressed: null,
        ),
        TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red,
          ),
          icon: const Icon(Icons.arrow_downward),
          label: const Text('Saidas'),
          onPressed: () {
            Get.to(
              const RegistarTransacaoPage(
                movimentoType: 2,
              ),
            )?.then(
              (value) {
                cloused();
              },
            );
          },
        ),
      ],
    );
  }
}

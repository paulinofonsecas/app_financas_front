// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/app/bloc/app_bloc.dart';
import 'package:app_financas/presentation/components/escolher_tipo_movimento.dart';
import 'package:app_financas/presentation/components/my_drawer.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';
import 'package:app_financas/presentation/modules/app/widgets/bottom_nav_widget.dart';
import 'package:app_financas/presentation/modules/carteira/carteira_page.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/home/controllers/home_page_controller.dart';
import 'package:app_financas/presentation/modules/home/home_page.dart';
import 'package:app_financas/presentation/modules/mais_funcionalidades/view/mais_funcionalidades_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../estatisticas/view/estatisticas_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const AppPage());
  }

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
      const MaisFuncionalidadesPage(),
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
          // canShowFAB(navBarState) ? const CustomFAB() : null,
          floatingActionButton: FloatingActionButton(
            backgroundColor: context.theme.colorScheme.primary,
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
                  },
                ),
              );
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
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

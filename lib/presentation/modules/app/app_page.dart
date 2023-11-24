// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_financas/presentation/bloc/app/app_bloc.dart';
import 'package:app_financas/presentation/dependency/dep_injection.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_conta_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/change_tipo_movimento_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/contas_cubit.dart';
import 'package:app_financas/presentation/modules/carteira/cubit/movimentos_by_conta_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/home_page_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/last_movimentos_cubit.dart';
import 'package:app_financas/presentation/modules/movimentos/cubit/show_money_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:app_financas/presentation/components/escolher_tipo_movimento.dart';
import 'package:app_financas/presentation/components/my_drawer.dart';
import 'package:app_financas/presentation/modules/carteira/carteira_page.dart';
import 'package:app_financas/presentation/modules/carteira/controllers/carteira_page_controller.dart';
import 'package:app_financas/presentation/modules/home/home_page.dart';
import 'package:app_financas/presentation/modules/setting/setting_page.dart';
import 'package:app_financas/presentation/helders/custom_show_modal_bottom_sheet.dart';

import '../estatisticas/estatisticas_page.dart';
import '../home/controllers/home_page_controller.dart';

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
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomePageCubit(),
          ),
          BlocProvider(
            create: (context) => ListMovimentosCubit(),
          ),
          BlocProvider(
            create: (context) => ShowMoneyCubit(),
          ),
        ],
        child: const HomePage(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (c) => ContasCubit(),
          ),
          BlocProvider(
            create: (context) => locator<MovimentosByContaCubit>(),
          ),
          BlocProvider(
            create: (context) => locator<ChangeContaCubit>(),
          ),
          BlocProvider(
            create: (context) => locator<ChangeTipoMovimentoCubit>(),
          ),
        ],
        child: const CarteiraPage(),
      ),
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
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.theme.colorScheme.surface,
          drawer: const MyDrawer(),
          body: SafeArea(
            child: IndexedStack(
              index: state.bottomNavIndex,
              children: telas,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: canShowFAB(state)
              ? FloatingActionButton(
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
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .foregroundColor,
                  ),
                )
              : null,
          bottomNavigationBar: BottomNavBar(
            index: state.bottomNavIndex,
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

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  final int index;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      useLegacyColorScheme: false,
      backgroundColor: Theme.of(context).bottomAppBarTheme.color,
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
            CupertinoIcons.settings,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}

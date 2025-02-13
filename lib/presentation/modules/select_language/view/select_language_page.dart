import 'package:app_financas/presentation/modules/app/app_page.dart';
import 'package:app_financas/presentation/modules/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:app_financas/presentation/modules/select_language/cubit/cubit.dart';
import 'package:app_financas/presentation/modules/select_language/widgets/select_language_body.dart';
import 'package:flutter/material.dart';

/// {@template select_language_page}
/// A description for SelectLanguagePage
/// {@endtemplate}
class SelectLanguagePage extends StatelessWidget {
  /// {@macro select_language_page}
  const SelectLanguagePage({super.key});

  /// The static route for SelectLanguagePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const SelectLanguagePage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SelectLanguageCubit(),
        ),
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Selecione o idioma'),
          ),
          body: const SelectLanguageView(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: () async {
                await context.read<OnBoardingCubit>().setPrimeiraVez();
                if (!context.mounted) return;
                Navigator.pushReplacement(context, AppPage.route());
              },
              child: const Text('Confirmar'),
            ),
          ),
        );
      }),
    );
  }
}

/// {@template select_language_view}
/// Displays the Body of SelectLanguageView
/// {@endtemplate}
class SelectLanguageView extends StatelessWidget {
  /// {@macro select_language_view}
  const SelectLanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SelectLanguageBody();
  }
}

import 'package:app_financas/presentation/modules/app/app_page.dart';
import 'package:app_financas/presentation/modules/on_boarding/cubit/cubit.dart';
import 'package:app_financas/presentation/modules/on_boarding/widgets/on_boarding_body.dart';
import 'package:flutter/material.dart';

/// {@template on_boarding_page}
/// A description for OnBoardingPage
/// {@endtemplate}
class OnBoardingPage extends StatelessWidget {
  /// {@macro on_boarding_page}
  const OnBoardingPage({super.key});

  /// The static route for OnBoardingPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const OnBoardingPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: const Scaffold(
        body: OnBoardingView(),
      ),
    );
  }
}

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      listener: (context, state) {
        if (state is OnBoardingSettingPrimeiraVezSuccess) {
          Navigator.pushReplacement(context, AppPage.route());
        }

        if (state is OnBoardingSettingPrimeiraVezError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Ocorreu um erro ao inicializar o app'),
            ),
          );
        }

        if (state is OnBoardingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        bloc: context.read<OnBoardingCubit>()..isPrimeiraVez(),
        builder: (context, state) {
          if (state is OnBoardingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return const OnBoardingBody();
        },
      ),
    );
  }
}

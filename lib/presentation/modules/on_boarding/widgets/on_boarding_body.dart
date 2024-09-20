import 'package:app_financas/presentation/modules/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            SizedBox(
              width: double.infinity,
              height: size.height * 0.35,
              child: Image.asset('assets/imgs/on_boarding.jpg'),
            ),
            const Spacer(flex: 3),
            AutoSizeText(
              "Bem vindo ao Minhas Finanças",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const Spacer(),
            Text(
              "Gerencie suas receitas \ne despesas de form facil e prática.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.74),
              ),
            ),
            const Spacer(flex: 3),
            BlocBuilder<OnBoardingCubit, OnBoardingState>(
              builder: (context, state) {
                if (state is OnBoardingLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return FilledButton.icon(
                  onPressed: () {
                    context.read<OnBoardingCubit>().setPrimeiraVez();
                  },
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                  label: const Text("Continuar"),
                );
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

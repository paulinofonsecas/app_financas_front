// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:app_financas/constants.dart';
import 'package:app_financas/presentation/helders/helpers.dart';
import 'package:app_financas/presentation/modules/app/cubit/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Olá, bem vindo de volta',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Kwanza Gest',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              // Cupertino alert icons
              BlocBuilder<AppThemeCubit, AppThemeState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<AppThemeCubit>()
                          .toggleTheme(Theme.of(context).brightness);
                    },
                    icon: Icon(
                      !isDarkMode(context)
                          ? Icons.nightlight_round
                          : Icons.wb_sunny,
                      color: Theme.of(context).iconTheme.color,
                      size: 26,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:app_financas/presentation/modules/about/cubit/cubit.dart';
import 'package:app_financas/presentation/modules/about/widgets/about_body.dart';
import 'package:flutter/material.dart';

/// {@template about_page}
/// A description for AboutPage
/// {@endtemplate}
class AboutAppPage extends StatelessWidget {
  /// {@macro about_page}
  const AboutAppPage({super.key});

  /// The static route for AboutPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const AboutAppPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AboutCubit(),
      child: const Scaffold(
        body: AboutAppView(),
      ),
    );
  }
}

/// {@template about_view}
/// Displays the Body of AboutView
/// {@endtemplate}
class AboutAppView extends StatelessWidget {
  /// {@macro about_view}
  const AboutAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AboutBody();
  }
}

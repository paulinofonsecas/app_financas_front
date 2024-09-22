import 'package:about/about.dart';
import 'package:flutter/material.dart';

/// {@template about_body}
/// Body of the AboutPage.
///
/// Add what it does
/// {@endtemplate}
class AboutBody extends StatelessWidget {
  /// {@macro about_body}
  const AboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutPage(
      values: const {
        'version': '2.0.0',
        'year': '2024',
        'author': 'TecnoElite',
      },
      title: const Text('Sobre'),
      applicationVersion: 'Version {{ version }}',
      applicationDescription: const Text(
        'Aplicativo de gestão pessoais, para controlar sua vida'
        ' financeira de forma pratica e eficaz.',
        textAlign: TextAlign.justify,
      ),
      applicationIcon: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/imgs/launcher_icon.png',
          ),
        ),
      ),
      applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
      children: const <Widget>[
        LicensesPageListTile(
          title: Text('Open source Licenses'),
          icon: Icon(Icons.favorite),
        ),
      ],
    );
  }
}

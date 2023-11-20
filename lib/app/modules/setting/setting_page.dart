import 'package:flutter/material.dart';

import 'components/limpar_dados_component.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: const [
              SizedBox(height: 24),
              Align(
                alignment: Alignment.topCenter,
                child: LimparDadosWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

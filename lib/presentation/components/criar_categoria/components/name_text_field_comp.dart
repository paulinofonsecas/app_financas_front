import 'package:flutter/material.dart';

class NameTextFieldComp extends StatelessWidget {
  const NameTextFieldComp({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nome obrigatório';
        }

        return null;
      },
      textCapitalization: TextCapitalization.sentences,
      decoration: const InputDecoration(
        hintText: 'Nome',
        border: InputBorder.none,
      ),
    );
  }
}

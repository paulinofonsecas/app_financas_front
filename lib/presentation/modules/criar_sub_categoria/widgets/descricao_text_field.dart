import 'package:flutter/material.dart';

class DescricaoTextField extends StatelessWidget {
  const DescricaoTextField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Descrição é obrigatoria.';
        }

        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        label: const Text('Descrição'),
        icon: Icon(
          Icons.description_outlined,
          color: Colors.grey[500],
        ),
      ),
    );
  }
}

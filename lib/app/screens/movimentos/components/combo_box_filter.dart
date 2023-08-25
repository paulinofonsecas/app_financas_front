// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ComboBoxFilter extends StatefulWidget {
  const ComboBoxFilter({super.key});

  @override
  ComboBoxFilterState createState() => ComboBoxFilterState();
}

class ComboBoxFilterState extends State<ComboBoxFilter> {
  late String _selectedItem;

  final List<String> _items = [
    'Hoje',
    'Esta semana',
    'Este mês',
  ];

  @override
  void initState() {
    _selectedItem = _items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(10),
      value: _selectedItem,
      alignment: Alignment.center,
      items: _items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          alignment: Alignment.center,
          child: Text(item),
        );
      }).toList(),
      onChanged: (selectedItem) {
        setState(() {
          _selectedItem = selectedItem!;
        });
      },
      hint: Text('Selecione uma opção'),
    );
  }
}

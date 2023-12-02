import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({
    super.key,
    required this.textController,
    this.onClearTap,
  });

  final TextEditingController textController;
  final Function()? onClearTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: 'Pesquisar',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onClearTap,
        ),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? Theme.of(context).cardColor.withOpacity(.7)
            : Colors.grey.shade300,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gapPadding: 0,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          gapPadding: 0,
        ),
      ),
    );
  }
}

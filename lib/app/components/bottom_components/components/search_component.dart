import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Pesquisar',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.close),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Get.isDarkMode
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
